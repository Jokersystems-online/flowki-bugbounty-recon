# Scope-Analyse-Prompt

Bug-Bounty-Programme haben oft seitenlange Scope-Dokumente. Manuelles Lesen
kostet 15-20 Minuten pro Programm. Dieser Prompt extrahiert die relevanten
Punkte in ~40 Sekunden.

```bash
pbpaste | claude --prompt "Extrahiere aus diesem Bug-Bounty-Scope-Dokument:
1. Erlaubte Assets (Domains, IPs, Subdomains)
2. Explizit ausgeschlossene Assets
3. Akzeptierte Vulnerability-Klassen
4. NICHT akzeptierte Findings (mit Begründung)
5. Besonderheiten (z.B. 'keine DoS', 'keine Social Eng.')
Format als Markdown-Liste."
```

Immer gegen das Original-Dokument gegenchecken — der Prompt ersetzt kein
Lesen, er beschleunigt das Extrahieren der wichtigen Punkte.

## Live-Asset-Filtering

Nach `httpx` gegen die Subdomain-Liste hast du typisch 200-2000 Hosts. Dieser
Prompt priorisiert:

```bash
cat httpx_results.json | claude --prompt "Analysiere diese httpx-Outputs.
Gib mir eine priorisierte Liste der interessantesten Targets für Bug-Bounty-Hunting.
Berücksichtige:
- Ungewöhnliche Ports / Technologien
- Auth-Panels, Admin-Interfaces
- Alte Frameworks die bekannte CVEs haben
- Staging-/Dev-Instanzen
Gib mir Top 20 mit Begründung pro Eintrag."
```

Die Einschätzung ist nicht immer richtig — sie ist ein Startpunkt, keine
Wahrheit. Menschliche Validierung bleibt Pflicht.
