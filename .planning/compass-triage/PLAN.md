# compass Stufe 1.5: Vorschlags-Triage + Backlog-Hygiene

## Context

compass nimmt Punkte auf, aber nichts bringt sie je zu „agreed" oder „dismissed". Befund 23.10.:

| Repo | offen (hard) | `status: proposed` gesamt |
|---|---|---|
| CouchCue | 13 | 31 (Backlog > 260 Zeilen, plus Abschnitte außerhalb des Vertrags: „Erledigt: …", „Weitere Nachweise") |
| fantasy-espn | 11 | 12 |
| homeassistant | 14 | 8 |

Folgeschaden: Die Anti-Nag-Regel (`SKILL.md` Abschnitt „Anti-nag and boundaries") zählt Vorschläge ohne Markierung als eigene Vorschläge von compass. Mit mehr als drei offenen Vorschlägen bietet compass in diesen Repos also nie mehr unaufgefordert etwas an. Ziel: Ein kleiner Triage-Weg und eine Hygiene-Meldung, **ohne State-Datei und ohne Hooks**. Die Stufen 3 und 4 (SessionStart-Recall, Stop-Netz) werden bewusst nicht gebaut.

Werkzeuge laut Lars: Struktur nach **create-plans** (Aufgaben mit files/action/verify/done, Checkpoints). Anpassung mit den **Meta-Skills** `taches-toolkit:create-agent-skills` (Leitfaden beim Editieren) und `taches-toolkit:audit-skill` (Audit danach). Wiederverwendet wird das erprobte Muster aus dem Refinement im September: `lars-cc-skills/.planning/compass-refinement/` (`PLAN.md`, `SCENARIOS.md`, `evals.json`, `RESULTS.md`, `ROLLOUT.md`). Neue Artefakte kommen nach `.planning/compass-triage/` daneben. Der skill-creator-Eval-Loop geht wegen #77213 nicht (genestetes `claude -p` → 401), deshalb wie im September ein Agenten-Vergleich alt gegen neu.

## Verhaltensvertrag (neu)

**`start`: Triage nach dem Briefing**
- Kandidaten: Einträge unter `## Active (hard)` mit `status: proposed`, deren `**from:**`-Datum ≥ 30 Tage alt ist, ohne `kept:`-Marke jünger als 30 Tage. Die ältesten zuerst, **höchstens 3**.
- Einmal pro Session, nach dem Briefing (dessen 12-Zeilen-Limit bleibt), ein gebündeltes AskUserQuestion, je Eintrag: **annehmen** → `agreed` · **verwerfen** → `dismissed`, nach Closed, `[ ]` bleibt · **behalten** → ` · kept: YYYY-MM-DD` anhängen.
- Antwortet Lars nicht oder lenkt ab → **nichts schreiben**. Undatierte Einträge kommen nicht in die Triage (ihr Alter ist unbekannt).
- Die Triage ist kein neuer Vorschlag und zählt nicht gegen den Governor. Soft-Items bleiben draußen, sie sind ausdrücklich tentativ.

**`check`: zwei Hygiene-Zeilen** (bleibt read-only, zählt nicht zu den max. 3 Drift-Befunden)
- `Backlog: N proposals ≥ 30 Tage (älteste: <id> <datum>), M undatiert`. Ab N ≥ 1 der Hinweis auf `start`.
- `Backlog-Format: Abschnitte außerhalb des Vertrags: „…"`. Gemeldet werden H2 außer Active/Loose ends/Closed sowie Einträge ohne ID oder `from`. **Nie reparieren.** Umbauen nur auf ausdrücklichen `capture`-Auftrag.

**BACKLOG-Vertrag:** optionales Feld `kept: YYYY-MM-DD` (mehrfach erlaubt, das jüngste zählt).

## Tasks

**Task 0: Baseline und Leitfaden** (auto)
- files: —
- action: Skill `taches-toolkit:create-agent-skills` laden und dessen Regeln für die Edits übernehmen, insbesondere Progressive Disclosure: Details in die Referenzen, `SKILL.md` schlank. Baseline-SHA festhalten (`git -C ~/Desktop/claude/lars-cc-skills rev-parse HEAD`, aktuell `475d1d2`). Die alte Skill-Version für den Vergleich nach `~/Desktop/claude/compass/refinement-workspace/iteration-2/old_skill` kopieren.
- verify: Snapshot ist bytegleich mit `skills/compass` (`diff -r`).

**Task 1: Vertrag in Skill und Referenzen** (auto)
- files: `skills/compass/SKILL.md` (BACKLOG-Vertrag: `kept:`-Bullet · `## start`: 3–4 Zeilen Triage mit Verweis · `## check`: 1 Zeile Hygiene mit Verweis · Anti-nag: Triage zählt nicht), `references/artifacts.md` (Skelett-Beispiel mit `kept:`), `references/drift.md` (neuer Abschnitt „Backlog hygiene" mit Regeln für Zählung und Format), `references/bootstrap.md` nur falls `start` dort Ablaufschritte hat.
- action: Verhalten wie im Vertrag oben. Struktur-Tokens bleiben englisch (`kept:`), die Prosa ist englisch wie bisher. `SKILL.md` ≤ 235 Zeilen (aktuell 219). Keine neuen Modi, keine Skripte, keine Hooks.
- verify: Frontmatter-YAML valide, alle Referenzpfade existieren, Code-Fences geschlossen, `wc -l`.
- done: Alle vier Vertragspunkte stehen genau an einer Stelle, ohne Doppelungen zwischen SKILL und Referenzen.

**Task 2: Szenarien und Vergleich alt gegen neu** (auto)
- files: `.planning/compass-triage/SCENARIOS.md`, `evals.json` (Format wie `compass-refinement/evals.json`), Fixtures unter `~/Desktop/claude/compass/refinement-workspace/iteration-2/`.
- action: Synthetische Git-Fixtures in temporären Repos (keine echten Projektinhalte). Zwei Agents, einer mit der alten und einer mit der neuen Version explizit geladen, je Fall eine frische Kopie. Neue Fälle:
  - T1 · 5 proposed, davon 2 ≥ 30 Tage → genau diese 2 angeboten, die ältesten zuerst
  - T2 · Antworten annehmen/verwerfen/behalten → `agreed` in place · nach Closed mit `[ ]` · `kept:`-Marke
  - T3 · `kept` vor 10 Tagen → nicht angeboten
  - T4 · keine alten Vorschläge → keine Triage-Frage
  - T5 · `check` mit Fremdabschnitten + alten Vorschlägen → beide Hygiene-Zeilen, kein Byte geändert
  - T6 · undatierte Einträge → nicht in der Triage, in `check` als „undatiert" gezählt
  - T7 · Triage abgelehnt oder ignoriert → nichts geschrieben
  - T8 · adoptierte Roadmap und `.planning/` bleiben bytegleich
  - Regression: C1, D3, S1 aus `compass-refinement/SCENARIOS.md`.
  Weil AskUserQuestion im Subagent nicht beantwortbar ist, wird die Triage-Antwort im Prompt vorgegeben („Lars antwortet: q8m2 annehmen …").
- verify: Snapshots/Hashes je Fall; zentraler Abgleich der erlaubten Schreibpfade (nur `.compass/BACKLOG.md`, nur bei T2).
- done: Neue Version besteht T1–T8 und die Regressionen; keine Schreibverletzung. Ergebnis in `.planning/compass-triage/RESULTS.md`.

**Task 3: Audit** (auto)
- action: `taches-toolkit:audit-skill` auf `skills/compass/SKILL.md`. Befunde nur übernehmen, wenn sie den Vault-/Repo-Konventionen nicht widersprechen (Memory: „Vault-Konv. sticht Auditor"). Abweichungen begründet in RESULTS.md.
- done: Kritische Audit-Befunde behoben oder begründet abgelehnt.

**Checkpoint 1: human-verify am echten Repo** (blocking)
- what-built: neue Version lokal geladen (`claude --plugin-dir` oder Session im Quellrepo mit explizit gelesenem SKILL.md).
- how-to-verify: In `~/Desktop/claude/CouchCue` zuerst `/compass:compass check`. Erwartet: beide Hygiene-Zeilen, `git status` unverändert. Dann `/compass:compass start` → Triage mit höchstens 3 Einträgen. Lars entscheidet echt, danach `git diff .compass/BACKLOG.md` ansehen.
- resume-signal: „passt" oder Befund.

**Task 4: Release und Rollout** (auto, nach Checkpoint)
- files: nur `skills/compass/**`, `docs/skill-learnings.md` (compass-Eintrag 2026-10-xx), `.planning/compass-triage/**`.
- action: Commit nur dieser Pfade. Die fremden uncommitteten Änderungen (`.gitignore`, `LICENSE` …) bleiben unberührt. Danach `git push`, dann in beiden Accounts `claude plugin marketplace update lars-cc-skills` und `claude plugin update compass@lars-cc-skills`. **Zusätzlich die Codex-Kopie `~/.codex/skills/compass` aus dem veröffentlichten Stand synchronisieren**: Sie ist heute schon veraltet, die `Goal:`-Änderung von `475d1d2` fehlt dort. `ROLLOUT.md` des Septembers nennt außerdem `Desktop/compass-export`, den Ordner gibt es nicht mehr. Das wird in `.planning/compass-triage/ROLLOUT.md` vermerkt, nicht neu angelegt.
- verify: `diff -rq skills/compass ~/.codex/skills/compass` leer; Plugin-Cache-SHA = Release-SHA in beiden Accounts; `claude plugin list` zeigt compass mit 1 Skill, 0 Hooks.

**Task 5: Vault nachziehen** (auto)
- files: `~/Documents/second-brain/Notes/workflow/coding-workflow-goal-compass.md` (Entscheidungstabelle: Zeile „compass 1.5"), `~/Desktop/claude/compass/HANDOFF.md` (Stand: Stufe 1.5, Stufe 2–4 zurückgestellt).

## Nicht im Umfang

State-Datei, Hooks, Jaccard-Code (Stufe 2), SessionStart-Recall/Stop-Netz (Stufen 3–4), automatische Migration bestehender Backlogs (CouchCue wird nur gemeldet), Triage für Soft-Items, Trigger-Messung (#77213).

## Verification (Ende-zu-Ende)

1. Szenario-Vergleich T1–T8 + Regression grün, Snapshots ohne Schreibverletzung (Task 2).
2. Echter Lauf CouchCue: `check` schreibt nichts, `start` triagiert höchstens 3, `git diff` zeigt nur die gewählten Status-/`kept:`-Änderungen (Checkpoint 1).
3. Rollout: Claude-Cache in beiden Accounts und die Codex-Kopie bytegleich mit dem Release-Commit (Task 4).
