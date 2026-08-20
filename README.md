# At Fielt Cockpit

Dashboard en entry-punt voor de At Fielt-suite in Trimble Connect. Klanten registreren **één** manifest-URL en zien één tegel in de TC-verkenner.

Alle vier de modules (Project Dashboard, Projectinformatie toevoegen, Rechten Viewer, Documentenlijst) draaien **inline** in dit bestand als eigen IIFE. Navigatie is een DOM view-toggle via de top-bar; er wordt niet meer naar losse extensie-URLs genavigeerd. Dat is bewust: `location.href` naar een andere geregistreerde extensie gaf een URL-mismatch en dus een TC permission-popup bij elke wissel.

De losse extensies zijn uitgefaseerd. Er is nog maar één manifest.

## Live URL

`https://tomtietom.github.io/trimble-dashboard-project-/` — manifest op `manifest.json`.

## Lokaal ontwikkelen

Open `index.html` direct in de browser. Buiten TC-context verschijnt een foutmelding (geen token); dat is normaal. Echt testen doe je door te deployen naar GitHub Pages en te registreren in een TC-project.

## Deployen

```bash
./deploy.sh "Korte beschrijving van wijziging"
```

Commit + push, en **strippt** een eventuele `?v=` uit de manifest-URL — die moet stabiel blijven, anders ziet TC een andere URL dan de geregistreerde en vraagt opnieuw om rechten. Cache-busting loopt via de meta-tags in de HTML-head. GitHub Pages rebuild duurt 1-3 min. In TC: tab volledig sluiten en opnieuw openen (geen gewone refresh).

## Structuur

- `index.html` — single-file vanilla JS extensie (dashboard + tegels + alle vier de modules inline)
- `manifest.json` — TC extensie-registratie
- `icon.svg` / `icon.png` — extensie-iconen
- `deploy.sh` — versiebump + git push
- `RELEASE-NOTES.md` — versiehistorie voor eindgebruikers
