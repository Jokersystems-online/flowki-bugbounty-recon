#!/usr/bin/env bash
# People-OSINT fuer Phishing-Surface-Analyse.
# NUR nutzen wenn explizit im Bug-Bounty-Scope erlaubt -- die meisten
# Programme erlauben KEIN Social Engineering. Siehe README fuer den
# rechtlichen Hinweis.
# From: https://flowki-club.de/blog/2026-04-19-osint-pipelines-mit-claude-code
set -euo pipefail

# Mitarbeiter-E-Mails ueber public Quellen (LinkedIn, GitHub, theHarvester)
theHarvester -d "$TARGET" -b google,bing,linkedin -l 500 -f harvest.json

# Wenn Hunter.io API-Key da: hochwertigere Daten
if [ -n "${HUNTER_KEY:-}" ]; then
  curl -s "https://api.hunter.io/v2/domain-search?domain=$TARGET&api_key=$HUNTER_KEY" > hunter.json
fi

# Username-Lookup ueber 250+ Plattformen (pro bekanntem Username separat aufrufen)
# sherlock $USERNAME --output "sherlock-$USERNAME.json"
