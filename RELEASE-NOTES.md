# At Fielt Cockpit — Release Notes

---

## Versie 1.10 — 24 augustus 2026

### Rechten Viewer laat overgenomen leesrechten weer zien

De Rechten Viewer onderschatte wat gebruikers werkelijk zagen. Wie in de projectinstellingen van Trimble Connect *Alle projectleden → alleen-lezen* had staan, verwachtte dat elke map dat leesrecht overneemt — maar de viewer zette bij die mappen **Geen toegang**. Precies het tegenovergestelde van waarvoor je hem gebruikt. Voor de tweede keer gemeld (eerste keer 19 mei); nu opgelost.

**Wat is er veranderd?**

- **De projectstandaard telt weer mee** — de Rechten Viewer haalt nu ook de rechten op van de bovenste map (het project zelf) en gebruikt die als startpunt voor de overerving naar onderliggende mappen. De regel *Alle projectleden → alleen-lezen* die je op projectniveau hebt ingesteld, stroomt daardoor door naar elke map die die overerving niet expliciet heeft geblokkeerd.
- **Effect in de weergaves** — bij *Groepen* en *Gebruikers* verschijnt op mappen die hun rechten van het project erven voortaan een **leesrecht-label** (in plaats van *Geen toegang*), met *(rechten van parent overgenomen)* in de tooltip. Bij *Mappen* telt de doorgevoerde overerving mee in de kleuren en de dashboard-tellers.
- **Uitzonderingen blijven werken** — een map waar iemand expliciet is uitgesloten (*Geen toegang*) blijft uitgesloten. Een map waar de overerving in Trimble Connect zelf is uitgezet, blijft ook uitgesloten van deze doorwerking.

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
- **Filter op recent gewijzigd** — nieuwe keuzelijst in de filterbalk: *vandaag*, *laatste 7 dagen* of *laatste 30 dagen*. Zo zie je in één klik wat er nieuw is binnengekomen. De keuze gaat mee in je opgeslagen weergaves — *"UO Aannemer, laatste week"* wordt daarmee één klik.
- **QR-codes hebben een eigen tab** — de knoppenbalk van de documentenlijst werd vol. QR-codes voor kopersmappen zit nu als eigen tab in de navigatiebalk bovenin; de generator zelf is onveranderd.

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
