# At Fielt Cockpit — Release Notes

---

## Versie 1.4 — 20 augustus 2026

### Snelle verbeteringen op basis van klant-feedback

Vier concrete verzoeken opgepakt na de v1.3-release, vooral van de werkvoorbereiders van VolkerWessels.

**Wat is er veranderd?**

- **Meerdere rijen selecteren met shift+klik** — klik checkbox rij 3, shift+klik rij 12: alle acht rijen ertussen aangevinkt. Werkt zoals in Verkenner of Excel; ook bij groepering en mappenboom-weergave.
- **Filter op meerdere waarden per kolom** — de filter-knop (Status, Fase, Discipline, etc.) opent nu een popover met checkboxes. Vink meerdere waarden aan (bv. *Concept + Definitief*) of gebruik de **Uitzonderen**-toggle voor "alles behalve X" (bv. alles behalve Vervallen). Knop toont het aantal actieve waarden.
- **Klikbare links in Excel-export** — bestandsnaam-cellen in de gedownloade `.xlsx` zijn nu blauwe hyperlinks (via `=HYPERLINK()`-formule voor correcte Excel-styling). Klik in Excel op de bestandsnaam → opent Trimble Connect met dat exacte document. Ideaal voor uitvoerder-lijstjes.
- **Kolombreedte werkt in élk project** — de resize-handle tussen kolomkoppen werkt nu ook in nieuwe projecten. Onder water: eerdere versie sloeg breedtes soms op onder een tijdelijke sleutel die verloren ging bij project-wissel; nu wordt de config-sleutel pas gebruikt wanneer het project-ID volledig geladen is.
- **Resize verplaatst niet meer per ongeluk de kolom** — bij het loslaten van een resize-handle (vooral bij naar links slepen) kon de kolom soms van positie wisselen, alsof je hem verslepen wilde. Dat komt niet meer voor: na een resize wordt een korte grace-period ingelast waarbinnen een per-ongeluk-drag automatisch wordt genegeerd.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig, open opnieuw. Alle verbeteringen zijn direct beschikbaar.

**Wat volgt (op basis van dezelfde feedback):**
- Eigen Excel-template met bewaard logo + opmaak (aparte sprint — klant levert template aan)
- Klaargezette weergaves met naam (*"DO Architect"*, *"UO Aannemer"*) waarin filters + kolommen + groepering samen bewaard worden
- Publieke deel-links per document voor uitvoerders zonder Trimble Connect-account

---

## Versie 1.3 — 19 augustus 2026

### Documentenlijst voelt weer als een echte tool

Feedback van klanten (o.a. Poel BV): "de standalone versie is fijner dan in de cockpit". We hebben de hele weergave herzien met vijf gerichte fixes plus een langverwachte Excel-export.

**Wat is er veranderd?**

- **Tabel gebruikt de volle schermbreedte** — de documentenlijst zat opgesloten in een gecentreerd blok van 1100px met ~300-400px witruimte links/rechts. Nu spreidt de tabel zich uit over het hele scherm zoals in de standalone versie. Andere onderdelen (dashboard, rechten, upload) blijven gecentreerd voor leesbare cards.
- **Standaard kolommen aangepast** — was: Bestandsnaam, Status, Discipline, Fase, Versie, Gewijzigd, Bestandslocatie (technische velden). Nu: Bestandsnaam, Documentnummer, Titel, Revisie, Documentdatum, Status, Bedrijf (document-identificatie zoals werkvoorbereiders scannen). Wie eigen kolommen had opgeslagen via "Opslaan voor project" blijft die zien — kan via Kolommen → Standaard herstellen naar de nieuwe set.
- **Kolomkoppen in At Fielt-huisstijl** — Montserrat font, hoofdletters, oranje 2px onderrand. Herkenbaar als At Fielt-tool.
- **Gekleurde status-labels** — 🟢 groen voor Definitief, 🟠 oranje voor Uitvoerings\*, ⚪ grijs voor Concept, 🔴 rood voor Vervallen. Sneller te scannen dan platte tekst.
- **Rustige rijen** — elke rij dezelfde hoogte, geen wrappende tekst, zachte hover-kleur (was fel oranje).
- **Voetregel met tellingen** onder de tabel: "X van Y documenten" + link-hint + Vernieuwen + Excel-export knop.

### 📊 Excel-export met huidige weergave

Nieuwe **Excel**-knop bovenaan (en in de voetregel). Één klik → download `.xlsx` met precies wat je op scherm hebt:

- **Kolommen** = de kolommen die je zichtbaar hebt gemaakt, in jouw volgorde
- **Rijen** = alle zichtbare rijen na filters en zoek. Heb je vinkjes aan? Dan alleen de geselecteerde
- **Groepering behouden** — als je in de app groepeert op bv. Discipline, krijgt Excel tussenkoppen `━━━ ARCHITECT (152 documenten) ━━━` en witregels tussen groepen
- **Excel-features aan**: kolombreedtes automatisch, header-rij bevroren, auto-filter aan
- **Bestandsnaam**: `documentenlijst_[projectnaam]_[datum].xlsx`

### Onder de motorkap

Extra betrouwbaarheidsfixes gebaseerd op klant-incidenten:
- Dubbele bestanden in de folder-boom worden nu correct ontdubbeld (loste Poel BV melding op: "Marco ziet 182 files, admin 180")
- Folders waar een gebruiker geen leesrechten voor heeft worden vastgelegd (voor toekomstige diagnose-knop)
- Release-download vindt nu correcte map-prefix als bestandsnamen dubbel voorkomen (ipv willekeurig kiezen)

### Wat moet je doen?

Sluit Trimble Connect één keer volledig (alle tabs), open opnieuw. De nieuwe weergave verschijnt direct.

Als je eigen kolommen had opgeslagen als "project-standaard" en de nieuwe set wilt zien: Kolommen → Standaard herstellen. Bevalt de nieuwe set voor je hele team? Klik dan de oranje knop "Opslaan voor project" om die als nieuwe default vast te leggen.

---

## Versie 1.2 — 21 mei 2026

### Documentenlijst toont nu altijd de actuele metadata

**Wat was het probleem?**
De documentenlijst kon soms een oudere versie van metadata-velden tonen dan wat in Trimble Connect zelf zichtbaar was. Als je in TC of in de Documentenlijst een veld als Status of Titel wijzigde, leek die wijziging soms te verdwijnen na een tab-restart — terwijl de gegevens in TC zelf wel correct waren bijgewerkt. Het hielp niet om op ↻ Vernieuwen te klikken, want dezelfde foute waarde kwam steeds terug.

**Wat is er veranderd?**
Trimble Connect bewaart per bestand een historie van alle wijzigingen aan metadata-velden. We bleken al die tijd de eerste (= oudste) versie uit die historie te lezen, in plaats van de meest recente. Vanaf nu lezen we altijd de nieuwste versie. Dit raakt alle bestanden die ooit zijn bewerkt — in een groot project kan dat honderden documenten zijn.

**Hoe zie je dat?**
- Na een TC-tab restart toont de Documentenlijst direct de juiste metadata, zonder ↻ Vernieuwen
- Wijzigingen die je in TC's eigen schermen maakt verschijnen na tab-restart in de Documentenlijst
- Eigen wijzigingen via de Documentenlijst blijven correct staan na refresh
- Geen "Cache wissen" meer nodig om vastzittende waarden los te krijgen

**Wat moet je doen?**
Niets bijzonders — sluit Trimble Connect één keer volledig (alle tabbladen) en open opnieuw. De Documentenlijst toont vanaf dat moment alle waarden correct.

---

## Versie 1.1 — 11 mei 2026

### Extensies laden vooraf — geen wachttijd meer na klik

**Wat was het probleem?**
Wanneer je een tegel op het cockpit-dashboard klikte (bv. Documentenlijst of Rechten Viewer), begon de extensie pas op dat moment data op te halen bij Trimble Connect. Bij grote projecten betekende dat 5-15 seconden wachten met een lege weergave. Klikte je daarna naar een andere extensie, begon dat wachten opnieuw.

**Wat is er veranderd?**
Zodra de cockpit opent en je het dashboard ziet, begint de cockpit op de achtergrond alle vier extensies vooraf te laden — in vaste volgorde, eentje tegelijk: eerst Upload, dan Documentenlijst, dan Rechten Viewer, als laatste Project Dashboard. Tegen de tijd dat je een tegel klikt, staan de gegevens vaak al klaar en springt de weergave direct in beeld.

**Hoe zie je dat?**
- Tegels die nog laden: lichtgrijs met een draaiend cirkeltje en een blauw balkje onderaan
- Tegels die klaar zijn: scherp in beeld met een vetgedrukte teller (bv. "786 mappen klaar")
- Live voortgang waar mogelijk — bij Documentenlijst zie je bijvoorbeeld "120/754 docs…" tellen tijdens metadata-scan

**Wat als ik geen toegang heb tot een extensie?**
Tegels van extensies waarvoor je geen licentie hebt, worden overgeslagen tijdens het voorladen. Die blijven uitgegrijsd zoals voorheen.

**Wat als de cockpit slecht internet heeft?**
Als een extensie niet kan laden, krijgt de tegel een waarschuwing "⚠ klik om opnieuw" in oranje. Een klik op de tegel start de poging opnieuw.

---

## Versie 1.0 — april 2026

Eerste publieke versie van de At Fielt Cockpit. Eén Trimble Connect-extensie waarin alle vier At Fielt extensies samenkomen.

- Dashboard-landing met project-stats, recente activiteit, uploads, releases, todos en favorieten
- Vier tegels voor Project Dashboard, Documentenlijst Viewer, Rechten Viewer en Projectinformatie toevoegen — klik opent de extensie binnen dezelfde cockpit (geen TC-popup meer)
- Persistente top-balk met snel-schakelaars tussen extensies
- Per-extensie toegangscontrole via de At Fielt Hub — alleen extensies waarvoor de klant betaalt zijn klikbaar
- Bij hub-storing krijgt geen enkele extensie toegang (fail-closed, voorkomt licentielek)
- Alle vier extensies draaien inline in de cockpit zonder iframe-navigatie tussen verschillende URL's

---

## Testomgevingen

Live geverifieerd in:
- **Grip op projectinformatie** (klein project: 26 docs, 9 mappen, 72 projecten in regio)
- **DigitaalBouwen@VolkerWessels** (groot project: 860 docs, 786 mappen, 92 groepen, 44 gebruikers)

## Disclaimer

Deze tool is ontwikkeld door At Fielt als hulpmiddel om Trimble Connect efficiënter te gebruiken. Gebruik is op eigen risico — controleer belangrijke acties altijd ook in Trimble Connect zelf.
