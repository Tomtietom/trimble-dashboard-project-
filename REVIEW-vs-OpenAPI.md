# Review atfielt-cockpit vs Trimble Connect OpenAPI spec

**Spec**: `../Trimble Connect API/openapi-spec` (OpenAPI 3.0 Core REST API, v2.0/v2.1)
**Reviewed**: hoofdbestand `index.html` (5408 regels) — bevat 4 ingebouwde modules (PD, DL, PU, RV) plus tile-launcher
**Datum**: 2026-05-11

## Samenvatting

De cockpit is een complexe extensie met goede fundamenten (region-discovery met cache, CORS-proxy fallback, JWT refresh, mutex tegen dubbele refreshes), maar roept **meerdere endpoints aan die niet in de Core API spec staan**. Een deel daarvan zit waarschijnlijk in een aparte API (Topics API voor todos/issues), een ander deel is gewoon dead code of gebruikt verkeerde query-parameter-naam. Vier P1-bevindingen, alle direct gerelateerd aan de spec.

## Bevindingen (gerangschikt)

### P1 — `/todos` en `/issues` endpoints bestaan niet in Core API

**Locatie**: `index.html:1614-1635` (`fetchTodosMulti`)

```javascript
const candidates = [
  '/todos?projectId=' + pid + '&pageSize=20',
  '/projects/' + pid + '/todos?pageSize=20',
  '/issues?projectId=' + pid + '&pageSize=20',
  '/projects/' + pid + '/issues?pageSize=20'
];
```

**Spec**: deze paden komen **niet voor** in de Core API spec. Trimble's todos en issues zitten in de **Topics API** (BCF-compatible), die een aparte service is met eigen base-URL (typisch `https://app.connect.trimble.com/td/api/...` of vergelijkbaar, niet `/tc/api/2.0`).

**Risico**: alle vier de fallbacks falen, de loop slikt elke 404 (regel 1629-1631) en geeft uiteindelijk `null` terug. De cockpit toont dan "geen todos" — maar er kunnen wel degelijk todos in het project zijn, ze zitten alleen op een andere API. De code suggereert dat de developer al wist dat het rare API-paden zijn ("TC API is variabel") maar de juiste oplossing niet heeft gevonden.

**Fix**: switch naar de Topics API. Reference uit de skill: `trimble-connect-api/references/` heeft mogelijk een `topics-api.md` (zo niet: live fetch `developer.trimble.com/docs/connect/topics-api`). Verwacht endpoint-vorm: `GET /projects/{projectId}/topics`. Dit vereist:
- Aparte base-URL (Topics API ≠ Core API).
- Mogelijk dezelfde TID-token (te verifiëren).
- Spec/contract bevestigen.

**Tijdelijk**: als Topics API uit scope is, verwijder de hele `fetchTodosMulti` aanroep en de tegel/badge die het toont. Beter geen todos dan misleidend "geen todos".

---

### P1 — `/shares?projectId=` endpoint bestaat niet in Core API

**Locatie**: `index.html:1423`

```javascript
tcFetchSafe('/shares?projectId='+pid+'&pageSize=20', []),
```

**Spec**: geen `/shares` pad in deze spec. Mogelijk een legacy of internal endpoint, of het hoort bij een aparte service (Sharing/Distribution API).

**Risico**: identiek aan P1 #1. `tcFetchSafe` slikt errors → toont `[]` → cockpit zegt "0 shares" terwijl er meerdere kunnen bestaan.

**Fix**: verifieer of `/shares` bestaat (live `curl` met geldig token tegen `https://app.connect.trimble.com/tc/api/2.0/shares?projectId=...`). Zo niet: verwijder, of vervang door de officiële sharing-endpoint zodra die in een refresh van de spec verschijnt.

---

### P1 — `/projects` query parameters bestaan niet in v2.0 spec

**Locatie**: `index.html:1418` en `1981`

```javascript
// regel 1418 (dashboard)
tcFetchSafe('/projects?showSubProjects=true&pageSize=500', [])

// regel 1981 (PD module, via tc-proxy)
const url = PROXY_BASE_PD + '/tc/' + key + '/projects?offset=' + offset + '&limit=' + limit;
```

**Spec**: `openapi-spec:4374-4501` (v2.0 `/projects` GET) accepteert alleen:
- `fullyLoaded` (boolean)
- `minimal` (boolean)
- `sort` (string)
- `include` (string, plus Range-header verplicht als gezet)

**Niet** in de spec: `showSubProjects`, `pageSize`, `offset`, `limit`. Server kan deze stilzwijgend negeren → eerste page wordt teruggegeven → de PD-module met `offset+=items.length` werkt mogelijk wel als de server `offset` empirisch ondersteunt, maar dit is niet in de spec gegarandeerd.

**Fix**:
- Vervang `pageSize=500` door Range-header pagination: `Range: items=0-499`.
- Vervang `offset/limit` query door Range-header: `Range: items=<start>-<end>` en parse `Content-Range`.
- v2.1 `/2.1/projects` (`openapi-spec:374-510`) is een alternatief met cursor-pagination, **max pageSize=50**. Default 25.
- Voor `showSubProjects`: check de skill / live docs of er een spec-conforme manier is om subprojecten op te halen, of switch naar v2.1.

---

### P1 — `/projects/{id}/groups` fallback bestaat niet in spec (zelfde als rechten-viewer)

**Locatie**: `index.html:5035`

```javascript
for (const ep of ['/groups?projectId=' + tcProject.id, '/projects/' + tcProject.id + '/groups']){
```

**Spec**: `openapi-spec:3832-3856` — enige canonieke endpoint is `/groups?projectId={id}`. Geen `/projects/{projectId}/groups`.

**Risico**: identiek aan rechten-viewer P1 #2. Fallback faalt met 404, wordt geslikt. Dead code.

**Fix**: verwijder de tweede entry uit de array (regel 5035).

---

### P2 — `pageSize` query parameter op v2.0 `/folders/{id}/items`

**Locatie**: `index.html:1417, 3948, 4472`

```javascript
tcFetchSafe('/folders/'+rootId+'/items?pageSize=500', {items:[]})
```

**Spec**: v2.0 `/folders/{folderId}/items` (`openapi-spec:3698-3734`) accepteert alleen `folderId` (path) en `include` (query). **`pageSize` is alleen v2.1**: `/2.1/folders/{folderId}/items` (`openapi-spec:244-353`, max 500).

**Risico**: server negeert `pageSize` en geeft default page-size (≤ ~100 in praktijk). Grote folders silently afgekapt.

**Fix**: switch naar v2.1 endpoint:
```javascript
tcFetchSafe('/2.1/folders/'+rootId+'/items?pageSize=500', {items:[]})
```
Let op: `TC_API_BASE` eindigt op `/tc/api/2.0` — voor v2.1 calls moet de base `/tc/api` worden, met `/2.1/...` als pad. Dezelfde refactor als bij rechten-viewer/tc-viewer (zie `tc-viewer/index.html:tcFetchV21` patroon).

**Aanvullend**: het code-patroon `return Array.isArray(rootItems) ? rootItems : (rootItems.items || [])` (regel 1428) suggereert dat de developer al weet dat v2.0 een array geeft en v2.1 een object met `items` — wat consistent is met de spec.

---

### P2 — `tc-proxy` multi-region fetch omzeilt region-discovery

**Locatie**: `index.html:1977-1991` (`fetchProjectsForRegion` in PD module)

```javascript
const PROXY_BASE_PD = 'https://tc-proxy.tom-da0.workers.dev';
const REGION_KEYS_PD = { /* eu/us/ap */ };
const url = PROXY_BASE_PD + '/tc/' + key + '/projects?offset=...';
```

**Observatie**: de PD-module gebruikt een **Cloudflare Worker proxy** voor multi-region fetches, **niet** de centrale `TC_API_BASE` + `/regions` discovery die eerder in de file is opgezet (regel 1018-1130).

**Risico**:
- AP2 (`app32`) is niet als key in `REGION_KEYS_PD` opgenomen → AP2-projecten worden gemist.
- Proxy is een single point of failure buiten Trimble's infra (`tc-proxy.tom-da0.workers.dev` — eigen Worker).
- Geen retry/Retry-After logica via deze pad.

**Fix-opties**:
1. **Korte termijn**: voeg AP2 toe aan `REGION_KEYS_PD` (`'asia-pacific-2': 'ap2'` of vergelijkbaar).
2. **Lange termijn**: gebruik `/regions` discovery (al aanwezig op regel 1081-1125) om de volledige regio-lijst op te halen en daar overheen te itereren. Dit elimineert de hardcoded `REGION_KEYS_PD` tabel.
3. Combineer `fetchProjectsForRegion` met de centrale `tcFetch` zodra CORS-issues opgelost zijn (TC heeft `/projects` met CORS-headers in productie, dus de proxy is mogelijk overbodig).

---

### P2 — Geen 429-retry voor calls die door de proxy gaan

**Locatie**: `index.html:1982, 1998` (direct `fetch(...)`, niet via `tcFetch`)

```javascript
const r = await fetch(url, { headers: { Authorization: ..., Accept: ... } });
if (!r.ok) throw new Error('HTTP '+r.status);
```

**Observatie**: de centrale `tcFetch` (regel 2360+) heeft wel 429/5xx retry + Retry-After parsing. De proxy-paden in PD bypassen dat.

**Risico**: bij rate-limiting in multi-region fetch (5+ regio's parallel × paginatie) gaat een batch volledig stuk zonder retry.

**Fix**: route ook proxy-fetches via `tcFetch` (of een variant `tcFetchProxy` die hetzelfde retry-patroon volgt).

---

### P3 — Region fallback-tabel mist AP2

**Locatie**: `index.html:1018-1023`

```javascript
const TC_API_REGIONS = {
  europe: 'https://app21.connect.trimble.com/tc/api/2.0',
  'north america': 'https://app.connect.trimble.com/tc/api/2.0',
  asia: 'https://app31.connect.trimble.com/tc/api/2.0',
};
```

**Spec**: `openapi-spec:23-24` definieert `app32.connect.trimble.com` als "PROD AP2 region".

**Risico**: laag — de `discoverRegionBase` (regel 1081) doet `/regions` discovery en zou AP2 vanuit live data moeten oppikken. Maar als discovery faalt, valt de cockpit op deze hardcoded tabel terug en AP2-projecten openen dan een verkeerde regio.

**Fix**: voeg toe:
```javascript
'asia-pacific 2': 'https://app32.connect.trimble.com/tc/api/2.0',
```
(En verifieer wat `tcProject.location` voor AP2 retourneert — `"Asia Pacific 2"` of `"AP2"` — pas aliassen aan.)

---

### Informatief — Wel goed gedaan

- **Region discovery via `/regions`** met sessionStorage-cache (regel 1081-1125) — pattern conform spec en skill.
- **JWT exp-parsing + mutex tegen dubbele refresh** (regel 2345-2383) — best practice, beter dan rechten-viewer (geen mutex daar).
- **Event-handler op `extension.sessionInvalid`** (regel 1218) — reactief patroon dat de skill aanraadt.
- **429 Retry-After + 5xx exponential backoff** in `tcFetch` (regel 2388-2400) — standaard.
- **CORS-fallback via proxy** (regel 1127-1146) — pragmatisch.
- **`/folders/fs/{id}/permissions`** (regel 5018) — pad klopt met spec regel 3222.
- **`/projects/{id}/users` met Range-header pagination** (regel 1997-2004) — correct met `Content-Range` parsing en `start += items.length`.
- **`/libs/{libId}/psets` met cursor (`top` + `skiptoken`)** (regel 4010-4036) — buiten Core API scope (PSet API), maar wel netjes geïmplementeerd.

### Buiten scope

- **PSet API** (`/libs/...`, `/psets/...`) — niet in deze OpenAPI spec, aparte service.
- **`tc-proxy.tom-da0.workers.dev`** — eigen Cloudflare Worker.
- **At Fielt Extension Hub** (`atfielt-extension-hub.tom-da0.workers.dev`) — eigen auth-laag.

## Aanbevolen vervolgactie

1. **P1 #4** — `/projects/{id}/groups` regel 5035 verwijderen. Eenregelig, identiek aan rechten-viewer fix.
2. **P1 #3** — `pageSize=500` op `/projects` vervangen door Range-header. Of switch naar v2.1.
3. **P1 #1 + #2** — beslissen wat met todos/issues/shares. Drie opties:
   - Topics API implementeren (vereist research + nieuwe base-URL).
   - Voorlopig verwijderen + tegels uit de UI halen.
   - In-app waarschuwing "todos endpoint niet beschikbaar in jouw regio/account" tonen i.p.v. silent fail.
4. **P2 #1** — `pageSize=500` op `/folders/{id}/items` switchen naar v2.1.
5. **P2 #2 + #3** — proxy-paden via `tcFetch` routeren voor consistente retry.
6. **P3** — AP2 toevoegen aan fallback-tabel.
