# Compass 1.5: Szenarien Alt/Neu

Stand: 2026-10-23. Baseline `475d1d287bf3`. Fixtures synthetisch:
`~/Desktop/claude/compass/refinement-workspace/iteration-2/fixture_setup.py`. Heute = 2026-10-23,
„alt" = `from` ≥ 30 Tage (≤ 2026-09-23).

| ID | Situation / Auftrag | Erwartet (neue Version) |
|---|---|---|
| T1 | 5 hard proposed, 2 alt (a1aa 08-01, b2bb 09-10); `start`, keine Antwort | Triage-Frage genau zu a1aa, b2bb in dieser Reihenfolge; nichts geschrieben |
| T2 | 3 alt (a1aa, f6ff, b2bb) + 3 neu; Antwort: a1aa annehmen, f6ff verwerfen, b2bb behalten | a1aa `agreed` in place · f6ff `dismissed` in Closed mit `[ ]` · b2bb `kept: 2026-10-23`; sonst bytegleich; nur BACKLOG geändert |
| T3 | a1aa alt mit `kept: 2026-10-13`, b2bb alt | Nur b2bb angeboten; nichts geschrieben |
| T4 | nur junge Vorschläge | Keine Triage-Frage, keine Erwähnung |
| T5 | `check`: alte + undatierte Vorschläge, Eintrag ohne ID, Fremdabschnitte „Erledigt: …", „Weitere Nachweise", Goal-Präambel | Zeile `Backlog: 3 stale proposals (oldest: a1aa 2026-08-01), 1 undated` (+ Hinweis start) und `Backlog format:` mit beiden Abschnitten + ID-losem Eintrag (Einträge in den Fremdabschnitten nicht doppelt); Präambel nicht gemeldet; kein Byte geändert; Drift-Token unbeeinflusst |
| T6 | undatierter u9uu + alter b2bb | Nur b2bb angeboten |
| T7 | wie T1, Antwort „nicht jetzt" | Nichts geschrieben |
| T8 | adoptierte `.planning/ROADMAP.md` + `STATE.md`; Antwort a1aa annehmen | a1aa `agreed`; `.planning/**` bytegleich; nur BACKLOG geändert |
| C1 | Regression: „Halt fest: …" im frischen Repo | Ein harter Eintrag, keine Zusatzfrage |
| D3 | Regression: UI-Diff vor bestandenem API-Gate | `Drift: found.` mit Regel + Diff |
| S1 | Regression: `check` ohne Setup | Keine Datei angelegt |

Querschnitt: `check` schreibt nie; kein Commit; adoptierte Dateien bytegleich.
