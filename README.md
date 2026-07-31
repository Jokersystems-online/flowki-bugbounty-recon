# flowki-bugbounty-recon

LLM-orchestrierte Recon-Pipeline für Bug-Bounty-Programme (HackerOne,
Intigriti, YesWeHack). Claude Code orchestriert klassische Recon-Tools
(amass, subfinder, assetfinder, httpx, gau, katana, theHarvester, sherlock,
nuclei), parst deren Output und generiert Nuclei-Templates aus
interessanten Findings.

Companion-Repo zu zwei FlowKI-Club-Artikeln:
[Bug-Bounty-Recon mit KI](https://flowki-club.de/blog/2026-04-18-bug-bounty-recon-mit-ki?utm_source=github&utm_medium=repo&utm_campaign=content-launch-2026-07)
und [OSINT-Pipelines mit Claude Code](https://flowki-club.de/blog/2026-04-19-osint-pipelines-mit-claude-code?utm_source=github&utm_medium=repo&utm_campaign=content-launch-2026-07)
auf [FlowKI Club](https://flowki-club.de).

## Was hier drin ist

- `claude_recon.py` — parallele Subdomain-Enumeration (amass + subfinder +
  assetfinder), Dedup, sortierte Ausgabe
- `templates/admin-status-leak.yaml` — Beispiel-Nuclei-Template, generiert
  aus einem echten Recon-Finding
- `scope-analysis-prompt.md` — die zwei Claude-Code-Prompts für
  Scope-Extraktion und Live-Asset-Priorisierung
- `osint/url-discovery.sh` — URL-Discovery aus Wayback/Common-Crawl (gau)
  plus aktivem Crawl (katana), gefiltert auf interessante Dateitypen
- `osint/people-osint.sh` — People-OSINT (theHarvester, Hunter.io, Sherlock)
  — **nur nutzen wenn explizit im Scope erlaubt**
- `osint/correlation-prompts.md` — die fünf Claude-Prompts die rohe
  Tool-Outputs zu einem priorisierten `INVENTORY.md` verdichten, plus
  empfohlene Verzeichnisstruktur

Das ist die Pipeline wie in beiden Artikeln beschrieben — kein fertiges
Produkt, sondern ein Startpunkt zum Forken und Anpassen.

## Setup

```bash
pip install -r requirements.txt  # keine externen Python-Deps, nur stdlib
# amass, subfinder, assetfinder, httpx, gau, katana, theHarvester, sherlock, nuclei separat installieren
python claude_recon.py <target-domain>
cat all_subdomains.txt | httpx -silent -title -tech-detect -status-code -o httpx_results.json -json
```

## Was KI hier tut — und was nicht

Funktioniert gut: Pipeline-Orchestrierung, Output-Filterung, Template-
Generierung, Report-Vorbereitung, JSON-Korrelation über viele Quellen.

Bleibt beim Menschen: die tatsächliche Lücke finden, Validation und
Exploitation, die Entscheidung ob eine Eskalation noch im Scope ist.

## Rechtlicher Hinweis

Nutze diese Pipeline **ausschließlich** gegen Ziele, für die du eine
ausdrückliche Erlaubnis hast — ein dokumentiertes Bug-Bounty-Programm
(HackerOne/Intigriti/YesWeHack) im definierten Scope, oder einen
autorisierten Pentest mit schriftlichem Auftrag. People-OSINT (`osint/people-osint.sh`)
nur wenn das Programm Social-Engineering-Recon explizit erlaubt — die
meisten Programme tun das nicht. Aktive Enumeration gegen Ziele außerhalb
deines Scopes ist in Deutschland nach §§ 202a, 202b, 202c StGB strafbar.
Kein Haftungsausschluss ersetzt eigene Sorgfalt.

## Diskussion

Fragen, eigene Setups, Findings? Zone "Hacking & Security" im
[FlowKI Club Discord](https://flowki-club.de/join?utm_source=github&utm_medium=repo&utm_campaign=content-launch-2026-07).

## Lizenz

MIT — nutzen, forken, anpassen.
