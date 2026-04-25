# Hub-setup voor Cockpit

Voer deze stappen één keer uit voordat je de Cockpit deployed — anders krijg je een blokkade-scherm bij het openen in TC.

## 1. Extensie registreren in D1

```bash
cd "/Users/Tom1/Documents/CLAUDE werkomgeving/atfielt-extension-hub"

npx wrangler d1 execute atfielt-hub-db --remote --command \
  "INSERT INTO extensions (slug, name, created_at) VALUES ('cockpit', 'At Fielt Cockpit', unixepoch()*1000);"
```

Verifieer:

```bash
npx wrangler d1 execute atfielt-hub-db --remote --command \
  "SELECT slug, name FROM extensions WHERE slug = 'cockpit';"
```

## 2. Allowlist-regel voor jezelf (fail-closed testen)

Via het admin dashboard (`https://atfielt-extension-hub.tom-da0.workers.dev/admin`) → Allowlist tab → Add:

- **Extension slug**: `cockpit`
- **Type**: `email`
- **Value**: `tom@atfielt.nl`
- **Expires**: laat leeg

Of via SQL:

```bash
npx wrangler d1 execute atfielt-hub-db --remote --command \
  "INSERT INTO allowlist (extension_slug, type, value, created_at) VALUES ('cockpit', 'email', 'tom@atfielt.nl', unixepoch()*1000);"
```

## 3. Klant-allowlist (later)

Per klant meestal een domain-regel:

```sql
INSERT INTO allowlist (extension_slug, type, value, created_at)
VALUES ('cockpit', 'domain', 'klantbedrijf.nl', unixepoch()*1000);
```

Of per pilot-project een project-ID:

```sql
INSERT INTO allowlist (extension_slug, type, value, created_at)
VALUES ('cockpit', 'project', 'iKHZnqH2qus', unixepoch()*1000);
```

Zie `atfielt-extension-hub/HUB-INTEGRATION.md` → "Allowlist — 3 types uitgelegd" voor details.

## 4. Verifieer na deploy

Open de Cockpit in TC → F12 → Console moet tonen:

- `[TC] Project: <naam>`
- `[TC] Token OK, lengte: …`
- `[Hub] Toegang verleend voor tom@atfielt.nl`

Admin dashboard → Events tab → filter slug `cockpit` → `load`-event binnen 30s zichtbaar.
