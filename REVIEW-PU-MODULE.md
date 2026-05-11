# Review PU-module (Project Upload) vs Trimble Connect OpenAPI spec

**Spec**: `../Trimble Connect API/openapi-spec` (OpenAPI 3.0, v2.0/v2.1)
**Reviewed**: PU-module IIFE in `atfielt-cockpit/index.html`, regels 2291-4136
**Datum**: 2026-05-11
**Scope**: alleen de Project-Upload module — algemene cockpit-bevindingen staan in `REVIEW-vs-OpenAPI.md`

## Samenvatting

De 3-staps upload-flow werkt functioneel, maar gebruikt **deprecated endpoints** uit de spec en heeft een **CORS/integriteit-risico** op de signed PUT door een onjuiste Content-Type-header. Daarnaast ontbreekt multipart support (files >5 GiB), idempotency-bescherming tegen duplicates, en upload-expiry awareness. Drie P1's, drie P2's.

## Bevindingen (gerangschikt)

### P1 — Foutieve `Content-Type` op signed PUT (S3/CloudFront kan weigeren of corrupt opslaan)

**Locatie**: `index.html:3990-4007`

```javascript
xhr.open('PUT', uploadUrl);
xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
// ...
xhr.send(item.file);   // ← binary File, géén URL-encoded body
```

**Spec**: `openapi-spec:2154` zegt letterlijk voor de signed PUT:
> *"Upload the content with the presigned url obtained from the Response of this API. Use PUT on the url from the Response to upload file content (**no other parameters/headers required**)"*

**Risico**:
- De Trimble signed URL is een AWS S3/CloudFront URL met een policy die typisch alleen de PUT-method toestaat en **géén custom headers**. Een afwijkende Content-Type kan tot `403 SignatureDoesNotMatch` leiden.
- Als de URL Content-Type wél accepteert, wordt deze opgeslagen in S3 metadata. Bij download serveert S3 de file dan als `application/x-www-form-urlencoded` — wat browsers triggert om de bytes te decoderen als URL-form, niet te behandelen als binary download.
- Beide scenarios zijn zichtbaar als "upload werkt soms wel, soms niet" of "downloaded file is corrupt".

**Fix**: laat de header weg. XHR zal dan geen Content-Type sturen, of valt terug op de default (`application/octet-stream` voor Blob). Dat is exact wat de spec wil.

```javascript
xhr.open('PUT', uploadUrl);
// GEEN setRequestHeader('Content-Type', ...) hier
xhr.upload.onprogress = function(e) { /* ... */ };
xhr.send(item.file);
```

**Spec-detail**: bij multipart-uploads (P1 #3) kan een Content-Type wel nodig zijn afhankelijk van de signed URL — dat is dan dictated by de presigned URL policy. Vuistregel: alleen headers zetten die de spec/initiate-response je expliciet teruggeeft.

---

### P1 — Endpoints `/files/fs/initiate` en `/files/fs/commit` zijn deprecated

**Locaties**:
- `index.html:3979` — `POST /files/fs/initiate`
- `index.html:4012` — `POST /files/fs/commit`

**Spec**:
- `openapi-spec:2223` markeert `/files/fs/initiate` POST als `deprecated: true`.
- `openapi-spec:2148` markeert `/files/fs/commit` POST als `deprecated: true`.
- `openapi-spec:2154` zegt: *"**This API functionality is now supported by Package File Upload API**"*.

**Opvolger**: `POST /files/fs/upload` (`openapi-spec:2376-2479`), de "Package File Upload API". Verschillen:

| Aspect | Oude `/files/fs/initiate` + `/commit` | Nieuwe `/files/fs/upload` |
|---|---|---|
| `parentId`, `parentType` | in body | in **query parameters** |
| `name` | in body | in body (`FileUploadDto`) |
| Response status | `200 OK` | `202 ACCEPTED` |
| Response shape | uploadId + uploadURL | `FileUploadDetailsResponse` (zelfde velden + meer metadata) |
| Multipart | aparte flow | gewoon `contents[].multipart=true, size=...` in body |
| Multi-file (filesets) | niet ondersteund | `contents[].fileset=true` |
| Commit single-part | aparte `/files/fs/commit` POST | **niet nodig** — auto-commit na succesvolle PUT |
| Commit multipart | `/files/fs/commit` met multipart-section in body | `/files/fs/upload/{uploadId}/complete` met `Digest: MD5=...` header (`openapi-spec:2480-2538`) |
| Upload-status polling | `/files/fs/uploadstatus` (ook deprecated, `openapi-spec:2577`) | `GET /files/fs/upload?uploadId=...&wait=true` (long-polling, `openapi-spec:2326-2375`) |

**Risico**:
- Deprecated endpoints kunnen op enig moment verwijderd worden zonder waarschuwing. Trimble heeft hier al een opvolger; de termijn tot uitfaseren is onbekend.
- De nieuwe API levert meer info bij upload (multi-file packages, betere status-polling) die voor toekomstige features handig zijn (bv. progress-balk over multi-file uploads).

**Fix-aanpak** (in volgorde):

1. **Single-file PUT (huidige use-case)** — vervang stap 1+3 door één POST en geen expliciete commit:
   ```javascript
   const initBody = { name: item.file.name };
   const qs = '?parentId=' + encodeURIComponent(folder.id) +
              '&parentType=FOLDER';
   const initResp = await _puFetch('/files/fs/upload' + qs, {
     method: 'POST',
     headers: { 'Content-Type': 'application/json' },
     body: JSON.stringify(initBody),
   });
   // Response status = 202; shape:
   //   { uploadId, contents: [{ format, uploadUrl, ... }] }
   const part = (initResp.contents || [])[0] || {};
   const uploadUrl = part.uploadUrl || part.uploadURL || initResp.uploadURL;
   const fileId = initResp.id || initResp.fileId || null;
   // PUT bytes (zie P1 #1 fix) ...
   // GEEN commit voor single-part — bestand is na succesvolle PUT direct gecommit
   ```

2. **Daarna PSet metadata** zoals nu, maar gebruik `fileId` uit de upload-response (controleer veld-naam; spec voorbeeld op regel 2459-2461 verwijst naar `FileUploadDetailsResponse` schema).

3. **Multipart support** (P1 #3 hieronder) — pas integreren als de single-file flow stabiel is.

---

### P1 — Geen multipart support voor grote files (>5 GiB faalt)

**Locatie**: `index.html:3979-3987` (initiate) en `3990-4007` (PUT)

**Spec**: `openapi-spec:2380`:
> *"If the file content size is greater than 5GB, it should be uploaded as multipart. ... Each part in a multipart upload must be between 5 MiB and 5 GiB."*

**Risico**: gebruikers kunnen via de UI een file selecteren van willekeurige grootte (geen UI-check). Bij >5 GiB faalt de PUT (S3 hard-limit) of het systeem hangt op een gigantische single-PUT zonder mogelijkheid tot pauze/resume.

**Fix-strategie** — alleen aanpakken na P1 #2 (migratie naar `/files/fs/upload`):

1. Lees `item.file.size` voor de initiate.
2. Bij `size > 5 * 1024 * 1024 * 1024 * 0.95` (95% van 5 GiB als veiligheidsmarge): switch naar multipart.
3. Body: `{ name, contents: [{ multipart: true, size: item.file.size }] }`.
4. Response geeft `contents[0].uploadUrls` (array). Vervang `*` in elke URL door het partnummer.
5. PUT chunks van 5 MiB - 5 GiB per part, parallel of sequentieel.
6. Bewaar `etag` per part uit response headers.
7. `POST /files/fs/upload/{uploadId}/complete` met:
   - Header `Digest: MD5=<base64-md5-of-volledige-file>`
   - Body: lijst van `{ etag, part_number }` per part.

**Pragmatisch**: als use-case nooit files >1 GiB heeft, kun je voorlopig in de UI een file-size limit afdwingen (`if (file.size > 1e9) reject('Max 1 GB')`) en multipart pas later toevoegen. Documenteer de limiet wel zichtbaar.

---

### P2 — Geen `If-None-Match: *` om duplicate-name overwrite te voorkomen

**Locatie**: `index.html:3979` (initiate-call)

**Spec**: `openapi-spec:2182-2187` (oude initiate) en `:2418-2423` (nieuwe upload):
> *"If this header is passed with value `*` in the request the upload will fail if there is already file with same name exists in the same folder"*

**Huidige gedrag**: zonder header maakt TC stilzwijgend een nieuwe **versie** van een bestaande file met dezelfde naam in dezelfde folder. Soms gewenst, soms niet — de gebruiker krijgt geen waarschuwing.

**Fix**: maak het een UI-keuze:
- Default = silent overwrite (huidige gedrag, geen header).
- Optie "waarschuw bij duplicate" → voeg `If-None-Match: *` toe aan de POST. Response is dan 4xx bij conflict; vang dat in de queue-item af en toon "Bestaat al — vervangen?".

---

### P2 — Geen `tc-enable-process: false` voor metadata-only uploads

**Locatie**: `index.html:3979` (initiate) en `:4012` (commit)

**Spec**: `openapi-spec:2039-2044, 2402-2407`:
> *"if this value is false, it will ignore processing for this particular file and default value is: true"*

**Context**: TC doet server-side processing (thumbnails, IFC-conversie, geometry-extractie) na elke upload. Voor non-3D bestanden (PDF, Excel, dwg-zonder-viewing) is dat onnodige load — kan de upload-flow vertragen en server-resources verspillen.

**Risico**: laag, alleen ergonomie. Maar interessant voor de UX: bulk-uploads van metadata-rijke bestanden zonder 3D-content zouden sneller "klaar" zijn als processing geskipt wordt.

**Fix**: detecteer bestandsextensies waar processing nutteloos is (`.pdf`, `.xlsx`, `.docx`, etc.) en zet `tc-enable-process: false` voor die calls. Voor IFC/DWG/SKP/STEP houd je het default (`true`).

---

### P2 — Folder-tree gebruikt v2.0 `/folders/{id}/items` zonder pagination

**Locatie**: `index.html:2491` (BFS folder-recursion in `loadFolders`)

**Spec**: v2.0 `/folders/{folderId}/items` (`openapi-spec:3698-3734`) accepteert geen `pageSize` of `Range` als gedefinieerde parameter. v2.1 `/2.1/folders/{folderId}/items` heeft cursor-pagination tot 500 items per page.

**Risico**: in projecten met >500 folders binnen één parent gaat de tree-walk silent een deel missen. Voor de meeste projecten is dit geen probleem; voor enterprise-projecten wel.

**Fix**: switch naar v2.1 met skipToken-loop. Zelfde patroon als de andere modules; zie tc-viewer/`HANDOVER-PROMPT.md` voor de code. Let op dat `TC_API_BASE` op `/tc/api/2.0` eindigt — voor v2.1 moet `/2.1/` als pad-prefix.

**Code-comment in PU module** (regel 4141, "DL memo: later v2.1 porten") bevestigt dat dit op de roadmap stond.

---

### P3 — Geen upload-status polling, geen retry van PUT bij netwerk-fout

**Locaties**: `index.html:3990-4007` (PUT) en geen call naar `/files/fs/upload?uploadId=X&wait=true`.

**Spec**: `openapi-spec:2326-2375` definieert `GET /files/fs/upload` met optionele `wait=true` voor long-polling tot upload klaar is. Dit is vooral relevant na PUT om server-side processing-status te checken.

**Spec timeout**: `openapi-spec:2380`:
> *"the upload will be marked as EXPIRED if file content is not uploaded within 90 minutes for single part upload and 30 minutes for multipart upload"*

**Risico**:
- Bij intermittente netwerkfout midden in PUT (bv. WiFi-glitch) verliest de upload — geen retry. User moet de hele upload opnieuw doen.
- Bij PUT die >90 minuten duurt (slechte verbinding, grote file) verloopt het uploadId silent.

**Fix-opties**:
1. **Retry op PUT-failure**: bij `0`, `5xx`, of netwerk-abort → nieuwe initiate (verse signed URL) + nieuwe PUT. Max 2 retries.
2. **Status-check na PUT**: voor commit, doe `GET /files/fs/upload?uploadId=X&wait=true` om server-bevestiging te krijgen.
3. **Upload-expiry warning**: track tijd sinds initiate; bij >75 min toon "Upload duurt te lang, vernieuw verbinding".

---

### P3 — Geen `Digest` header bij commit (best practice voor integrity)

**Locatie**: `index.html:4012-4018` (commit-call)

**Spec**: `openapi-spec:2050-2054`:
> *"The md5 of the file is required in the **digest** header for Multipart upload commits."*

**Status**: voor single-part **niet vereist**, maar wel best practice voor integrity-check.

**Fix**: bereken `crypto.subtle.digest('MD5', ...)` op de file-bytes (vereist Web Crypto API + Blob.arrayBuffer()). Stuur als `Digest: MD5=<base64>` op de commit. Voor grote files: niet doen — MD5 hashen van 5GiB in browser kost te veel geheugen.

**Pragmatisch**: skip voor nu, alleen relevant zodra multipart geïmplementeerd wordt (waar het wél vereist is).

---

### Informatief — Wel goed gedaan

- **Robuste response-veldnaam-fallback** voor `uploadURL`/`uploadUrl`/`url`/`signedUrl` (regel 3984) en `uploadId`/`id` (regel 3985) — defensief, voorkomt breuk bij toekomstige API-respons-renames.
- **Progress-tracking via XHR.upload.onprogress** (regel 3995-3998) — fetch heeft geen native upload-progress, XHR is de juiste keuze.
- **Token-refresh mutex** `_puRefreshInFlight` — voorkomt dubbele refreshes bij parallel uploads.
- **CONCURRENCY=3** voor parallel uploads (regel 4071) — pragmatische limit.
- **PROP_UUIDS mapping** (regel 2293-2296) en metadata-rules engine — slim ontworpen voor BIM-workflow.
- **`x-trimbleconnect-client: TCWEB`** header op initiate (regel 3982) — geeft Trimble support inzicht dat dit een web-client is bij debug-tickets.
- **Folder-permission filter** `DENY_LEVELS` set (regel 2305) — voorkomt dat user kan uploaden naar folders zonder write-recht.
- **Auto-clear `done`-status items** (regel 4096) — UX-detail, houdt queue overzichtelijk.

### Buiten scope

- **PSet API** (`/psets/changeset`, `/libs/.../psets`) — niet in deze OpenAPI spec.
- **At Fielt Extension Hub config endpoint** — eigen service.

## Aanbevolen vervolgactie

1. **P1 #1** — Content-Type weglaten op signed PUT. **Eénregelig, hoogste prioriteit** (risico op silent corruption).
2. **P1 #2** — migreer naar `POST /files/fs/upload`. Beslis of je ook stap 3 (commit) elimineert nu of in een volgende ronde.
3. **P2 #1** — `If-None-Match: *` als optionele UI-keuze toevoegen ("waarschuw bij duplicate").
4. **P1 #3** — multipart support als gebruikers >1 GiB uploaden. Anders: UI-limiet zetten + later doen.
5. **P2 #3** — folder-tree v2.1 (al genoemd in code-comment regel 4141).
6. P2 #2, P3 — later, optioneel.
