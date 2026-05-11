# Handover-prompt voor de atfielt-cockpit sessie

Plak onderstaande tekst (alles onder de regel) als prompt in de sessie die je voor `atfielt-cockpit` hebt open staan. De prompt is zelf-bevattend.

---

In deze sessie staat `atfielt-cockpit` open — een Trimble Connect Workspace-API extensie (vanilla JS, single-file `index.html` van 5408 regels) die als launcher fungeert voor andere extensies, plus 4 ingebouwde modules (PD, DL, PU, RV) bevat.

We hebben in een aparte review-sessie het project tegen de officiële OpenAPI 3.0 spec van de Trimble Connect Core REST API gelegd. Het volledige review-rapport staat op:

- **Rapport**: `./REVIEW-vs-OpenAPI.md`
- **Spec ter referentie**: `../Trimble Connect API/openapi-spec` (YAML)

Er zijn vier P1-bevindingen. Beslis welke je in deze sessie aanpakt; ze zijn onafhankelijk uit te voeren.

## Fix A — Verwijder `/projects/{id}/groups` fallback (eenvoudig, zelfde als rechten-viewer)

**Locatie**: `index.html:5035`

```javascript
for (const ep of ['/groups?projectId=' + tcProject.id, '/projects/' + tcProject.id + '/groups']){
```

`/projects/{projectId}/groups` bestaat niet in de spec (alleen `/groups?projectId={id}`, spec regel 3832).

**Actie**: verwijder de tweede entry. De `for`-loop wordt dan zinloos en kan opgeruimd worden tot een directe `tcFetch` op `/groups?projectId=...`. Behoud de bestaande error-handling.

## Fix B — `/projects` zonder spec-conforme parameters

**Locaties**:
- `index.html:1418` — `tcFetchSafe('/projects?showSubProjects=true&pageSize=500', [])`
- `index.html:1981` — proxy-call met `?offset={n}&limit={n}` (PD module)

**Spec**: v2.0 `/projects` (regel 4374-4501) accepteert alleen `fullyLoaded`, `minimal`, `sort`, `include`. Niet: `showSubProjects`, `pageSize`, `offset`, `limit`. Server kan stilzwijgend negeren → alleen eerste page → ontbrekende projecten in UI.

**Actie**:
- Regel 1418: vervang `?pageSize=500` door een Range-header pagination loop. Of switch naar v2.1 `/2.1/projects` (cursor, max pageSize=50). Voor de dashboard-stat "aantal projecten" is een single Range-call (`Range: items=0-499`) doorgaans genoeg.
- Regel 1981 (PD module via proxy): vervang `offset`/`limit` query door `Range: items=<start>-<end>` header en parse `Content-Range` voor de loop-conditie. Patroon staat al in dezelfde file op regel 1997-2004 (`fetchUsersForProject`) — die kun je hergebruiken.
- Voor `showSubProjects=true`: check of dat überhaupt nog nodig is. Zo niet, verwijder. Zo ja, raadpleeg de skill (`/Users/Tom1/.claude/skills/trimble-connect-api`) of live docs voor de spec-conforme manier.

## Fix C — `/todos`, `/projects/{id}/todos`, `/issues`, `/projects/{id}/issues` bestaan niet in Core API

**Locatie**: `index.html:1614-1635` (`fetchTodosMulti`)

Geen van deze vier paden staan in de Core API spec. Todos en issues zitten in Trimble's **Topics API** (BCF-compatible), een aparte service met eigen base-URL.

**Actie** — kies één van drie:

1. **Tijdelijk uitschakelen** (snel): commentaar de aanroep van `fetchTodosMulti` (zoek het in regel 1421) en de bijbehorende UI-tegel/badge. Geen misleidende "0 todos".

2. **Topics API implementeren** (groter): raadpleeg `/Users/Tom1/.claude/skills/trimble-connect-api/references/` voor een topics-reference, of fetch live `developer.trimble.com/docs/connect/topics-api`. Verwacht endpoint-vorm: `GET /projects/{projectId}/topics` op een aparte base. Hergebruik TID-token.

3. **In-app waarschuwing**: laat de tegel staan maar toon "Todos niet beschikbaar in deze omgeving" wanneer alle fallbacks 404 geven.

Aanbeveling: optie 1 als je nu geen tijd hebt voor Topics API. Maak dan wel een TODO-issue (in een tracker, niet in code) voor optie 2.

## Fix D — `/shares?projectId=` mogelijk niet-bestaand

**Locatie**: `index.html:1423`

`/shares` staat niet in de Core API spec. Onbekend of het wel een interne/legacy endpoint is dat werkt.

**Actie**:
1. Test eerst met `curl` of een browser DevTools-test of `https://app21.connect.trimble.com/tc/api/2.0/shares?projectId={id}` daadwerkelijk een response geeft. Gebruik daarvoor een geldig Bearer-token uit een actieve TC sessie (DevTools → Application → Cookies → `tc.t` of via Workspace API call).
2. Als 200: laat staan, voeg een kanttekening toe in de code dat dit een undocumented endpoint is. Werkt het via verplichte Range-header? Test ook dat.
3. Als 404: verwijder de aanroep en de gerelateerde UI-tegel.

## Verificatie

- **Fix A**: console toont geen `404` voor `/projects/.../groups` meer.
- **Fix B**: open een account met >50 projecten en check dat de "Alle projecten"-tegel het correcte aantal toont, niet een afgekapt getal. In de PD-module multi-region tab moeten alle regio's correct itereren tot Content-Range total.
- **Fix C**: afhankelijk van gekozen optie, ofwel verdwijnt de tegel ofwel verschijnt een duidelijke melding.
- **Fix D**: shares-tegel toont realistische data of verdwijnt.

## Niet in scope

P2- en P3-bevindingen (`pageSize` op v2.0 folders, proxy-paden via tcFetch, AP2 region) — afhankelijk van je beschikbare tijd. Aanbeveling: doe A en B in deze ronde, plan C en D in een aparte sessie.

Maak één commit per fix. Push pas na bevestiging dat de cockpit nog correct laadt in een live project per regio.
