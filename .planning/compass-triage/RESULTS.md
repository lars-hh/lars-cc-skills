# Compass 1.5: Umsetzung und Abnahme

Stand: 2026-10-23. Baseline `475d1d287bf3`. Plan: `PLAN.md`, Szenarien: `SCENARIOS.md`.

## Geändert

- `SKILL.md` (219 → 231 Zeilen): `kept:`-Feld im BACKLOG-Vertrag, Triage-Absatz in `start`,
  Hygiene-Verweis in `check`, Triage außerhalb des Governors, Dispatch-Zeile und Schreibpfad nennen die Triage.
- `references/artifacts.md`: Abschnitt „Backlog triage" — einzige Definition der Triage-Schwelle
  (30 Tage), *stale*/*undated*, Fragegestaltung, Schreibregeln, Headless-Skip, gewollte Wiedervorlage.
- `references/drift.md`: Abschnitt „Backlog hygiene" (zwei Zeilen, nie Reparatur, ändern den
  `Drift:`-Token nicht) und Platz im Report-Template.
- Keine Hooks, keine Skripte, keine State-Datei, keine neuen Modi.

## Vergleich Alt/Neu

Synthetische Fixtures (`iteration-2/fixture_setup.py`), je Variante frische Kopien, ein Agent pro
Variante mit explizit geladener Skill-Fassung, Erwartungen verdeckt. Schreibprüfung über
SHA-256-Snapshots aller Dateien vor/nach (`iteration-2/snap.py`).

| Fall | Alt | Neu |
|---|---|---|
| T1 zwei alte Vorschläge, keine Antwort | keine Triage, nur „Limit überschritten" | Triage a1aa, b2bb (älteste zuerst), nichts geschrieben ✅ |
| T2 annehmen/verwerfen/behalten | Status umgesetzt, „behalten" ohne Spur | agreed in place · dismissed in Closed mit `[ ]` · `kept: 2026-10-23`, Rest bytegleich ✅ |
| T3 `kept` vor 10 Tagen | keine Triage | nur b2bb angeboten ✅ |
| T4 nur junge Vorschläge | Briefing | Briefing, Triage nicht erwähnt ✅ |
| T5 `check` mit Fremdabschnitten | Formatprobleme als Nebenbemerkung | beide Hygiene-Zeilen, `Drift: none.`, kein Byte geändert ✅ |
| T6 undatierter Eintrag | Hinweis „kein Datum" | nur b2bb angeboten ✅ |
| T7 „nicht jetzt" | keine Frage | Frage gestellt, Ablenkung → nichts geschrieben ✅ |
| T8 adoptierte `.planning/` | a1aa agreed, `.planning` bytegleich | gleich ✅ |
| C1 / D3 / S1 (Regression) | bestanden | bestanden ✅ |

Schreibverletzungen: keine. HEAD in allen 22 Repos unverändert; geschrieben nur `.compass/BACKLOG.md`
in C1, T2, T8.

## Audit (`taches-toolkit:audit-skill`)

Keine kritischen Befunde. Übernommen: Budgets von `start` (Triage außerhalb 12 Zeilen/2 Fragen,
entfällt nach Setup-Fragen), undatiert nicht doppelt melden, Position von `kept:`, Dispatch-Zeile,
Frageinhalt + Headless-Skip + Freitext = Ablenkung, Schwelle nur einmal definiert, `start`-Hinweis
zählt nicht als nächster Schritt, Legacy ohne Status = proposed, künftiges `from` = undatiert.

Bewusst abgelehnt:
- **Option „später" gegen Wiedervorlage:** Die Wiedervorlage in der nächsten Session ist gewollt
  (ADHS-Konfrontation, Vault `.claude/rules/session.md`), `keep` ist die Schlummertaste. Jetzt
  ausdrücklich so dokumentiert.
- **Datum bei accept/dismiss:** zusätzliches Feld außerhalb des freigegebenen Plans; nur `kept:`.
- **Reines XML statt Markdown-Überschriften:** Repo-Konvention von lars-cc-skills.
- Quick-Fixes zu bestehendem Text (Learnings-Pfad, doppeltes Backlog-Skelett): außerhalb des Umfangs.

Nachlauf mit der auditierten Fassung (`iteration-2/v2`, T1, T2, T5, T6): alle bestanden. T2 bytegleich
zum ersten Lauf, T5 meldet Einträge in bereits genannten Fremdabschnitten nicht mehr doppelt
(zusätzliche Präzisierung nach dem ersten Lauf).

## Checkpoint am echten Repo (CouchCue, 2026-10-23/24)

- `check`-Hygiene: `Backlog: 1 stale proposals (oldest: q8m2 2026-09-22), 0 undated` und
  `Backlog format:` mit drei Fremdabschnitten („Erledigt: …" ×2, „Weitere Nachweise …"); nichts geschrieben.
- Erwartung vorher war „viele alte Vorschläge"; tatsächlich stammen fast alle von 22.–24.09., nur q8m2
  hatte die Schwelle erreicht. Der Stau ist eher Menge als Alter; die Triage greift ab den nächsten Tagen.
- Triage: eine Frage zu q8m2, Lars: annehmen → genau eine Zeile `proposed` → `agreed`. Lars-Abnahme „passt".

## Offen

- Trigger-Messung weiter blockiert (#77213).

## Nachtrag 2026-10-24: Commit-Vorschlag in `wrap`

Anlass: Lars' Frage, warum compass nie committet. Das Verbot bleibt (Design „Lars' Commit-Regel",
Allowlist ohne `git commit`), aber `wrap` gibt jetzt die fertige Zeile aus, die das Design ursprünglich
vorsah: `git add .compass && git commit -m "compass: wrap <datum>" -- .compass`. Das `-- .compass`
beschränkt den Commit auf die Steuerungsdateien, auch wenn anderes gestaged ist.

- Mechanik vorab in Scratch-Repos geprüft: getrackt + fremde gestagte Datei → nur `.compass/` committet,
  Fremddatei bleibt gestaged; neues `.compass/` (`?? .compass/`) committbar; exclude → `!! .compass/`;
  Symlink → `?? .compass` ohne Slash.
- Agent-Lauf mit neuer Fassung (`iteration-3`): W1 getrackt → Zeile ✅ · W2 exclude → keine Zeile ✅ ·
  W3 privater Symlink → keine Zeile ✅. HEAD überall unverändert. Die Zeile aus W1 ausgeführt: Commit enthält
  nur `.compass/HANDOFF.md`, `export.py` bleibt gestaged ✅.

