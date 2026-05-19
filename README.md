# lars-cc-skills

Curated Claude Code skills, refined for knowledge workers.

**Status:** v0.1.0 — experimental, in active development.

## What this is

A small, opinionated marketplace of skills picked from across the Claude Code ecosystem, refined where useful, and attributed cleanly. Focused on knowledge-worker workflows — vault tooling, research, writing, light coding — not sales or homelab automation.

## Philosophy

- **Cherry-pick as starting point, not endgame.** Skills get refined via the 10-step workflow in [`docs/veredelung-workflow.md`](docs/veredelung-workflow.md) — sub-plan via `/taches-cc-resources:create-plan`, baseline + re-audit via `Agent(taches-cc-resources:skill-auditor)`, writing-patterns checklist from the official `skill-creator` skill.
- **Origin-tracking, not live-sync.** Each skill carries an `origin.yaml` recording the upstream source, the divergence notes, and the last upstream check. We track for updates, not for identity.
- **License hygiene first.** No skill enters the marketplace without a verified LICENSE file at the source repo. See `docs/license-audit.md`.

## Installation

```bash
/plugin marketplace add lars-hh/lars-cc-skills
/plugin install <skill-name>@lars-cc-skills
```

## Skills (v0.1.0)

| Skill | Source | Mode | License |
|---|---|---|---|
| caveman | [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) | Vanilla | MIT |
| repomix | [yamadashy/repomix](https://github.com/yamadashy/repomix) | Vanilla (CLI wrapper) | MIT |
| security-auditor | [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) | Refined | MIT |
| mermaid-diagram-specialist | [davila7/claude-code-templates](https://github.com/davila7/claude-code-templates) | Vanilla | MIT |
| changelog-skill | [myl7/changelog-skill](https://github.com/myl7/changelog-skill) | Vanilla | Apache-2.0 |
| karpathy-skills | [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | Refined (owner attribution) | MIT |
| humanizer | [blader/humanizer](https://github.com/blader/humanizer) | Refined (German variant) | MIT |
| obsidian-markdown | [davila7/claude-code-templates](https://github.com/davila7/claude-code-templates) | Refined (wikilink convention) | MIT |
| jq | [majiayu000/claude-skill-registry](https://github.com/majiayu000/claude-skill-registry) | Vanilla | MIT |

See `THIRD_PARTY_LICENSES.md` for full attribution.

## Recommended Companions

These are NOT in this marketplace — install them separately. They pair well with what's here.

- **[glittercowboy/taches-cc-resources](https://github.com/glittercowboy/taches-cc-resources)** — Skill-authoring toolkit (audit, heal, create)
- **[obra/superpowers](https://github.com/obra/superpowers)** — Brainstorming, planning, debugging meta-skills
- **[anthropics/claude-md-management](https://github.com/anthropics/claude-plugins-official)** — CLAUDE.md auditing and improvement

## Contributing

See `CONTRIBUTING.md` and `docs/adding-a-skill.md`.

## License

MIT for the marketplace structure, scripts, and refinements. Individual skills under `skills/` may carry their own compatible licenses — see `THIRD_PARTY_LICENSES.md`.
