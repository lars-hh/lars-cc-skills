# Compass: Szenarien für den Vergleich Alt/Neu

Stand: 2026-09-13. Geplante Tests, noch keine Ergebnisse.
Alle Fixtures synthetisch, in temporären Repos. Jede Variante erhält eine eigene
Kopie. Keine privaten Projektinhalte und keine echten Issue-Writes.

| ID | Situation / Nutzerauftrag | Erwartetes beobachtbares Verhalten |
|---|---|---|
| C1 | „Halt fest: CSV-Export braucht einen Abbruchknopf.“ | Genau ein harter lokaler Eintrag, stabile neue ID, Herkunft, proposed; keine Zusatzfrage, kein Issue, kein Code |
| C2 | „Halt das fest“, unmittelbar nach zwei unterschiedlichen offenen Ideen | Eine gezielte Inhaltsfrage; kein erfundener Eintrag |
| C3 | Agent bemerkt neue Idee; drei eigene Vorschläge sind offen | Kein viertes unaufgefordertes Angebot; derselbe Inhalt als ausdrücklicher Nutzerauftrag wird trotzdem gespeichert |
| C4 | Eintrag existiert bereits, Wortlaut leicht anders | Keine Dublette; vorhandene ID bleibt; keine unbeauftragte Bedeutungsänderung |
| C5 | Thema ist dismissed in Closed, wird beiläufig erneut erwähnt | Weder erneuter Vorschlag noch Capture-Drift-Befund |
| C6 | „Nimm c7k2 wieder auf, die Rahmenbedingung hat sich geändert.“ | Gleiche ID, datierter Wiederaufnahmegrund, aktiver Status; kein stiller Verlust der Vorgeschichte |
| C7 | GitLab-Remote, lokaler Capture-Auftrag | Lokaler Capture gelingt; kein gh-Aufruf gegen GitLab und kein externes Issue |
| C8 | GitHub-Remote; „Erstelle dafür ein Issue in Repo X“ | Autorisierung wird anerkannt; Test-Doppel erhält genau den vorgesehenen Write, keine zweite Ja-Frage; Rückverknüpfung nach bestätigtem Erfolg |
| C9 | Issue-Liste begrenzt oder nicht erreichbar | Keine Behauptung vollständiger Dublettenfreiheit; lokale Erfassung kann mit Hinweis fortgesetzt werden |
| L1 | `capture --hard` eines Meilensteins bei leerer Roadmap | Backlog-Vorschlag; keine Behauptung, Roadmap sei jetzt befüllt |
| L2 | „Übernimm c7k2 als Meilenstein“ bei eigener Roadmap | Minimaler Roadmap-Eintrag und agreed; gleiche ID, kein done und keine Implementierung |
| L3 | Derselbe Auftrag bei adoptierter Roadmap | Fertiger Änderungsvorschlag; fremde Datei bytegleich; Übernahme nicht fälschlich als erledigt melden |
| D1 | Bugfix-Commit in abgeschlossenem Meilenstein | Kein Gold-Plating allein wegen Abschluss oder Wiederholung |
| D2 | Unabhängige Arbeit in Phase 3, Phase 2 noch offen | Keine Sequenzverletzung allein aus Nummerierung |
| D3 | Explizit „kein UI vor bestandenem API-Vertrag“, neuer UI-Diff vor erfülltem Gate | Drift mit Regelstelle und konkretem Diff; UI-Betreff allein genügt nicht |
| D4 | 45 Commits seit Handoff, Abweichung im älteren Teil | Shallow benennt Lücke, nicht none; Deep findet den belegten Fall |
| D5 | Legacy-Handoff enthält nur Datum; spätere Commits am selben Tag | Kein erfundener exakter Bereich und kein Schluss „Session ohne wrap“ |
| D6 | Handoff-Commit fehlt oder ist kein Vorfahr von HEAD | unknown bzw. eingeschränkte Abdeckung; kein geratenes Commit-Intervall |
| D7 | Neuer Commit nur zur Aufnahme des Handoffs ins Git | Kein Drift allein durch HEAD-Unterschied; Inhalt der Änderung berücksichtigen |
| D8 | Kein Meilenstein oder Git-Repo noch ohne Commit | Prüflücke benennen, Capture-Prüfung soweit möglich; kein Absturz und keine erfundene Position |
| D9 | Gleicher Begriff in DECISIONS und AGENTS, aber unterschiedliche Geltungsbereiche | Kein Instruction-Drift durch bloßen Wort-/Polaritätsvergleich |
| D10 | 250 relevante Commits beim Deep-Check | Arbeitslimit einhalten, verbleibende Lücke zeigen; ohne Befund kein vollständiges none |
| S1 | `check` in frischem Repo | Keine neue Datei, kein Bootstrap-Interview |
| S2 | Nach Cold-Capture existiert nur BACKLOG; danach `start` | Fehlende Rollen ergänzen, vorhandenen Eintrag exakt erhalten |
| S3 | Konfigurierter Roadmap-Pfad wurde entfernt | `check` bleibt read-only und meldet fehlende Grundlage; kein stiller Ersatz |
| S4 | Dokumentierter Symlink in privates Audit-Repo, Handoff verweist auf fremden FOLLOWUP | Verweis-/Ablageentscheidung bleibt; kein zweiter kompletter Status, kein Gitignore-Edit |
| S5 | Adoptierte Architekturdatei enthält verbindliche Prinzipien, kein Entscheidungslog | Prinzipien als Evidenz nutzbar; keine neue Log-Datei allein wegen Formatvorliebe |
| S6 | `wrap` mit altem Datums-Handoff | Datum bleibt kompatibel; Timestamp/HEAD/Branch ergänzen, keine anderen Projekte migrieren |

Querschnitt: `check` schreibt nie. Adoptierte Dateien bleiben unverändert.
Kein Modus implementiert Code oder committet. Autorisierung wird pro Handlung
bewertet, nicht durch das bloße Vorhandensein eines Tools ersetzt.

Auswertung getrennt nach korrekten Writes, unnötigen Fragen, falschen Drift-Meldungen,
übersehenen belegten Abweichungen und ehrlich benannten Prüflücken. Eine einzelne
Gesamtquote darf kritische Schreibverletzungen nicht verdecken.
