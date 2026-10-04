# Compass: Umsetzung und Abnahme

Stand der Abnahme: 2026-09-13. Rollout am 2026-10-04 abgeschlossen für die
gefundenen aktiven Installationen auf diesem Mac; Details unter ROLLOUT.md.

## Geändert

- Klare lokale Capture-Aufträge schreiben ohne zweite Wortlautbestätigung.
- Statuspflege und ausdrückliche Übernahme in eine eigene Roadmap funktionieren
  innerhalb von capture; laufende/erledigte Status werden nicht zurückgesetzt.
- Closed dient dem Dublettenabgleich, bleibt aus Vorschlägen und Briefings heraus.
- Drift verlangt eine geltende Regel und belegte abweichende Arbeit. Teilprüfungen
  bekommen unknown statt pauschaler Entwarnung. Shallow 30, Deep maximal 200 Commits,
  jeweils mit Überlauferkennung; konkrete Diffs statt bloßer Commit-Betreffzeilen.
- Handoff hat optionale Zeit-/HEAD-/Branch-Felder; bestehende Dateien bleiben gültig.
- Setup vervollständigt Teilbestände. Dokumentierte private Symlinks und Verweise
  auf fremde Übergaben bleiben erhalten. Konsolidierte Entscheidungen sind zulässig.
- Issue-Ziel und Code-Remote werden getrennt; GitLab wird nicht an gh gegeben.
  Keine implizite Veröffentlichung aus einem lokalen Capture-Auftrag.
- Ursprungshinweise und Learnings sind aktualisiert. Der Hauptskill hat 213 Zeilen
  (vorher 262); drei Referenzen tragen Details. Keine Hooks oder neuen Frameworks.

## Ausgeführte Szenarien

Zwei getrennte Agenten mit ausdrücklich geladener alter bzw. neuer Skill-Version
haben je neun synthetische Szenarien mit echten lokalen Git-Fixtures ausgeführt.
Fixture-Commits sind Vorbereitung; während des geprüften Skill-Verhaltens wurde
nicht committet. Dateisnapshots, Hashes, Tool-Ausgaben und Antworten liegen je Fall vor.

| Fall | Beobachtung der neuen Version |
|---|---|
| C1: lokales Capture | Ein Backlog-Eintrag, keine zusätzliche Frage |
| C5: verworfenes Thema | Kein neuer Eintrag oder Drift-Befund |
| L2: Roadmap-Übernahme | Eigene Roadmap ergänzt, ID erhalten, agreed statt done |
| D1: Wartung nach Abschluss | Kein falscher Drift-Befund |
| D3: explizites API-vor-UI-Gate verletzt | Regel, offenes Gate und UI-Diff belegt |
| D4: 45 Commits, älterer Scope-Verstoß | Shallow unknown; Deep findet die Abweichung |
| S1: check ohne Setup | Keine Datei angelegt |
| S2: start nach Cold-Capture | Fehlende Rollen ergänzt; Backlog unverändert |
| S4: privater Symlink/fremder Handoff | Nur eigener Handoff geändert, Verweisstrategie erhalten |

Neue Version: neun Szenarien bestanden, 19 geprüfte Erwartungen erfüllt. Zusätzlich
wurden die Snapshots zentral auf erlaubte Schreibpfade, identischen HEAD, erhaltenen
Backlog und unveränderten Symlink geprüft. Keine Schreibverletzung gefunden.

Die alte Version ließ C1 und L2 auf einer zusätzlichen Bestätigung warten. L2 wurde
mit demselben Aufruf wiederholt, damit ein unbekannter Modus nicht den Vergleich
verfälscht. Die übrigen sieben Fälle behandelte auch die alte Version korrekt.
Insbesondere wurden keine universellen Fehlalarme der alten Drift-Prüfung bewiesen.

## Statische Prüfung und Nachbesserung

Die übrigen 19 geplanten Szenarien wurden als Vertragsprüfung gelesen, nicht als
Laufzeittests ausgegeben. Ein unabhängiger Prüfer fand zwei angrenzende Fälle:
Statusrücksetzung bei Roadmap-Transfer und GitHub-Issue-Ziel neben GitLab-Origin.
Beide sind in der finalen Fassung korrigiert.

## Technische Prüfung

- YAML-Frontmatter, origin.yaml, Referenzpfade, Code-Fences und Größenlimit: bestanden.
- `scripts/audit-license.sh`: 6/6 bestanden.
- `scripts/verify-attribution.sh`: 6/6 bestanden.
- `git diff --check`: bestanden.
- `claude plugin validate .`: bestanden; bestehende Warnung über fehlende Version
  bei Marketplace-Eintrag plugins[6], nicht Compass. SHA-Versionierung bleibt erhalten.
- Echte lokale Marketplace-Aufnahme und Plugin-Installation in getrennter
  `CLAUDE_CONFIG_DIR`-Testkonfiguration: bestanden.
- `claude plugin details`: 1 Skill, 0 Hooks, 0 Agenten.
- Installierter Hauptskill und alle drei Referenzen: bytegleich mit der Quelle.

Die Testinstallation stammt aus dem Arbeitsbaum. Ihr Cache trägt die bisherige
Git-SHA als Verzeichnisname; dieser Name ist kein neuer Release-Beleg. Deshalb
wurden die tatsächlichen Dateien verglichen. Der produktive Cache wurde nicht gepatcht.

## Aussagegrenzen

Die Agenten kannten die Erwartungen und bauten unabhängig äquivalente, nicht
bytegleiche Fixtures. Auch die Zahl der Einzelassertionen unterscheidet sich.
Deshalb keine A/B-Prozentsteigerung, Statistik oder erfundenen Token-/Zeitmetriken.
Keine Auto-Trigger-Messung, keine echte GitHub-Issue-Erstellung, keine Langzeit-
Bewährung und keine Aussage über unsichtbare frühere Gespräche. Neun ausgeführte
Szenarien plus 19 statisch geprüfte Fälle sind nicht 28 bestandene Laufzeittests.

## Belege und Installation

Workspace: `/Users/lars/Desktop/claude/compass/refinement-workspace/`.

- `skill-snapshot/`: alte Version.
- `iteration-1/old_skill/` und `iteration-1/with_skill/`: Antworten, Auswertung,
  Vorher-/Nachher-Snapshots und Aktionsprotokolle pro Fall.
- `contract-review.md`: unabhängige statische Prüfung vor den beiden Korrekturen.
- `install-smoke.json`: Installationsprüfung.
- `review.html`: Skill-Creator-Viewer mit 18 Alt-/Neu-Ausgaben und Grading.

Der Quellstand 9c37e9c75c5b ist inzwischen veröffentlicht und auf diesem Mac
installiert. ROLLOUT.md dokumentiert Ziele, Dateivergleich und verbleibende
Reichweitengrenzen. Historische Testdaten oben bleiben unverändert.
