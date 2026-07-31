# Claude-Code-Korrelations-Prompts

Die fünf Prompts, die die rohen Tool-Outputs (subfinder/amass/assetfinder,
httpx, gau/katana, theHarvester/hunter/sherlock) zu einem priorisierten
Asset-Inventar verdichten. Aus: [OSINT-Pipelines mit Claude Code](https://flowki-club.de/blog/2026-04-19-osint-pipelines-mit-claude-code?utm_source=github&utm_medium=repo&utm_campaign=content-launch-2026-07)

## 1. Subdomain-Merge + Dedup

```
Lies alle Files in diesem Verzeichnis. Erstell eine deduplizierte Liste
aller eindeutigen Subdomains. Outputformat: ein-Subdomain-pro-Zeile,
sortiert. Schreib das nach merged.txt. Anzahl unique am Ende ausgeben.
```

## 2. Tech-Klassifizierung (nach httpx)

```
Lies httpx.json. Klassifiziere Subdomains in:
- "Marketing/CMS" (WordPress, Drupal, etc.)
- "Custom-App" (eigene Tech-Stacks)
- "Cloud-Storage" (S3, GCS, Azure-Blob)
- "Dev/Staging" (Hostnames mit dev-, test-, staging-, internal-)
- "Security-relevant" (Admin-Panels, VPN-Endpoints, API-Gateways)
Sortier pro Kategorie nach Interessantheit fuer Pentest. Schreib nach
classified.md mit Begruendung pro Eintrag.
```

## 3. URL-Clustering

```
Hier ~12000 URLs aus passive + active Discovery. Cluster sie nach:
- Wahrscheinliche Login-Endpoints
- Wahrscheinliche API-Endpoints
- Backup/Config-Files (.bak, .env, .git, .DS_Store)
- Admin-Routen
- Static Assets (fuer Pattern-Mining)
Pro Cluster: Top 10 mit Begruendung.
```

## 4. People-Korrelation

```
Lies harvest.json + hunter.json + alle sherlock-*.json.
Erstell pro Person:
- Name
- Bekannte E-Mail-Adressen (mit Quelle)
- Aktive Social-Media-Accounts (mit URL)
- Wahrscheinliche Rolle (aus LinkedIn/GitHub-Bio)
- Tech-Stack-Hinweise (von GitHub-Repos)
Schreib pro Person eine Card in people/.
```

## 5. Finales Inventar

```
Lies alle Files in diesem Verzeichnis (subdomains/, tech/, urls/, people/).
Generier ein INVENTORY.md mit:

1. Asset-Uebersicht: alle live Subdomains, gruppiert nach Tech
2. High-Priority Targets: Subdomains die Admin-Panels haben oder
   auf veraltete Tech zeigen
3. Dokumentierte Backup-/Config-Files mit URL
4. Vulnerability-Hypothesen pro Asset:
   - Was waere die wahrscheinlichste Schwachstelle aus historischen
     Daten der gleichen Tech?
   - Welcher Test waere als naechstes sinnvoll?
5. Dependencies: welche Targets sollten zuerst getestet werden?

WICHTIG: Keine Halluzinationen. Wenn du eine Vulnerability vermutest
aber nicht belegen kannst, schreib "Hypothese, nicht verifiziert".
Wenn du eine CVE nennst, gib Nummer und Datum.
```

## Empfohlene Verzeichnisstruktur

```
~/recon/
├── _templates/
│   ├── recon.sh                  # Pipeline-Skript
│   ├── claude-prompts.md         # Diese Prompts
│   └── INVENTORY-TEMPLATE.md     # Output-Schema
├── target-1.com/
│   ├── subdomains/
│   ├── tech/
│   ├── urls/
│   ├── people/
│   ├── INVENTORY.md
│   └── .claude/settings.json    # Tool-Allowlist
└── target-2.com/
    └── (gleiche Struktur)
```

`.claude/settings.json` mit einer Allowlist fuer `Bash(subfinder *)`,
`Bash(amass *)`, `Bash(httpx *)`, `Bash(theHarvester *)`, `Bash(sherlock *)`
— kein Approval-Spam, kein Risiko dass Claude etwas Unbekanntes startet.
