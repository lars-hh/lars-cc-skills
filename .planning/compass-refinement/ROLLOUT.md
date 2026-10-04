# Compass-Rollout 2026-10-04

Veröffentlichter Skill-Commit: `9c37e9c75c5b` auf `origin/main`.
Nur Compass, seine Learnings und Planungsunterlagen wurden committet.
Vorhandene fremde Änderungen an anderen Dateien blieben unberührt.

| Ziel | Ausführung | Nachweis |
|---|---|---|
| Claude global, Business und Privat | Marketplace per CLI aktualisiert; Plugin mit scope user aktualisiert | Beide Accounts aktiviert; gemeinsames Installationsregister zeigt 9c37e9c75c5b |
| Claude project scope /Users/lars | Plugin mit scope project im zugehörigen Verzeichnis aktualisiert | Register zeigt 9c37e9c75c5b |
| Codex global | Skill Installer aus veröffentlichtem GitHub-Commit nach ~/.codex/skills/compass | Alle sechs Paketdateien bytegleich |
| Desktop/compass-export | Unveränderte alte Exportkopie geprüft und ersetzt; Setup angepasst | Alle sechs Paketdateien bytegleich |

Auch für beide Claude-Installationsbereiche wurden alle sechs Dateien gegen die
Quelle verglichen. Die Plugin-Inventur meldet einen Skill, keine Hooks und keine
Agenten. Keine Cache-Dateien wurden direkt gepatcht.

## Reichweite

Globale Installationen stehen lokal projektübergreifend zur Verfügung, soweit keine
Projektkonfiguration sie deaktiviert. Claude Business/Privat teilen sich hier das
Plugin-Register; ein Benutzer-Update erreicht beide. Neue Claude-Session starten,
damit der bereits geladene alte Text nicht weiterverwendet wird. Der Codex-Skill
steht ab dem nächsten Turn zur Verfügung.

Die lokale Suche über Home einschließlich Desktop und Documents fand keine
aktiven repo-eigenen `.claude/skills/compass`- oder `.agents/skills/compass`-Kopien.
Build-/Abhängigkeitsverzeichnisse, .git, Library und der Evaluationsworkspace wurden
übersprungen. Alte SHA-Caches und ein ungenutzter Codex-Marketplace-Katalog sind
keine aktiven Skill-Installationen und wurden nicht als Projektkopien überschrieben.

Vorhandene `.compass/`-Projektdateien sind Daten, keine Skill-Installation, und
wurden nicht verändert. Die neue Version liest sie kompatibel.

Nicht belegt/aktualisiert: andere Rechner, nicht lokal vorhandene Checkouts und
Cloud-Umgebungen. Ein GitHub-Push allein aktualisiert diese nicht. Cloud-Repos
brauchen eine mit dem Repo committete Skill-Kopie oder einen dort konfigurierten
Plugin-Installationsweg. Dafür `scripts/sync-skills.sh <repo> compass` ausführen,
anschließend genau die Skill-Kopie im Zielrepo committen und pushen.

## Spätere Releases

Claude: Marketplace und Compass per regulärer CLI aktualisieren. Codex-Standalone-
Kopie und Exportpaket separat synchronisieren. Es wurde kein Hintergrundjob
angelegt; ein globaler Installationsort spart Projektkopien, ersetzt aber keinen
späteren Update-Vorgang. Keine unbestätigte automatische Cloud-Verteilung behaupten.
