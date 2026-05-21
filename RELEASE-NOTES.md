# At Fielt Cockpit — Release Notes

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
