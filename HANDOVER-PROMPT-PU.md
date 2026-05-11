# Handover-prompt voor PU-module fixes (atfielt-cockpit)

Plak onderstaande tekst (alles onder de regel) als prompt in de sessie waarin je de PU-module van de cockpit gaat aanpassen. Zelf-bevattend.

---

In deze sessie staat `atfielt-cockpit` open. De PU-module (Project Upload, IIFE op regel 2291-4136 in `index.html`) bevat een 3-staps file-upload flow die deels op deprecated endpoints draait en een potentieel silent corruption-risico heeft op de signed PUT.

Volledige review staat in:

- **PU-review**: `./REVIEW-PU-MODULE.md`
- **Algemeen cockpit-review**: `./REVIEW-vs-OpenAPI.md`
- **Spec ter referentie**: `../Trimble Connect API/openapi-spec` (YAML)

Drie P1-fixes, in volgorde van urgentie.

## Fix 1 — Verwijder Content-Type op signed PUT (hoogste prioriteit)

**Locatie**: `index.html:3994`

```javascript
xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
```

De code stuurt binary file-data (`xhr.send(item.file)`, regel 4006) maar zet de Content-Type op `application/x-www-form-urlencoded`. De spec zegt expliciet voor de signed PUT: *"no other parameters/headers required"* (`openapi-spec:2154`).

**Risico's**:
- S3/CloudFront kan de signature niet matchen en 403'en (silent failure in queue).
- Als het wel doorloopt: S3 slaat de Content-Type op in metadata. Bij download serveert S3 de file dan als URL-form, niet als binary download → corrupte files bij user.

**Actie**: **verwijder de regel 3994 volledig.** XHR stuurt dan geen Content-Type en de signed URL accepteert de PUT met default S3-gedrag. Geen vervangende header zetten.

```javascript
xhr.open('PUT', uploadUrl);
// regel 3994 wordt verwijderd
xhr.upload.onprogress = function(e) { /* bestaande progress-handler */ };
xhr.onload = function() { /* ... */ };
xhr.onerror = function() { /* ... */ };
xhr.send(item.file);
```

**Verificatie**: upload een test-file (PDF en IFC), download hem direct daarna via de TC UI. Open de gedownloade file. Vóór de fix: kan corrupt zijn. Na de fix: moet bit-voor-bit identiek zijn aan de originele upload. Check ook in browser DevTools Network-tab dat de PUT geen Content-Type header heeft.

## Fix 2 — Migreer naar `POST /files/fs/upload` (deprecated endpoints opruimen)

**Locaties**:
- `index.html:3979` (`/files/fs/initiate` POST)
- `index.html:4012` (`/files/fs/commit` POST)

Beide endpoints zijn `deprecated: true` in de spec (`openapi-spec:2148, 2223`). Opvolger: `POST /files/fs/upload` (`openapi-spec:2376-2479`), de Package File Upload API.

**Voordelen van de nieuwe API**:
- Single-part uploads hebben **geen aparte commit** nodig — de PUT van de bytes commit automatisch.
- Multipart en multi-file (filesets) zitten in dezelfde body — geen aparte flow.
- Response status `202 Accepted` met meer metadata in `FileUploadDetailsResponse`.

**Actie** — vervang in `uploadFile(item)` rond regel 3970:

```javascript
// OUD: stap 1 (initiate)
const initResp = await _puFetch('/files/fs/initiate', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json', 'x-trimbleconnect-client': 'TCWEB' },
  body: JSON.stringify({ parentId: folder.id, parentType: 'FOLDER', name: item.file.name }),
});

// NIEUW:
const qs = '?parentId=' + encodeURIComponent(folder.id) + '&parentType=FOLDER';
const initResp = await _puFetch('/files/fs/upload' + qs, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json', 'x-trimbleconnect-client': 'TCWEB' },
  body: JSON.stringify({ name: item.file.name }),
});
// Response shape: { uploadId, id (=fileId), contents: [{ uploadUrl, format, ... }] }
const contents = (initResp.contents || []);
const uploadUrl = (contents[0] && (contents[0].uploadUrl || contents[0].uploadURL))
               || initResp.uploadURL || initResp.uploadUrl;
const uploadId = initResp.uploadId || initResp.id;
const fileId = initResp.id || initResp.fileId;   // NIEUW: fileId is al hier beschikbaar
```

Daarna stap 2 (PUT) blijft hetzelfde (na Fix 1 toegepast).

**Stap 3 (commit) volledig verwijderen** — de nieuwe API commit single-part files automatisch:

```javascript
// VERWIJDEREN regel 4010-4018:
// const commitResp = await _puFetch('/files/fs/commit', {...});
// const fileId = commitResp.id || ...;
//
// `fileId` haal je nu uit initResp (zie boven).
```

Pas wel de PSet metadata-call aan (regel 4020-4044): die gebruikt `fileId`. Aangezien `fileId` nu uit `initResp` komt in plaats van `commitResp`, alleen de variabele-naam check.

**Verificatie**:
1. Upload een file. DevTools Network-tab moet tonen: 1× POST `/files/fs/upload?parentId=...&parentType=FOLDER` (status 202), 1× PUT naar signed URL (status 200), 1× POST `/psets/changeset` (status 200). **Geen** call naar `/files/fs/commit`.
2. Check in TC UI dat de file zichtbaar is in de juiste folder en dat metadata correct staat.
3. Test met 2-3 files parallel via de queue.

## Fix 3 — Maximumgrootte afdwingen of multipart implementeren

**Locatie**: `index.html` — momenteel geen file-size check anywhere.

Spec (`openapi-spec:2380`) zegt: files >5 GiB **moeten** multipart, en de signed PUT-URL voor single-part heeft een hard limit. PU doet alleen single-PUT.

**Twee opties**:

### Optie A — Zachte UI-limit (snel, pragmatisch)

Voeg in `enqueueFiles` of `_addToQueue` (zoek waar files in de queue komen) een check toe:

```javascript
const MAX_SINGLE_PART_BYTES = 1 * 1024 * 1024 * 1024; // 1 GiB veiligheidsmarge
for (const file of files) {
  if (file.size > MAX_SINGLE_PART_BYTES) {
    item.status = 'error';
    item.error = 'Bestand groter dan 1 GB — multipart upload nog niet ondersteund';
    continue;
  }
  // ... bestaande logica
}
```

Toon de limit in de UI naast de file-picker zodat users vooraf weten.

### Optie B — Multipart implementeren (groter, later)

Vereist:
- Detecteer file-size, switch naar `body: { name, contents: [{ multipart: true, size: file.size }] }`.
- Response geeft `contents[0].uploadUrls` (array van presigned URLs met `*` als part-placeholder).
- Chunk file in parts van 5-5000 MiB; PUT elk in parallel of sequentieel; bewaar `etag` per part.
- POST `/files/fs/upload/{uploadId}/complete` met header `Digest: MD5=<base64-md5>` en body `{ multipart: { upload: { parts: [{etag, part_number}, ...] } } }`.

Doe Optie B alleen als gebruikers daadwerkelijk uploads >1 GiB nodig hebben. Anders Optie A.

**Aanbeveling**: ga voor **Optie A** in deze sessie. Open een issue/note voor B als roadmap-item.

## Niet in scope

P2- en P3-bevindingen (`If-None-Match`, `tc-enable-process`, v2.1 folder-tree, upload-status polling, MD5 digest) — laat staan tenzij je tijd over hebt. Aanbeveling: alleen P1's in deze ronde.

## Commit & test

- **Eén commit per fix** met duidelijke message:
  - `Fix: remove incorrect Content-Type header on signed file PUT`
  - `Refactor: migrate file upload from deprecated initiate+commit to /files/fs/upload`
  - `UI: enforce 1 GiB upload limit until multipart support is added`
- **Push pas** nadat je in een live TC-project een upload + download round-trip hebt gedaan en de file integriteit hebt geverifieerd (MD5 of een visuele check als het een PDF/afbeelding is).
- **Rollback-plan**: bewaar de oude code in een feature-branch tot je een week productie-gebruik hebt gezien zonder upload-errors.
