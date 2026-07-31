#!/usr/bin/env bash
# URL-Discovery aus Web-Archiven + aktivem Crawl.
# From: https://flowki-club.de/blog/2026-04-19-osint-pipelines-mit-claude-code
set -euo pipefail

# Wayback Machine + Common Crawl
gau --subs "$TARGET" > urls-passive.txt

# Aktiver Crawl der Live-Subdomains
katana -list ../tech/live-only.txt -d 2 -jc -kf all -o urls-active.txt

# Filtern auf interessante Dateitypen
cat urls-passive.txt urls-active.txt | sort -u | \
  grep -E '\.(php|asp|aspx|jsp|js|json|xml|sql|bak|env|log|conf)$' > urls-interesting.txt
