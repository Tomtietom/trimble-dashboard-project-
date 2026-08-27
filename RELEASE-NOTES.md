# At Fielt Cockpit — Release Notes

---

## Versie 1.28 — 27 augustus 2026

### Versie-QR: groen of rood, ook zonder inloggen

De controle-pagina van versie 1.26 kon pas een oordeel geven nadat de scanner met zijn Trimble-account inlogde. Dat blijft de meest betrouwbare route, maar nu is er ook een antwoord zónder die stap.

**Wat is er veranderd?**

- **Direct groen of rood bij het scannen** — de Cockpit geeft de actuele revisie van documenten met een Versie-QR door aan de controle-pagina. Wie scant ziet daardoor meteen een oordeel, zonder in te loggen en zonder Trimble-account.
- **Nooit een misleidend groen vlak** — bij het oordeel telt hoe vers de laatste controle is. *Verouderd* blijft altijd rood: er komen alleen nieuwere versies bij. *Actueel* wordt alleen groen getoond als er in de afgelopen 24 uur nog gekeken is; is dat langer geleden, dan verschijnt oranje met "bij de laatste controle op … was dit de nieuwste versie" — zodat je weet dat je het zelf even moet nakijken in plaats van er blind op te varen.
- **Altijd het moment erbij** — op het vlak staat wanneer de controle plaatsvond ("volgens de laatste controle vandaag om 14:44").
- **Gebeurt vanzelf** — de stand wordt bijgewerkt zodra iemand van het projectteam de Documentenlijst opent. Er zijn geen extra handelingen, instellingen of Trimble-aanroepen voor nodig.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw. Bestaande QR-codes werken direct mee — opnieuw printen is niet nodig.

---

## Versie 1.27 — 27 augustus 2026

### De Excel-export voorkomt nu zelf fouten

Vervolg op het Excel terug-inlezen van versie 1.25, na de eerste testronde: het exportbestand beschermt je nu tijdens het bewerken, in plaats van fouten pas bij het inlezen te melden.

**Wat is er veranderd?**

- **Keuzevelden zijn echte keuzelijsten in Excel** — Status, Fase, Discipline en de andere keuzevelden tonen in Excel een pull-down met precies de opties uit het metadata-schema van je project. Typ je toch iets anders, dan weigert Excel het meteen.
- **Vaste kolommen zijn vergrendeld** — versie, bestandsnaam, map en andere systeemkolommen zijn niet meer aanpasbaar; alleen de metadata-cellen staan open. Filteren werkt gewoon. Wil je sorteren, hef dan eerst de bladbeveiliging op (Controleren → Beveiliging opheffen, er is geen wachtwoord) — de controle bij het inlezen blijft daarna onverminderd gelden.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw, en maak een verse export — de keuzelijsten en vergrendeling zitten in bestanden die vanaf nu geëxporteerd worden.

---

## Versie 1.26 — 27 augustus 2026

### Versie-QR scannen: groen of rood vlak, met je eigen Trimble-account

Wie op de bouwplaats een controle-ronde loopt met de Versie-QR's is meestal zelf al Trimble Connect-gebruiker. Daarom is de controle-pagina daarop ingericht — en vervalt het eerder aangekondigde aparte controle-account volledig.

**Wat is er veranderd?**

- **Groen of rood vlak** — bij het scannen kleurt de hele pagina mee: groen = print actueel, rood = verouderd (met de actuele revisie en wijzigingsdatum erbij), oranje = nog niet gecontroleerd. In één oogopslag te zien, ook buiten in de zon.
- **Inloggen met je eigen Trimble-account** — voor de live controle log je eenmalig in met je eigen account (op de telefoon wordt dat onthouden). De projectrechten gelden daarmee automatisch: wie geen toegang tot het project heeft, ziet het bestand niet. Er hoeft géén extra account meer uitgenodigd te worden — die stap is geschrapt.
- **Direct door naar de tekening** — op het vlak staat een knop **Openen in Trimble Connect** die de tekening in de TC-app of webclient opent, altijd in de nieuwste versie.

**Wat moet je doen?**
Niets aan bestaande QR's — al geprinte codes gaan automatisch mee in het nieuwe gedrag. *(De inlog-knop verschijnt zodra de eenmalige Trimble-registratie door At Fielt is afgerond.)*

---

## Versie 1.25 — 27 augustus 2026

### Metadata bewerken in Excel en veilig terug inlezen

Voor bulk-metadatawerk is Excel nu eenmaal sneller dan welke web-app ook. Daarom kan het nu allebei: exporteer de lijst, werk de metadata bij in Excel, en lees het bestand terug in. *(Aparte module — vraag naar toegang.)*

**Wat is er veranderd?**

- **📥 Excel inlezen** — nieuwe knop naast de Excel-export (werkt met de bewerkmodus aan). Kies je bewerkte export en de cockpit leest hem in.
- **Eerst controleren, dan pas schrijven** — je krijgt altijd eerst een controlescherm: welke wijzigingen zijn er gevonden, per document en per veld, met oud → nieuw. Pas na *Doorvoeren* wordt er iets naar Trimble Connect geschreven, en elke schrijfactie wordt gecontroleerd.
- **Veilig bij gelijktijdig werken** — de export onthoudt onzichtbaar zijn vertrekpunt. Cellen die jij niet aanraakte worden nóóit geschreven, ook niet als een collega ze intussen wijzigde — een oude export kan dus niemands werk terugdraaien. Wijzigden jullie allebei hetzelfde veld, dan toont het controlescherm beide waarden en kies jij bewust.
- **Alleen bestaande metadata** — de import wijzigt uitsluitend waarden van velden die het projectschema kent, op documenten die al in het project staan. Typefouten in keuzelijst-velden worden geweigerd met uitleg; onbekende kolommen en eigen notities in de Excel worden genegeerd; bestandsnaam, map en versie zijn altijd alleen-lezen.
- **Sorteren en filteren in Excel kan geen kwaad** — elke rij draagt een onzichtbaar kenmerk waarmee hij feilloos aan het juiste document wordt gekoppeld.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw. Let op: terug-inlezen werkt met exports die vanaf deze versie zijn gemaakt.

---

## Versie 1.24 — 27 augustus 2026

### Werkpakket-tellers verklaren zichzelf

Het aantal op de werkpakket-knop (de opgeslagen set) kon afwijken van het aantal in de lijst — bijvoorbeeld doordat je in de Mappen-weergave één map hebt gekozen, een filter aanstaat, of documenten uit het pakket verwijderd zijn. Dat verschil wordt nu uitgelegd in plaats van je te laten raden.

**Wat is er veranderd?**

- **Eerlijke teller op de knop** — zijn alle documenten van het pakket aanwezig, dan zie je het totaal ("Controle vloeren · 22"). Ontbreken er documenten in het project (verwijderd, of jij hebt er geen leesrechten op), dan toont de knop "19/22" met uitleg als je eroverheen beweegt.
- **Uitleg-regel boven de lijst** — zodra er verschil is tussen de opgeslagen set en wat je ziet, verschijnt een regel die het verschil uitsplitst: *"Werkpakket: 19 van 22 documenten zichtbaar — 3 verborgen door je huidige map, zoekterm of filters."*

**Wat moet je doen?**
Niets — sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.23 — 26 augustus 2026

### Werkpakketten melden nieuwe versies

Direct vervolg op de vaste werkpakketten van versie 1.22: je ziet nu meteen wat er veranderd is sinds je vorige bezoek.

**Wat is er veranderd?**

- **Melding bij het openen** — open je een vast werkpakket, dan verschijnt bovenaan een melding wanneer er sinds je vorige bezoek documenten een nieuwe versie kregen of aan het pakket zijn toegevoegd, met de datum van dat vorige bezoek erbij.
- **"Nieuw"-label per document** — de betreffende documenten zijn in de lijst gemarkeerd, zodat je in een controlerondje direct ziet waar je opnieuw naar moet kijken.
- **Teller op het dashboard** — het blok *Werkpakketten* toont een oranje "N nieuw"-badge bij pakketten waarin iets veranderd is. Openen = gezien: daarna is de teller weg tot er weer iets verandert.
- **Per persoon** — wat jij al gezien hebt staat los van wat je collega's gezien hebben; iedereen krijgt zijn eigen meldingen.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw. De eerste keer dat je een werkpakket opent wordt je vertrekpunt vastgelegd; meldingen verschijnen vanaf het bezoek daarna.

---

## Versie 1.22 — 26 augustus 2026

### Vaste werkpakketten: jouw selectie, later weer oppakken

Werkpakketten bestonden al als opgeslagen filters — handig, maar de inhoud beweegt mee met de metadata. Soms wil je juist een váste set: *deze* dertig tekeningen zijn mijn controlerondje, en daar wil ik morgen mee verder. Als een release, maar open.

**Wat is er veranderd?**

- **Selectie opslaan als werkpakket** — vink documenten aan en klik op **📁 Werkpakket** in de selectiebalk. Geef het pakket een naam (*"Controle vloeren"*) en kies: alleen voor jou, of gedeeld met het hele project (dat laatste kan alleen een projectbeheerder). Vaste werkpakketten herken je overal aan de 📌 met het aantal documenten erbij.
- **Later weer oppakken** — via de Weergaves-knop of het blok *Werkpakketten* op het dashboard. De lijst toont dan precies jouw set — en zoeken, filteren en groeperen werken daarbinnen gewoon.
- **Set aanpassen** — selecteer extra documenten en voeg ze via 📁 toe aan een bestaand pakket, of haal geselecteerde documenten eruit met **➖ Uit werkpakket** (de bestanden zelf blijven natuurlijk gewoon in het project). Met *Losmaken* keer je terug naar de volledige lijst.
- **Nieuwe versies doen automatisch mee** — het pakket volgt het document, niet de versie. Upload iemand een nieuwe versie van een tekening in je pakket, dan zie je die meteen.
- **Alles werkt ermee samen** — promoveer een vast werkpakket naar een release (pakt de nieuwste versies), genereer er Versie-QR's voor, of download de set als ZIP.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.21 — 26 augustus 2026

### Rechten Viewer: uitgezette overerving en uitgesloten groepen worden weer gerespecteerd

Bij het natrekken van de vorige versie kwamen twee gebreken naar boven die daarvóór verborgen zaten: zolang er helemaal niets overgeërfd werd, viel niet op dat de Rechten Viewer twee soorten uitzonderingen negeerde. Nu versie 1.19 de overerving wél doorvoert, werden ze zichtbaar — en meteen opgelost. Belangrijk, want in beide gevallen liet de viewer **méér** toegang zien dan mensen werkelijk hebben.

**Wat is er veranderd?**

- **"Overerving uit" telt weer mee** — zet je in Trimble Connect bij een map de overerving uit (in het rechtenoverzicht de kolom *Overgenomen: Nee*), dan hoort die map de rechten van de bovenliggende map juist **niet** te krijgen. De Rechten Viewer las die schakelaar op de verkeerde plek uit en negeerde hem daardoor. In een doorsnee project raakt dat al snel een handvol hoofdmappen — die toonden ten onrechte leesrecht voor iedereen.
- **Expliciet uitgesloten blijft uitgesloten** — staat een groep bij een map op *Geen toegang*, dan wint dat nu van een leesrecht dat via de projectstandaard binnenkomt. Voorheen kreeg zo'n map alsnog het label *Lezen*, waardoor het uitsluiten van een groep in de praktijk geen effect leek te hebben.

**Waar let je op bij het controleren?** Vergelijk een paar mappen met het rechtenoverzicht van Trimble Connect zelf (*Instellingen → Overzicht van rechten*). Mappen met *Overgenomen: Nee* horen in de Rechten Viewer op *Geen toegang* te staan, tenzij daar eigen rechten zijn ingesteld.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.20 — 24 augustus 2026

### Dashboard-tegels: korte omschrijving, nieuwe volgorde, en zichtbare laad-status

De tegels op het dashboard toonden alleen een titel plus een klein stat-regeltje. Wie de cockpit voor het eerst opende, moest zelf raden wat elke module deed. Ook was het onderscheid tussen *"aan het laden"* en *"klaar voor gebruik"* subtiel — een lichte spinner in de stat-regel en wat vervaagde tekst. Drie kleine verbeteringen op één plek:

- **Korte omschrijving onder de titel** — elke tegel toont nu in één zin wat de module doet. Bijvoorbeeld: *"Bestanden uploaden met metadata; neemt bij een nieuwe versie de eerdere metadata over"* onder **Upload**, of *"Versie-QR op de tekening en QR-codes per kopersmap"* onder **QR-codes**.
- **Volgorde afgestemd op de dagelijkse werkstroom** — Upload → Documentenlijst → Rechten → Project Dashboard → QR-codes. De achtergrondlaadvolgorde blijft ongewijzigd (licht → zwaar), alleen wat je op het dashboard ziet is nu logischer voor de meeste gebruikers.
- **Donker-oranje tegel tijdens laden** — een tegel die nog data ophaalt is nu een vol oranje blok met witte tekst en een lopende voortgangsbalk onderaan. Zodra hij klaar is, wordt hij weer wit met de gewone tellers. Je ziet daardoor direct welke tegels je al kunt aanklikken en welke nog even wachten.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.19 — 24 augustus 2026

### Rechten Viewer: overgenomen leesrechten nu ook zichtbaar per groep en gebruiker

Directe vervolg op versie 1.10. Marco liet ons weten dat overgenomen leesrechten wél zichtbaar waren in het tabblad *Mappen*, maar níét als je in *Groepen* of *Gebruikers* een specifieke groep of gebruiker koos: daar bleef bij vrijwel elke map *Geen toegang* staan, zelfs bovenaan het project. Nu opgelost.

**Wat is er veranderd?**

- **Kies je in *Groepen* of *Gebruikers* iemand?** Dan verschijnt op mappen die hun leesrecht van de projectstandaard erven (*Alle projectleden → alleen-lezen*) voortaan het label **Lezen**, met *(via Alle projectleden)* in de tooltip. Volledige-toegang op de map zelf blijft groen, expliciet uitgesloten blijft *Geblokkeerd*, en mappen waar de overerving in Trimble Connect zelf is uitgezet blijven *Geen toegang*.
- **Waarom ging het eerder mis?** Trimble Connect schrijft *Alle projectleden* intern als `tc-groups:*`; de Rechten Viewer herkende in versie 1.10 alleen de kortere schrijfwijze `*`. Daardoor kwam de groep als raw code in de gegevens terecht — de mappen-teller telde 'm nog wél, maar het per-groep- en per-gebruiker-overzicht zocht naar de vertaalde naam en vond niks.
- **Diagnose-knop uitgebreid** — de Diagnose in de footer geeft nu ook per project de rauwe toegangsregels van de projectroot terug plus een `hasAllProjectMembersOnRoot`-teller. Handig als er opnieuw een onbekende Trimble-conventie opduikt: één klik op Kopiëren en we hebben de fix binnen één iteratie te pakken.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.18 — 24 augustus 2026

### Zojuist geüploade bestanden verschijnen direct onder "Gewijzigd: vandaag"

Meteen na een upload of een nieuwe versie stond het bestand vaak nog niet in het periode-filter (*Gewijzigd: vandaag*, *laatste 7 dagen*, *laatste 30 dagen*). Reden: Trimble Connect's mappen-endpoint werkt de wijzigingsdatum van een bestand pas 1-2 minuten na de upload bij (server-side eventual consistency). Zelfs een ↻ Vernieuwen hielp niet — de cockpit kreeg gewoon dezelfde oude datum terug van Trimble.

**Wat is er veranderd?**

- **De uploader meldt nu welke bestanden er net binnen zijn** — het `cockpit:upload-done`-signaal draagt vanaf deze versie de fileIds mee (was: alleen aantal + bytes).
- **De documentenlijst vangt die op in een kort-durende buffer** — voor elk net-geüpload bestand wordt lokaal onthouden dat het op tijdstip X binnenkwam. Bij elke lijst-laad wordt de wijzigingsdatum van dat bestand overschreven met dat tijdstip, zolang Trimble Connect nog een oudere datum teruggeeft. Buffer verloopt na 5 minuten — daarna wint Trimble weer.
- **Werkt voor beide gevallen** — nieuwe versie van een bestaand bestand (zelfde fileId, andere modifiedOn) én een compleet nieuw bestand (nieuw record in de lijst na de reload).
- **Zelfde patroon als de bestaande PSet-save-buffer** — voor metadata-wijzigingen bestond deze anti-stale-truc al (3 min TTL). Nu is de dekking compleet.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.17 — 24 augustus 2026

### Deel-links intrekken vanaf het dashboard

Trimble heeft de eigen shares-beheerpagina uit de webclient gehaald; deel-links beheren kan daar alleen nog via de algemene activiteitenstroom. Daarom kan het nu rechtstreeks in de cockpit.

**Wat is er veranderd?**

- **Intrekken met één klik** — elke regel in het dashboard-blok *Open shares* heeft nu een ✕-knop. Na een duidelijke bevestiging (ontvangers verliezen direct toegang, ook bij een link met meerdere bestanden) wordt de link ingetrokken.
- **Met controle dat de link echt dood is** — na het intrekken controleert de cockpit bij Trimble Connect of de link werkelijk weg is. Pas dan verdwijnt de regel; mislukt er iets, dan zie je dat meteen.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.16 — 24 augustus 2026

### Versie-QR verfijnd: precies positioneren, zien wat al een QR heeft, en de werkpakket-route

Drie verbeteringen uit de eerste praktijktest van de Versie-QR.

**De stempel staat nu precies waar jij hem wilt**

- **📐 Positie bepalen** — nieuw in de Versie-QR-dialoog: de eerste pagina van je tekening wordt getoond en je **sleept** het QR-blok naar de juiste plek (naast het titelblok, in een leeg hoekje — waar je maar wilt). De positie wordt als afstand tot de dichtstbijzijnde hoek onthouden en werkt daardoor ook op andere papierformaten in dezelfde set.
- **Groter en beter leesbaar** — de formaten zijn nu 20 tot 50 mm (standaard 30 mm); op A0/A1 is de code daarmee vanaf de muur scanbaar. Eerder gekozen instellingen worden automatisch omgezet.

**Je ziet nu welke documenten een QR hebben**

- Nieuwe kolom **Versie-QR** in de documentenlijst (aan te zetten via Kolommen): een groene badge *🏷 rev 3* betekent "QR geprint op revisie 3, nog actueel"; wordt er een nieuwere versie geüpload dan kleurt de badge rood met ⚠ — tijd om opnieuw te printen. De badge toont ook wanneer de QR is gemaakt en hoe vaak hij gescand is.
- In de Versie-QR-dialoog zie je per selectie direct "N van M heeft al een QR".

**De zuivere route: werkpakket → QR's → release**

- Kies in de Versie-QR-dialoog als **Bron** een werkpakket (bijvoorbeeld *"UO Aannemer"*) in plaats van een handmatige selectie — of start direct via het nieuwe **🏷️** bij een werkpakket onder Weergaves.
- Na het genereren staat er een knop **📦 Naar release**: dezelfde documenten gaan in één keer een release in, vastgepind op exact de versies waarvoor de QR's zijn gemaakt. Print-set, QR-registratie en release verwijzen daardoor gegarandeerd naar dezelfde versie.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.15 — 24 augustus 2026

### Releases pinnen nu écht de nieuwste versie

Twee gebreken in de versie-bewaking van releases, allebei gemeld uit de praktijk en allebei opgelost.

**Wat is er veranderd?**

- **Toevoegen aan een release pakt de nieuwste versie** — bij *Naar release* werd tot nu toe stilzwijgend de éérste versie van elk bestand vastgelegd. Een verse release kon daardoor direct ⚠-badges tonen (*v1 → v3*). Nu wordt per bestand de nieuwste versie opgezocht en vastgelegd.
- **Bijwerken werkt, en de melding is eerlijk** — de ↻-knop en *Alles bijwerken* meldden succes zonder dat er iets veranderde. Voortaan wordt ná elke bijwerk-actie bij Trimble Connect gecontroleerd of de release werkelijk op de nieuwste versie staat; pas dan telt een bestand als gelukt. Mislukt er iets, dan zie je dat.
- **De ⚠-badge oordeelt op versienummer** — niet langer op interne kenmerken die na een correcte update ten onrechte alarm konden slaan.
- **Links naar Trimble Connect gerepareerd** — Trimble heeft de adressen van de webclient gewijzigd. Release-links openen nu de nieuwe releases-pagina, en de *Open shares*-koppeling gaat naar de Activiteit-pagina, waar Trimble het beheer van deel-links tegenwoordig heeft ondergebracht. Ook de bestandslink in het detailpaneel volgt het nieuwe adres.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw. Bestaande releases met een ⚠-badge werk je daarna in één keer bij met *Alles bijwerken* — nu echt.

---

## Versie 1.14 — 24 augustus 2026

### Uploader neemt metadata van vorige versie automatisch over

Bij een nieuwe versie van een bestaand document moest je tot nu toe alle verplichte velden opnieuw invullen — Titel, Bedrijf, Discipline, Bouwdeel, enzovoort — terwijl er meestal alleen een nieuwe documentdatum tegen aan hoefde. Marco (VW) meldde dat en had gelijk: dat is werk voor niks en foutgevoelig (één typo in *Bedrijf* breekt de filters in de Documentenlijst).

**Wat is er veranderd?**

- **Direct herkend bij drop** — sleep je een bestand in de uploader waarvan de naam al bestaat in de gekozen map, dan haalt de cockpit binnen een halve seconde de metadata van de vorige versie op en vult die in. Je ziet in de header een groene *"↩ 8 overgenomen"*-chip en boven de metadata-velden een banner *"8 velden overgenomen uit /Pad/naar/Vorige-map — datum ontbreekt nog"*.
- **Datum-velden worden bewust overgeslagen** — documentdatum en aanmaakdatum blijven leeg, want die zijn per definitie anders bij een nieuwe versie. De rest wordt overgenomen.
- **Vergrendelde velden blijven vergrendeld** — als de projectbeheerder een veld op een vaste waarde heeft gezet (bijv. status *"Voor uitvoering"*), overschrijft de overname dat nooit.
- **↶ Ongedaan maken** — vergist de cockpit zich, of wil je echt vanuit nul beginnen? Er staat 30 seconden lang een *↶ Ongedaan maken*-link in de banner die alle velden terugzet naar wat de gewone suggestie-logica had gedaan.
- **Ook in andere mappen zoeken** — vindt de cockpit in de gekozen map niets? Dan verschijnt een link *"🔍 Ook in andere mappen zoeken"* die het hele project doorzoekt op dezelfde bestandsnaam.
- **Werkt bij bulk-drops** — sleep 10 bestanden tegelijk, dan draaien 6 lookups parallel; per bestand verschijnt de chip zodra dat bestand klaar is.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.13 — 24 augustus 2026

### Print-set: de Versie-QR komt nu vanzelf óp de tekening

De Versie-QR uit versie 1.11 leverde losse QR-afbeeldingen — die moest je zelf nog op de print plakken of in het onderschrift zetten. Dat handwerk is verdwenen: de nieuwe knop **📄 Print-set (QR in PDF)** stempelt de QR direct in je PDF-tekeningen.

**Hoe werkt het?**

- Genereer je Versie-QR's zoals je gewend bent (selectie → 🏷️ Versie-QR → QR-codes genereren) en kies daarna **Print-set**. Je downloadt een ZIP met je tekeningen als print-klare PDF's, mét de QR er al in — direct naar de printer.
- **De QR-stempel is instelbaar**: hoek (standaard rechtsonder, bij het titelblok), formaat (15/20/25 mm) en of hij op alleen de eerste of op alle pagina's komt. Je keuze wordt per project onthouden. De stempel krijgt een wit vlak met rand en het bijschrift *"Versiecheck · rev X"*, zodat hij ook op drukke tekeningen scanbaar blijft.
- **Het origineel in Trimble Connect blijft onaangeroerd** — er wordt geen nieuwe versie aangemaakt; de gestempelde PDF is puur je print-exemplaar.
- Bestanden die geen PDF zijn (of een beveiligde PDF) krijgen automatisch hun losse QR-afbeelding in dezelfde ZIP, met een koppeltabel die aangeeft wat wél en niet gestempeld kon worden. Het stickervel (voorheen "PDF") en de losse PNG's blijven bestaan als alternatief.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.12 — 24 augustus 2026

### Releases blijven actueel: de cockpit signaleert verouderde bestanden

Een release is een momentopname — maar het project werkt door. Tot nu toe zag je nergens dat een bestand in een release inmiddels een nieuwere versie heeft in het project. Vanaf deze versie bewaakt de cockpit dat voor je.

**Wat is er veranderd?**

- **⚠-signalering op het dashboard** — zodra de documentenlijst geladen is, verschijnt bij werkpakketten met een gekoppelde release en bij de rijen onder "Recente releases" een waarschuwing zoals **⚠ 3**: drie bestanden in die release hebben een nieuwere versie in het project.
- **Versie-status per bestand** — open in de Documentenlijst het releases-overzicht en klap een release uit: elk bestand toont **✓ actueel** of **⚠ v3 → v5**, met een **↻-knop** om dat ene bestand bij te werken en een knop **"Alles bijwerken"** voor de hele release.
- **Werkpakket bijwerken in één keer** — bij een werkpakket dat al aan een release gekoppeld is, doet de 📦-knop nu een volledige bijwerkronde: verouderde bestanden worden naar de nieuwste versie gebracht én bestanden die inmiddels aan het werkpakket voldoen worden toegevoegd. Je ziet vooraf precies wat er gaat gebeuren en bevestigt eerst. Bestanden verwijderen doet de cockpit nooit automatisch — wat buiten het werkpakket is gevallen wordt alleen gemeld.
- **Verzonden releases blijven onaangetast** — releases met status "Verzonden" tonen wel de versie-status, maar krijgen geen bijwerk-knoppen.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw. De signalering verschijnt automatisch zodra de documentenlijst op de achtergrond geladen is.

---

## Versie 1.11 — 24 augustus 2026

### Versie-QR: zet een QR op de tekening en iedereen ziet of de print nog klopt

Verouderde prints op de bouwplaats zijn een klassieke foutbron: de tekening aan de muur is revisie 3, terwijl in Trimble Connect al revisie 5 staat. Vanaf deze versie genereer je per document een **Versie-QR** die je óp de print zet. Wie hem scant — uitvoerder, onderaannemer, wie dan ook — ziet direct op zijn telefoon of die print nog de actuele versie is. **Zonder Trimble-account.**

**Hoe werkt het?**

- Selecteer in de **Documentenlijst** de documenten en kies **🏷️ Versie-QR** in de selectiebalk. Per document wordt vastgelegd welke versie er op dat moment actueel is; de QR verwijst naar een controle-pagina van At Fielt.
- Wie de QR scant ziet één van drie uitkomsten: **groen** (print is actueel), **rood** (verouderd — met de actuele revisie en wijzigingsdatum erbij) of **oranje** (controle tijdelijk niet mogelijk; de geprinte gegevens worden dan wel getoond).
- Exporteer de codes als **ZIP** (losse PNG's per document, met koppeltabel) of als **printbaar PDF-vel**, met documentnummer, revisie en datum als bijschrift onder elke code. Je bedrijfslogo in het midden van de QR gaat automatisch mee.
- Ook te vinden via de tab **QR-codes**, naast de bestaande QR-codes voor kopersmappen.

**Twee controle-modi, in te stellen per project (alleen projectbeheerders):**

- **Alleen versie-status** (standaard) — de scanner ziet uitsluitend óf de print actueel is; het bestand zelf blijft volledig afgeschermd. Hiervoor nodigt de projectbeheerder eenmalig het At Fielt controle-account uit als projectlid (leesrechten volstaan) — de generator legt dit stap voor stap uit en controleert het vooraf. QR's die je eerder printte gaan vanzelf werken zodra het account lid is; opnieuw printen is niet nodig.
- **Status + bestand bekijken** — de scanpagina toont ook het document zelf. Let op: de documenten worden daarmee blijvend openbaar toegankelijk voor iedereen met de QR. Deze modus staat daarom nooit stilzwijgend aan: alleen een projectbeheerder kan hem activeren, na een expliciete bevestiging waarin de consequenties volledig zijn uitgelegd.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw. Wil je de versie-controle live hebben, nodig dan het At Fielt controle-account uit in je project — de generator toont het adres en de stappen.

### Vernieuwd dashboard: werkpakketten in plaats van een tweede menu

Het dashboard toonde de modules twee keer (tabs bovenin én grote tegels eronder) en de kolom "Open taken" bleef altijd leeg. Die ruimte gaat nu naar waar je daadwerkelijk aan werkt.

**Wat is er veranderd?**

- **Werkpakketten op het dashboard** — de weergaves die je in de Documentenlijst klaarzet (kolommen, filters, map, sortering onder één naam) staan nu direct op het dashboard: eerst de gedeelde project-weergaves, daaronder je persoonlijke. Eén klik en de Documentenlijst opent met dat werkpakket actief — ook als je de lijst die sessie nog niet had geopend.
- **Werkpakket → release** — bij elke klaargezette weergave zit nu een 📦-knop: alle bestanden die op dat moment aan het werkpakket voldoen gaan in één keer naar een nieuwe of bestaande Trimble Connect-release. Het werkpakket onthoudt de koppeling en toont de release als label; klikken opent de release in Trimble Connect. (Volgende versie: automatisch signaleren wanneer bestanden in de release een nieuwere versie hebben.)
- **Compacte module-tegels met licentie-status** — de grote tegels zijn een slanke statusrij geworden (met live tellers en laad-voortgang). Modules waarvoor je geen licentie hebt tonen dat nu expliciet met een slotje en "Geen licentie". De tabs bovenin zijn de primaire navigatie; tab- en tegelnamen zijn overal gelijkgetrokken.
- **Instellingen werken nu echt door** — "Aantal recente uploads" en "Default tijdperiode" (tandwiel-menu) worden voortaan toegepast op de dashboard-lijsten, direct bij het opslaan. De niet-functionele todo-instelling is verwijderd.

**Wat moet je doen?**
Niets extra's — sluit Trimble Connect één keer volledig en open opnieuw. Nog geen werkpakketten in beeld? Sla in de Documentenlijst een weergave op via **Weergaves → Opslaan als**, en hij verschijnt op het dashboard.

---

## Versie 1.10 — 24 augustus 2026

### Rechten Viewer laat overgenomen leesrechten weer zien

De Rechten Viewer onderschatte wat gebruikers werkelijk zagen. Wie in de projectinstellingen van Trimble Connect *Alle projectleden → alleen-lezen* had staan, verwachtte dat elke map dat leesrecht overneemt — maar de viewer zette bij die mappen **Geen toegang**. Precies het tegenovergestelde van waarvoor je hem gebruikt. Voor de tweede keer gemeld (eerste keer 19 mei); nu opgelost.

**Wat is er veranderd?**

- **De projectstandaard telt weer mee** — de Rechten Viewer haalt nu ook de rechten op van de bovenste map (het project zelf) en gebruikt die als startpunt voor de overerving naar onderliggende mappen. De regel *Alle projectleden → alleen-lezen* die je op projectniveau hebt ingesteld, stroomt daardoor door naar elke map die die overerving niet expliciet heeft geblokkeerd.
- **Effect in de weergaves** — bij *Groepen* en *Gebruikers* verschijnt op mappen die hun rechten van het project erven voortaan een **leesrecht-label** (in plaats van *Geen toegang*), met *(rechten van parent overgenomen)* in de tooltip. Bij *Mappen* telt de doorgevoerde overerving mee in de kleuren en de dashboard-tellers.
- **Uitzonderingen blijven werken** — een map waar iemand expliciet is uitgesloten (*Geen toegang*) blijft uitgesloten. Een map waar de overerving in Trimble Connect zelf is uitgezet, blijft ook uitgesloten van deze doorwerking.

### En verder in de Documentenlijst

- **Filter op recent gewijzigd** — nieuwe keuzelijst in de filterbalk: *vandaag*, *laatste 7 dagen* of *laatste 30 dagen*. Zo zie je in één klik wat er nieuw is binnengekomen. De keuze gaat mee in je opgeslagen weergaves — *"UO Aannemer, laatste week"* wordt daarmee één klik.
- **QR-codes hebben een eigen tab** — de knoppenbalk van de documentenlijst werd vol. QR-codes voor kopersmappen zit nu als eigen tab in de navigatiebalk bovenin; de generator zelf is onveranderd.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.9 — 24 augustus 2026

### Bewerken zonder raden, en de ZIP-knop waar je hem verwacht

Direct vervolg op versie 1.8, na een nieuwe testronde dezelfde dag.

**Wat is er veranderd?**

- **Je ziet nu dat je aan het bewerken bent** — zodra je op 🔒 Bewerken klikt verschijnt een oranje balk boven de tabel die precies uitlegt hoe het werkt: dubbelklik op een gemarkeerde cel, Enter of ergens anders klikken bevestigt, Esc annuleert. En belangrijk: **elke wijziging wordt direct opgeslagen** — de knop 🔓 Vergrendelen is geen opslaan-knop maar alleen de beveiliging tegen per-ongeluk wijzigen.
- **Keuzelijst of vrije tekst? Je ziet het aan de cel** — in bewerkmodus staat achter elke bewerkbare cel een klein symbool: **▾** betekent een keuzelijst, **✎** betekent vrije tekst. Ook de tekst die verschijnt als je op een cel stilstaat vertelt het verschil.
- **Vrije tekstvelden zijn nu écht leeg te maken** — een waarde wissen ging al goed naar Trimble Connect, maar het scherm bleef de oude tekst tonen alsof er niets gebeurd was. Dat is opgelost: leegmaken is meteen zichtbaar.
- **Download ZIP voor je selectie** — de ZIP-download bestond alleen per release (via de Releases-knop). Nu staat er ook een **💾 Download ZIP** in de oranje selectiebalk: vink bestanden aan en download ze als ZIP, met mappenstructuur en dezelfde keuze tussen ingekorte of volledige mapnamen als bij releases.
- **De documentenlijst in de ZIP is nu een Excel-bestand** — zowel bij de release-download als bij de selectie-download zit voortaan een `.xlsx` in plaats van een CSV: koprij in At Fielt-oranje, klikbare bestandsnamen die het document in Trimble Connect openen, filterknoppen aan en de koprij vastgezet. Lukt het laden van de Excel-bibliotheek niet (geen internet), dan valt de download terug op CSV zodat je de lijst altijd hebt.
- **Hele map in één keer selecteren** — bij groepering op map (of een ander veld) heeft elke groepskop nu een eigen selectievakje. Eén klik selecteert alle bestanden in die groep.
- **Bulk wijzigen vereist nu de bewerkmodus** — dezelfde beveiliging als bij het bewerken van losse cellen: de knop is pas actief nadat je 🔒 Bewerken hebt aangezet.
- **Knoppen beter uit elkaar te houden** — *Deel-links maken* (🔗) en *Download ZIP* (💾) hadden bijna identieke pictogrammen; nu zie je in één oogopslag welke wat doet.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.8 — 24 augustus 2026

### Vier fixes uit de praktijk

Een testronde bij een klant leverde vier concrete meldingen op. Alle vier opgepakt.

**Wat is er veranderd?**

- **Keuzelijsten bij metadata doen het weer** — sommige velden toonden een vrij invulveld in plaats van een keuzelijst, of een lijstje met maar één optie dat niet aan te passen was. Oorzaak was het inlezen van het metadata-schema: een deel van de toegestane waarden werd overgeslagen, en wat wél gevonden werd verving per ongeluk de rest. Het inlezen gebruikt nu dezelfde bewezen aanpak als de eerdere losse Documentenlijst, met de schema-definitie zelf als eerste bron. Datumvelden krijgen daardoor ook netjes een datumkiezer op basis van het schema in plaats van de veldnaam.
- **Kolommen met lange teksten zijn nu te versmallen** — een lange omschrijving duwde de kolom permanent breed; alleen de mapnaam-kolom "vouwde op". Nu breken alle metadata-kolommen hun tekst af over meerdere regels, precies zoals de mapnaam-kolom dat al deed. Versleep de kolomrand en de tekst voegt zich naar de nieuwe breedte.
- **ZIP-download: kies zelf de mapnaam-stijl** — bij het downloaden van een release als ZIP kon de mappenstructuur onherkenbaar worden: van elke map bleef alleen het nummer en het eerste woord over. Dat inkorten is voor sommige projecten juist gewenst, dus het is nu een keuze. Vóór elke download verschijnt een venster met twee opties: **Ingekort** (zoals het was) of **Volledig** (mapnamen zoals in Trimble Connect). Je laatste keuze wordt per project onthouden als voorselectie.
- **Bestandsnaam-links openen weer de laatste versie** — de klikbare bestandsnamen in de tabel, het detailpaneel en de Excel-export konden een oudere versie van het document openen. De link laat de versie-keuze nu aan Trimble Connect zelf, zodat je altijd op de actuele versie uitkomt. Links naar een spécifieke versie (in de versiegeschiedenis van het detailpaneel) blijven gewoon naar die versie wijzen.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.7 — 20 augustus 2026

### Klaargezette weergaves: "DO Architect", "UO Aannemer"

Een werkvoorbereider zet elke ochtend dezelfde dingen goed: de juiste kolommen aan, twee filters, groeperen op map, sorteren op documentnummer. Bij een wissel van rol of project begint dat opnieuw. Dat is nu één keer werk.

**Wat is er veranderd?**

- **Weergave opslaan onder een naam** — zet de documentenlijst precies zoals je hem wilt en klik op **Weergaves → Opslaan als…**. Je geeft hem een naam (*"DO Architect"*, *"UO Aannemer"*, *"Mijn werkvoorraad"*) en hij staat er de volgende keer weer.
- **Wat er allemaal in gaat** — zichtbare kolommen, hun volgorde én breedte, alle actieve filters (inclusief de *Uitzonderen*-stand), de bestandstype-chips, de groepering, de sortering, en of je in Lijst- of Mappen-weergave stond. Met één klik staat dat allemaal weer goed. De zoekbalk gaat er bewust níét in: die is van het moment.
- **Gedeeld of alleen voor jezelf** — projectbeheerders kunnen een weergave met **Opslaan voor project** klaarzetten voor iedereen. Die verschijnt bij elke collega onder *Gedeeld in dit project*. Weergaves die je zelf opslaat blijven van jou en staan onder *Alleen voor jou*.
- **Je ziet wanneer je bent afgeweken** — zodra je iets aanpast terwijl er een weergave actief is, verschijnt er een oranje stipje achter de naam. Bijwerken doe je met het ↻-knopje bij die weergave; wil je de aanpassing niet bewaren, kies dan de weergave gewoon opnieuw.
- **Hernoemen en verwijderen** — met het potlood en het prullenbakje in de lijst. Bij gedeelde weergaves kan dat alleen door een projectbeheerder, zodat niemand per ongeluk de weergave van het hele team weggooit.
- **Losmaken** — met de knop *Losmaken* laat je de weergave los zonder dat er iets verandert aan wat je op het scherm ziet. Handig als je vanaf hier vrij verder wilt werken.

**Waar staat het?** In de kop van de documentenlijst, links van de knop Kolommen. Zolang er geen weergave actief is heet de knop *Weergaves*; daarna toont hij de naam van de weergave die je gekozen hebt.

**Let op:** weergaves horen bij één project. In een ander project begin je met een schone lijst — een beheerder zet daar zijn eigen gedeelde weergaves klaar.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig en open opnieuw.

**Wat volgt:**
- Eigen Excel-sjabloon met bewaard logo + opmaak — technisch mogelijk sinds versie 1.6, wacht op het sjabloon van de klant
- Publieke deel-links per document voor uitvoerders zonder Trimble Connect-account

---

## Versie 1.6 — 20 augustus 2026

### Map kiezen in de uploader: van eindeloze lijst naar uitklapbare boom

In een groot project lopen de mappen al snel in de honderden. De "Bulk-instellen"-balk bood die als één platte keuzelijst aan — scrollen door honderden regels met volledige paden, zonder houvast. Dat is vervangen door een mappenboom.

**Wat is er veranderd?**

- **Uitklapbare mappenboom** — klik op de map-kiezer en je krijgt de projectstructuur zoals je hem kent: alleen het bovenste niveau, met een chevron om verder open te klappen. Je ziet mapnamen in plaats van complete paden.
- **Zoeken door de hele boom** — typ een deel van een mapnaam of pad en alleen de treffers blijven staan, met hun bovenliggende mappen automatisch opengeklapt. Hoofdletters maken niet uit.
- **Nette volgorde** — mappen sorteren zoals mensen dat verwachten: `0-06` staat vóór `0-07`, en die weer vóór `05.00`. Niet meer de letterlijke tekst-volgorde waarin `0-10` tussen `0-1` en `0-2` belandt.
- **Projectroot bovenaan** — uploaden naar de projectroot blijft één klik, zonder door de boom te hoeven.
- **Gekozen map blijft in beeld** — de kop toont je selectie met een wis-knopje ernaast. Openklappen en zoekterm blijven bewaard terwijl je in de wachtrij werkt.

De map-kiezer per afzonderlijk bestand verandert niet — die had al een zoekveld en een korte lijst met de meest waarschijnlijke mappen.

### Onder de motorkap: Excel-export op een nieuwe motor

De Excel-export is intern overgezet van de ene bibliotheek naar de andere. **Je merkt hier bewust niets van**: kolommen, groepen, bevroren koprij, filterknoppen en de klikbare bestandsnamen uit versie 1.4 komen er exact hetzelfde uit.

Waarom het er dan toch in staat: de oude bibliotheek kon geen opmaak naar Excel schrijven — geen kleuren, geen logo, geen bestaand sjabloon inlezen. Daarmee was *"exporteer in ons eigen Excel-sjabloon"* technisch onmogelijk. De nieuwe kan dat wel. Deze stap is de motorwissel; de zichtbare opmaak volgt zodra het sjabloon er is.

**Wat moet je doen?**
Niets. Sluit Trimble Connect één keer volledig en open opnieuw.

**Wat volgt:**
- Eigen Excel-sjabloon met bewaard logo + opmaak — technisch nu mogelijk, wacht op het sjabloon van de klant
- Klaargezette weergaves met naam (*"DO Architect"*, *"UO Aannemer"*)
- Publieke deel-links per document voor uitvoerders zonder Trimble Connect-account

---

## Versie 1.5 — 20 augustus 2026

### Diagnose-knop: één klik, compleet supportrapport

Tot nu toe begon elke storingsmelding hetzelfde: "kun je F12 indrukken en een screenshot van het rode gedeelte sturen?" Dat werkt niet bij werkvoorbereiders die midden in hun werk zitten. Vanaf nu staat er rechtsonder in de cockpit een **Diagnose**-link.

**Wat is er veranderd?**

- **Diagnose-paneel** — de link onderaan (en de knop *Diagnose…* in de instellingen) opent een overzicht met tien controles: is Trimble Connect verbonden, is het access token nog geldig en hoe lang, welke At Fielt-modules zijn vrijgegeven, welke regio wordt gebruikt, is de Trimble-server rechtstreeks bereikbaar of alleen via onze proxy, werkt de lokale opslag, en hoeveel meldingen er deze sessie waren. Groen = in orde, oranje = let op, rood = dit is het probleem.
- **Kopieer diagnose** — één knop zet het hele rapport op het klembord: projectnaam, gebruiker, regio, alle controles, de status van elke module (inclusief hoeveel documenten geladen zijn en welke mappen niet leesbaar waren) en het logboek. Plakken in een mail naar info@atfielt.nl en wij zien direct wat er speelt.
- **Logboek van meldingen** — waarschuwingen en fouten worden vanaf het opstarten stil meegeschreven, ook als je het paneel nooit opent. Belt iemand een uur later, dan staat de melding er nog steeds in met het tijdstip erbij.
- **Automatische controle bij het opstarten** — de controle draait vanzelf na het laden. Gaat er iets mis, dan krijgt de Diagnose-link een klein rood stipje. De cockpit zelf blijft gewoon werken; het is een signaal, geen blokkade.
- **Niet-onthouden voorkeuren worden nu gemeld** — in sommige browserinstellingen (third-party cookies uit) mag de cockpit binnen Trimble Connect niets lokaal opslaan. Dat verklaart "mijn kolommen staan elke keer weer anders". Voorheen kon dat de cockpit tijdens het laden laten vastlopen; nu valt hij netjes terug op de standaardinstellingen en meldt de diagnose het probleem met naam en toenaam.

**Wat moet je doen?**
Niets. Sluit Trimble Connect één keer volledig en open opnieuw.

---

## Versie 1.4 — 20 augustus 2026

### Snelle verbeteringen op basis van gebruikersfeedback

Vier concrete verzoeken opgepakt na de v1.3-release, vooral vanuit de werkvoorbereiding.

**Wat is er veranderd?**

- **Meerdere rijen selecteren met shift+klik** — klik checkbox rij 3, shift+klik rij 12: alle acht rijen ertussen aangevinkt. Werkt zoals in Verkenner of Excel; ook bij groepering en mappenboom-weergave.
- **Filter op meerdere waarden per kolom** — de filter-knop (Status, Fase, Discipline, etc.) opent nu een popover met checkboxes. Vink meerdere waarden aan (bv. *Concept + Definitief*) of gebruik de **Uitzonderen**-toggle voor "alles behalve X" (bv. alles behalve Vervallen). Knop toont het aantal actieve waarden.
- **Klikbare links in Excel-export** — bestandsnaam-cellen in de gedownloade `.xlsx` zijn nu blauwe hyperlinks (via `=HYPERLINK()`-formule voor correcte Excel-styling). Klik in Excel op de bestandsnaam → opent Trimble Connect met dat exacte document. Ideaal voor uitvoerder-lijstjes.
- **Kolombreedte werkt in élk project** — de resize-handle tussen kolomkoppen werkt nu ook in nieuwe projecten. Onder water: eerdere versie sloeg breedtes soms op onder een tijdelijke sleutel die verloren ging bij project-wissel; nu wordt de config-sleutel pas gebruikt wanneer het project-ID volledig geladen is.
- **Resize verplaatst niet meer per ongeluk de kolom** — bij het loslaten van een resize-handle (vooral bij naar links slepen) kon de kolom soms van positie wisselen, alsof je hem verslepen wilde. Dat komt niet meer voor: na een resize wordt een korte grace-period ingelast waarbinnen een per-ongeluk-drag automatisch wordt genegeerd.

### Uploader — verplichte velden meteen zichtbaar + slimmer werken bij meerdere bestanden

De metadata-velden onder een geüpload bestand toonden bij elk leeg veld hetzelfde oranje driehoekje. Verplicht en optioneel waren visueel niet te onderscheiden, en bij het slepen van vijf bestanden tegelijk kreeg je vijf keer hetzelfde volledige formulier onder elkaar. Drie gerichte verbeteringen:

- **Verplichte velden zijn rood en staan bovenaan** — rode label, dikke rode rand, en een witte **!** in een rode cirkel bij een leeg verplicht veld. Optionele velden blijven neutraal (geen waarschuwing meer bij "leeg is prima"). Binnen de meta-rij worden verplichte velden automatisch als eerste getoond, ongeacht de veld-volgorde in het admin-schema.
- **Bulk-bar toont nu álle velden** — de "Bulk-instellen voor alle X bestanden"-balk boven de queue toonde eerder alleen drie hardcoded selects (Discipline, Fase, Status). Nu verschijnt élk actief veld — inclusief tekst-invoer en datum-picker — met verplichte velden bovenaan en dezelfde rode markering. Titel-hint telt hoeveel verplichte velden er zijn zodat je die als eerste doet.
- **Ingeklapte bestanden bij bulk-upload** — sleep je twee of meer bestanden tegelijk in de uploader, dan klappen alle rijen dicht tot alleen naam + status-badge (`! N verplicht` in rood of `✓ compleet` in groen). Rijen met een ontbrekend verplicht veld krijgen ook een rode linker-balk. Klik op de chevron of de bestandsnaam om die ene rij open te klappen en handmatig aan te passen. Bij één bestand blijft de rij automatisch open.

**Werkvolgorde bij meerdere bestanden:** sleep alle bestanden erin → vul de verplichte velden in de bulk-balk in → klik "Toepassen op alle" → klap alleen de bestanden open waar iets afwijkt.

**Wat moet je doen?**
Sluit Trimble Connect één keer volledig, open opnieuw. Alle verbeteringen zijn direct beschikbaar.

**Wat volgt (op basis van dezelfde feedback):**
- Eigen Excel-template met bewaard logo + opmaak (aparte sprint — klant levert template aan)
- Klaargezette weergaves met naam (*"DO Architect"*, *"UO Aannemer"*) waarin filters + kolommen + groepering samen bewaard worden
- Publieke deel-links per document voor uitvoerders zonder Trimble Connect-account

---

## Versie 1.3 — 19 augustus 2026

### Documentenlijst voelt weer als een echte tool

Een terugkerend signaal uit de praktijk: de losse versie werkte prettiger dan de Documentenlijst in de Cockpit. We hebben de hele weergave herzien met vijf gerichte fixes plus een langverwachte Excel-export.

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

Extra betrouwbaarheidsfixes naar aanleiding van meldingen uit de praktijk:
- Dubbele bestanden in de folder-boom worden nu correct ontdubbeld (verklaart het verschil waarbij twee collega's een ander aantal documenten zagen)
- Folders waar een gebruiker geen leesrechten voor heeft worden vastgelegd (voor toekomstige diagnose-knop)
- Release-download vindt nu correcte map-prefix als bestandsnamen dubbel voorkomen (ipv willekeurig kiezen)

### Wat moet je doen?

Sluit Trimble Connect één keer volledig (alle tabs), open opnieuw. De nieuwe weergave verschijnt direct.

Als je eigen kolommen had opgeslagen als "project-standaard" en de nieuwe set wilt zien: Kolommen → Standaard herstellen. Bevalt de nieuwe set voor je hele team? Klik dan de oranje knop "Opslaan voor project" om die als nieuwe default vast te leggen.

---

## Versie 1.2.1 — juni & juli 2026

### QR-codes voor kopersmappen

**Wat was het probleem?**
Bij projecten met kopersmappen (één map per bouwnummer of koper) moest je per map handmatig de link opzoeken, kopiëren en er via een externe website een QR-code van laten maken. Bij tientallen bouwnummers is dat al snel een half uur werk, en het is foutgevoelig: één verkeerd geplakte link en de koper landt in de map van de buren.

**Wat is er veranderd?**
In de Documentenlijst zit de knop **📱 QR-codes**. Je kiest de hoofdmap met de kopersmappen, en elke submap daaronder wordt automatisch één QR-code die rechtstreeks naar die map in Trimble Connect verwijst. Je vinkt zelf aan welke mappen mee moeten en exporteert in drie vormen:

- **ZIP** — losse PNG's per map in hoge resolutie, klaar om te plakken in een brochure, brief of sticker
- **PDF** — printbaar overzichtsvel met alle QR-codes en de mapnaam eronder
- **CSV** — koppeltabel mapnaam → link, voor eigen verwerking of controle

### 🏢 Eigen bedrijfslogo in het midden van de QR-code

Je kunt in hetzelfde scherm een logo uploaden dat midden in elke QR-code wordt geplaatst. Het logo wordt **per project onthouden**, dus je kiest het één keer en het verschijnt daarna automatisch in de voorbeelden, in de ZIP-PNG's én op het print-PDF. Via "✕ Logo weg" haal je het er weer af.

De codes blijven gewoon scanbaar: de QR-codes worden op het hoogste foutcorrectie-niveau gegenereerd, waardoor het afgedekte midden ruim binnen de veilige marge blijft. We hebben dat getest door de gegenereerde codes met logo weer automatisch te laten uitlezen — zowel op schermformaat als op printformaat.

**Let op**
Wie de QR-code scant heeft een Trimble-account met toegang tot het project nodig, net als bij een handmatig gemaakte maplink. Publieke deel-links voor mensen zonder account staan op de roadmap.

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
- Een klein project (26 documenten, 9 mappen, 72 projecten in de regio)
- Een groot project (860 documenten, 786 mappen, 92 groepen, 44 gebruikers)

## Disclaimer

Deze tool is ontwikkeld door At Fielt als hulpmiddel om Trimble Connect efficiënter te gebruiken. Gebruik is op eigen risico — controleer belangrijke acties altijd ook in Trimble Connect zelf.
