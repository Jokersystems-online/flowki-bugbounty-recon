# flowki-bugbounty-recon

LLM-orchestrierte Recon-Pipeline für Bug-Bounty-Programme (HackerOne,
Intigriti, YesWeHack). Claude Code orchestriert klassische Recon-Tools
(amass, subfinder, assetfinder, httpx, nuclei), parst deren Output und
generiert Nuclei-Templates aus interessanten Findings.

Companion-Repo zum Artikel [Bug-Bounty-Recon mit KI](https://flowki-club.de/blog/2026-04-18-bug-bounty-recon-mit-ki?utm_source=github&utm_medium=repo&utm_campaign=content-launch-2026-07)
auf [FlowKI Club](https://flowki-club.de) — der komplette Ablauf inkl.
gemessener Timings (~104 Min. Scope-zu-Report vs. ~4h ohne KI-Assistenz)
steht im Artikel.

## Was hier drin ist

- `claude_recon.py` — parallele Subdomain-Enumeration (amass + subfinder +
  assetfinder), Dedup, sortierte Ausgabe
- `templates/admin-status-leak.yaml` — Beispiel-Nuclei-Template, generiert
  aus einem echten Recon-Finding
- `scope-analysis-prompt.md` — die zwei Claude-Code-Prompts für
  Scope-Extraktion und Live-Asset-Priorisierung

Das ist die Pipeline wie im Artikel beschrieben — kein fertiges Produkt,
sondern ein Startpunkt zum Forken und Anpassen.

## Setup

```bash
pip install -r requirements.txt  # keine externen Python-Deps, nur stdlib
# amass, subfinder, assetfinder, httpx, nuclei separat installieren
python claude_recon.py <target-domain>
cat all_subdomains.txt | httpx -silent -title -tech-detect -status-code -o httpx_results.json -json
```

## Was KI hier tut — und was nicht

Funktioniert gut: Pipeline-Orchestrierung, Output-Filterung, Template-
Generierung, Report-Vorbereitung.

Bleibt beim Menschen: die tatsächliche Lücke finden, Validation und
Exploitation, die Entscheidung ob eine Eskalation noch im Scope ist.

## Rechtlicher Hinweis

Nutze diese Pipeline **ausschließlich** gegen Ziele, für die du eine
ausdrückliche Erlaubnis hast — ein dokumentiertes Bug-Bounty-Programm
(HackerOne/Intigriti/YesWeHack) im definierten Scope, oder einen
autorisierten Pentest mit schriftlichem Auftrag. Aktive Enumeration gegen
Ziele außerhalb deines Scopes ist in Deutschland nach §§ 202a, 202b, 202c
StGB strafbar. Kein Haftungsausschluss ersetzt eigene Sorgfalt.

## Diskussion

Fragen, eigene Setups, Findings? Zone "Hacking & Security" im
[FlowKI Club Discord](https://flowki-club.de/join?utm_source=github&utm_medium=repo&utm_campaign=content-launch-2026-07).

## Lizenz

MIT — nutzen, forken, anpassen.
