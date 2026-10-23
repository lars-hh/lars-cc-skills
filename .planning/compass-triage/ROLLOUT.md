# Compass-Rollout 2026-10-24 (Stufe 1.5)

Release-Commit `034f68b276cb` auf `origin/main`. Committet nur `skills/compass/**`,
`docs/skill-learnings.md` und `.planning/compass-triage/**`; fremde uncommittete Änderungen
(`.gitignore`, `LICENSE`, `CONTRIBUTING.md`, `THIRD_PARTY_LICENSES.md`, changelog-skill) unberührt.

| Ziel | Ausführung | Nachweis |
|---|---|---|
| Claude Privat + Business (gemeinsames Register) | `claude plugin marketplace update` + `plugin update compass@lars-cc-skills` je Account | beide `Version: 034f68b276cb`; Cache `compass/034f68b276cb` bytegleich mit Release (nur `.in_use`-Marker extra) |
| Codex global `~/.codex/skills/compass` | `git archive HEAD skills/compass` → `rsync --delete` | `diff -rq` leer. Holt auch die `Goal:`-Änderung aus `475d1d2` nach, die dort fehlte |
| `Desktop/compass-export` (Rollout 09/26) | — | Ordner existiert nicht mehr; nicht neu angelegt |

Laufende Sessions nutzen den alten Text bis zum Neustart. Andere Rechner und Cloud-Repos
sind nicht aktualisiert (siehe `compass-refinement/ROLLOUT.md`, „Spätere Releases").
