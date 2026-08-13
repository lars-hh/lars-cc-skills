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
