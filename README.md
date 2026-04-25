# At Fielt Cockpit

Dashboard en entry-punt voor alle At Fielt extensies in Trimble Connect. Klanten registreren één URL en zien één tegel in de TC-verkenner — de Cockpit laat projectdata zien en biedt doorstart naar de losse extensies (Project Dashboard, Projectinformatie toevoegen, Rechten Viewer, Documentenlijst Viewer).

## Live URL

`https://tomtietom.github.io/trimble-dashboard-project-/` — manifest op `manifest.json`.

## Lokaal ontwikkelen

Open `index.html` direct in de browser. Buiten TC-context verschijnt een foutmelding (geen token); dat is normaal. Echt testen doe je door te deployen naar GitHub Pages en te registreren in een TC-project.

## Deployen

```bash
./deploy.sh "Korte beschrijving van wijziging"
```

Bumpt automatisch `?v=<timestamp>` in `manifest.json`, commit + push. GitHub Pages rebuild 1-3 min. In TC: tab sluiten en opnieuw openen (geen gewone refresh).

## Eerste opzet hub

Zie `HUB-SETUP.md` voor de eenmalige setup-stappen (D1 INSERT + allowlist).

## Structuur

- `index.html` — single-file vanilla JS extensie (dashboard + tegels + doorstart)
- `manifest.json` — TC extensie-registratie
- `icon.png` — icoon (placeholder gekopieerd uit project-dashboard; vervang door eigen design)
- `deploy.sh` — versiebump + git push
- `HUB-SETUP.md` — eenmalige hub-registratie instructies
- `CLAUDE.md` — context voor Claude in deze repo
