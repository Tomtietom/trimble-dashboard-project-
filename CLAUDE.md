# At Fielt Cockpit — repo context

## Wat is dit

Single-file Trimble Connect extensie die als **dashboard / entry-punt** fungeert voor de overige 4 At Fielt extensies. Doel: klant registreert alleen deze Cockpit-URL in TC en ziet 1 tegel in de verkenner; van daaruit doorstarten naar Project Dashboard, Upload, Rechten Viewer of Documentenlijst.

## Hoe de doorstart werkt

Tegel-click → `window.location.href = <oude-extensie-url>?from=cockpit`. Het TC-iframe herlaadt naar de andere extensie, die normaal initialiseert met TC-token en hub-check. De `?from=cockpit` param is een hint zodat de andere extensie optioneel een "← Cockpit"-link kan tonen (niet verplicht, oude extensies werken ongewijzigd).

## Slug in de hub

`cockpit` — moet als rij bestaan in `extensions` tabel van de hub-database en minimaal één allowlist-regel hebben. Zie `HUB-INTEGRATION.md` in de hub-repo.

## Kritieke regels

- **Script-tag volgorde** in `<head>`: eerst Trimble Workspace API, dan `hub/client.js`, dan stylesheet. Niet omdraaien.
- **Hub-check** moet VOOR elke echte data-fetch gebeuren, NADAT token binnen is. Bij weigering stopt de app via exception — dat is expres (fail-closed).
- **menuDef.title** in `init()` moet matchen met `title` in `manifest.json`.
- **Oude extensie-URLs** staan hardcoded in de `EXTENSIONS` constant bovenaan de JS. Bij verhuis updaten + deployen.

## Deploy

```bash
./deploy.sh "Korte beschrijving van wijziging"
```

Bumpt automatisch `?v=<timestamp>` in `manifest.json`, committed en pushed. GitHub Pages rebuild 1-3 min. Klant moet TC-tab sluiten en opnieuw openen om cache te legen.

## Verificatie

Na deploy: open Cockpit in TC → console (F12) moet tonen:
- `[TC] Project: <naam>`
- `[TC] Token OK, lengte: <getal>`
- `[Hub] Toegang verleend voor <email>`

Zo niet, zie `HUB-INTEGRATION.md` → Noodprocedure in de hub-repo.

## Gerelateerde repos

- `atfielt-extension-hub` — hub/auth infra (Cloudflare Worker + D1)
- `trimble-project-dashboard` — doorstart-target 1
- `trimble-project-upload` — doorstart-target 2
- `trimble-rechten-viewer` — doorstart-target 3
- `tc-viewer` (Documentenlijst) — doorstart-target 4
