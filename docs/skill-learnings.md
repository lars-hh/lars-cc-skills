# Skill Learnings — lars-cc-skills

Zentrale Learnings-Datei für die Skills dieses Toolkits. Jeder Skill hat
eine Sektion; bei Problemen oder neuen Erkenntnissen wird hier **angehängt** (nicht überschrieben).

## Heimat & Abgrenzung

- **Toolkit-Skill-Learnings leben HIER**, im Repo. Die Datei reist mit jedem `git push` auf GitHub
  und in jede Cloud-Session — Skill und seine Learnings bleiben eine Einheit.
- **NICHT** im Second-Brain-Vault: `brain/skill-learnings.md` ist ausschließlich für die
  `/brain:*`-Skills (vault-gekoppelt). Keine Toolkit-Skill-Learnings dorthin.
- Abweichungen vom Upstream (Attribution, bewusste Divergenz, deferred Work) gehören weiterhin in
  `skills/<name>/origin.yaml` (`divergence_notes` / `known_deviations`). **Diese Datei** ist für
  *laufende* Erkenntnisse aus Nutzung/Test/Wartung — nicht für Attribution.

## Append-Konvention

Pro Eintrag eine Zeile, datiert, optional mit Label:

```
- YYYY-MM-DD (Label): <Erkenntnis / Problem / Fix>
```

Labels z. B. `(Build)`, `(Audit)`, `(Live-Test)`, `(Fix)`. Bestehende Einträge nicht löschen,
nur ergänzen. Pflege durch den Maintainer (Lars) — Consumer haben kein Write-Recht aufs Repo.

---

## changelog-skill

*(Upstream: myl7/changelog-skill — vanilla, Apache-2.0.) Noch keine Learnings erfasst.*

## mermaid-diagram-specialist

*(Upstream: davila7/claude-code-templates — vanilla + 6 references.) Noch keine Learnings erfasst.*

## repomix

- 2026-08-13 (Live-Test): CLI war auf dem Mac nicht installiert → Skill unbenutzbar. `brew install repomix` (v1.18.0, zieht node) behoben. Live gegen `skills/spike/` gepackt: 6 Dateien → 4.568 Tokens, Per-File-Breakdown + Security-Check laufen. Skill funktioniert end-to-end.

## security-auditor

*(Upstream: alirezarezvani/claude-skills — refined: marketplace-compliance mode + `marketplace_audit.sh`.) Noch keine Learnings erfasst.*

## create-plans

*(Upstream: glittercowboy/taches-cc-resources — vanilla As-is-Import 2026-06-23, Reshape deferred.) Noch keine Learnings erfasst.*

## create-meta-prompts

*(Upstream: glittercowboy/taches-cc-resources — vanilla As-is-Import 2026-06-23, Reshape deferred.) Noch keine Learnings erfasst.*

## debug-like-expert

*(Upstream: glittercowboy/taches-cc-resources — vanilla As-is-Import 2026-06-23, Reshape deferred.) Noch keine Learnings erfasst.*

## create-agent-skills

*(Upstream: glittercowboy/taches-cc-resources — vanilla As-is-Import 2026-06-23, Reshape deferred.) Noch keine Learnings erfasst.*

## create-slash-commands

*(Upstream: glittercowboy/taches-cc-resources — vanilla As-is-Import 2026-06-23, Reshape deferred.) Noch keine Learnings erfasst.*

## create-subagents

*(Upstream: glittercowboy/taches-cc-resources — vanilla As-is-Import 2026-06-23, Reshape deferred.) Noch keine Learnings erfasst.*

## setup-ralph

*(Upstream: glittercowboy/taches-cc-resources — vanilla As-is-Import 2026-06-23, Reshape deferred.) Noch keine Learnings erfasst.*

## spike

- 2026-07-12 (Build): Erstes authored From-scratch-Skill des Toolkits. Design in 11-Fragen-Session fixiert (Triage-Router, 4-Fragen-Charter-Gate, P0–P5, Config-Ablage, 4-Token-Verdicts, Iterations-Budget). Prior-Art nur als Inspiration (dan-the-dev, kieranpotts, mattpocock, strelov1, gsd-spike). Erst-Test: get-brief-Retest geplant.
- 2026-07-12 (Ersttest, get-brief-Retest, REFUTED): (a) Bei 10-min-Spikes fühlen sich 4 sequenzielle Charter-Runden schwer an — Nutzer der Frage-Schärfe bewusst auf --quick hinweisen oder Q2/Q3 als Batch bestätigen lassen (charter.md-Anpassung erwägen). (b) Realer Stub-Fall mitten im Spike (PoV-Tracker-Frage) funktionierte: lesen-statt-spiken beantwortete sie, Rest als Index-Kandidat geparkt. (c) Design-Limitation: existiert eine User-Config, ist der No-Config-Default auf derselben Maschine nicht mehr natürlich testbar (Resolution-Order) — Default-Test braucht frische Umgebung; für v1 als offen dokumentiert.

## compass

- 2026-08-13 (Build): Zweites authored From-scratch-Skill. Stufe 1 von vier (Dateien + Modi start/check/capture/wrap, ohne Hooks); Stufen 2–4 = Wiedervorlage-State, SessionStart-Recall, Stop-Sicherheitsnetz. Design aus Grill + drei Recherche-Läufen, entschieden in PROPOSAL.md (Design-Docs bleiben in ~/Desktop/claude/compass/, dürfen NICHT ins Skill-Verzeichnis — sync-skills.sh kopiert per `cp -R` ungefiltert und würde sie in jedes Projekt-Repo tragen). Kernentscheidung: Capture im Moment der Erkenntnis, nie als Sammellauf am Session-Ende.
- 2026-08-13 (Design, Koexistenz): compass hat vier **Rollen**, nicht vier feste Dateien — ROADMAP/DECISIONS werden adoptiert falls vorhanden (`.planning/ROADMAP.md` von GSD, Root-`ROADMAP.md`), BACKLOG/HANDOFF gehören immer compass. Regel: was compass besitzt schreibt es, was es adoptiert liest es nur. Ein Planungs-Framework im Repo ist ausdrücklich KEIN Abbruchgrund (der Design-Agent schlug das vor, Lars hat es dreimal anders entschieden) — compass liefert dort die andere Hälfte: fangen und Drift melden gegen die fremde Roadmap.
- 2026-08-13 (Design, Zweifelsfall): Rollen-Auflösung geht über **Inhalt**, nicht über Dateinamen. Belegt an Geldwerk: Root-`DECISIONS.md` heißt so, ist aber unter dem Titel „konsolidierter Architektur-Stand" ein Research-Konsolidat ohne eine einzige Entscheidung. Ein Namensabgleich hätte es adoptiert und danach Entscheidungen gegen ein Dokument geprüft, das keine enthält. Bei Zweifel einmal fragen, Antwort in `.compass/config.md`, nie wieder fragen.
- 2026-08-13 (Design, Abweichungen von PROPOSAL.md): (a) 4-Zeichen-Base36-ID pro Backlog-Item, unveränderlich — PROPOSAL verlangt Wiedervorlage-State ab Stufe 2, gibt ihm aber keinen Schlüssel; textabgeleitete Keys brechen beim ersten Umformulieren. (b) Dritte Sektion `## Closed` als Stufe-1-Mute-Liste, sonst wächst die Datei zur Tapete. (c) Struktur-Tokens englisch (Prosa in Nutzersprache), weil sie ab Stufe 2 maschinell geparst werden — gleiche Doktrin wie spikes englische Verdict-Tokens. (d) Jaccard ≥ 0,65 ist in Stufe 1 nicht implementierbar (`backlog_scan.py` liegt im Vault unter `.agents/scripts/`, aus einem fremden Repo unerreichbar, und Stufe 1 liefert keine Skripte) → Dublettencheck im Modell, Schwelle für Stufe 2 aufgehoben. (e) `.compass/state.json` steht in PROPOSALs Dateitabelle ohne Stufenmarker und liest sich wie Stufe 1 — ist Stufe 2, in Stufe 1 wird keins geschrieben.
- 2026-08-13 (Design, Ehrlichkeit): PROPOSALs Kernversprechen „nichts darf durch die Lappen gehen" wird von Stufe 1 nicht eingelöst und das Dokument sagt das nicht. Ohne Hooks fängt compass nur, was im Kontext liegt und auffällt; `check` liest für Capture-Drift ausschließlich das laufende Gespräch. Steht als Limitation wörtlich im Skill — ein Skill, das Deckung suggeriert und still Dinge verliert, wiederholt genau den Fehler, gegen den es gebaut wurde.
- 2026-08-13 (Sicherheit): `allowed-tools` mit per-Kommando-Allowlist statt blankem `Bash` (das spike legitim trägt, weil P3-Experimente beliebige Kommandos brauchen). compass' Kommandoset ist geschlossen: vier git-Lesebefehle + drei gh-Calls. Nebeneffekt und eigentlicher Grund: „compass committet nie" ist damit erzwungen statt versprochen — `git commit` ist gar nicht erreichbar.
- 2026-08-13 (Tooling, BLOCKIERT): Die Description-Optimierung des skill-creator (`scripts/run_loop.py`, 20 Trigger-Queries) laeuft **nicht aus einer laufenden Claude-Code-Session heraus**. Jeder genestete `claude -p`-Subprozess scheitert mit `Failed to authenticate. API Error: 401 OAuth access token has been revoked` — auch bei einem trivialen Prompt, auch mit `env -u CLAUDECODE` (das Skript entfernt die Variable selbst, das reicht nicht). Bekannter Bug, anthropics/claude-code#77213, CC 2.1.220. Zwei Fallen dabei, beide teuer: (a) Der Lauf meldete `Train: 18/36, precision=100% recall=0%` — das liest sich wie „das Skill triggert nie", war aber ausschliesslich die fehlgeschlagene Auth; jeder der 30 Laeufe lieferte den 401-Text statt einer Antwort. Ein Recall von exakt 0 bei gleichzeitig „perfekter" Precision ist deshalb IMMER erst als kaputtes Messinstrument zu behandeln, nie als Skill-Befund. (b) `run_loop.py --report <pfad>` schreibt seine Live-Report-Datei, BEVOR `--results-dir` angelegt wird → FileNotFoundError; das Zielverzeichnis vorher selbst anlegen. Fix laut Issue: `claude setup-token` und den Token als `CLAUDE_CODE_OAUTH_TOKEN` in die Umgebung des Laufs legen (nicht in die Shell-Profildatei) — dann von einer normalen Shell aus starten, nicht aus einer Session.
- 2026-08-13 (Stufe 3, vorgemerkt — teuer erlernt, NICHT neu herausfinden): (1) Hook-Ausgabe muss verschachtelt in `hookSpecificOutput` mit `hookEventName` stehen; auf Top-Level verwirft Claude Code sie still (`session-context.sh`: 4.880 B stdout → 0 B injiziert). (2) Input von stdin lesen, nicht aus Umgebungsvariablen — `CLAUDE_TOOL_NAME`/`TOOL_INPUT` setzt Claude Code nicht mehr. (3) Nach dem Bau am echten Transcript nachsehen, ob `content` nicht leer ist: ein Hook mit falscher Hülle meldet trotzdem exit 0, „läuft" ist kein Beweis. Belege: lars-hh/second-brain#120, #121, lars-hh/claude-config#1. Dazu (4): Capture hängt nie an einer Trigger-Phrase im Prompt — `remember-capture.sh` schlug auf eine System-Notification an und schrieb 20 KB Müll in die Inbox, bei genau 1 echten Treffer seit Februar.
- 2026-09-13 (Refinement): Stufe-1-Vertrag vereinheitlicht: ein klarer lokaler Capture-Auftrag autorisiert das Schreiben bereits; eigene Angebote brauchen Annahme. Roadmap-Transfer ist explizite Pflege, kein automatischer Effekt von `capture --hard`, und setzt laufende/erledigte Items nicht zurück. Closed wird für Kandidaten-Abgleich gelesen, aber nicht wieder vorgeschlagen. Drift braucht geltende Regel plus konkrete Abweichung; begrenzte/fehlende Evidenz ergibt `unknown` statt Scheinsicherheit. Handoff erhält beim nächsten Wrap optionale Zeit-/HEAD-/Branch-Felder, Altbestände bleiben lesbar. Dokumentierte private Ablage und kompakte Verweise auf fremde Handoffs bleiben erhalten. Belege/Abnahme: `.planning/compass-refinement/`.
- 2026-09-13 (Präzisierung früherer Learnings): Eine konsolidierte Architekturdatei kann verbindliche Entscheidungen enthalten — Geldwerks aktuelle DECISIONS.md nennt explizit entschiedene Prinzipien. Append-only beschreibt das eigene Schreibformat, nicht die Voraussetzung für Adoption. Eine Skill-Tool-Allowlist ist außerdem kein plattformübergreifender technischer Beweis, dass ein Commit unmöglich wäre; der Skill hält die Grenze ausdrücklich ein. Historische Aussagen vom 13.08. sind in diesen Punkten überholt.
