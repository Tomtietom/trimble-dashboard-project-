#!/bin/bash
# deploy.sh — commit + push. Houdt manifest URL stabiel (geen ?v= cache-buster).
#
# Gebruik:
#   ./deploy.sh "Commit bericht hier"
#
# Wat het doet:
#   1. Strip eventuele ?v= uit manifest.json url-veld (idempotent)
#   2. Commit + push
#   3. GitHub Pages bouwt opnieuw — TC ziet stabiele URL = registered URL
#
# Cache-busting gebeurt via <meta http-equiv="Cache-Control"> in HTML head.
# Resultaat: TC's "Rechten aanvragen"-popup blijft uit (URL-mismatch voorkomen).

set -e
cd "$(dirname "$0")"

MSG="${1:-update}"
V=$(date +%Y%m%d%H%M)

# Strip ?v=… uit manifest.json url (zorgt dat TC altijd dezelfde URL ziet)
URL=$(python3 -c "
import json
with open('manifest.json','r') as f: m = json.load(f)
base = m['url'].split('?')[0]
m['url'] = base
with open('manifest.json','w') as f: json.dump(m, f, indent=2, ensure_ascii=False); f.write('\n')
print(m['url'])
")

git add -A
if git diff --cached --quiet; then
  echo "Geen wijzigingen om te committen — niets te deployen."
  exit 0
fi
git commit -m "$MSG

Versie: $V
"
git push

echo ""
echo "✓ Gedeployed (versie $V — stabiele URL zonder ?v=)"
echo "  Manifest: ${URL}manifest.json"
echo "  Cockpit:  ${URL}"
echo ""
echo "Wacht 1-3 min op GitHub Pages rebuild, dan herlaad Trimble Connect"
echo "(complete tab sluiten & opnieuw openen, geen gewone refresh)."
