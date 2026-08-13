# lars-cc-skills

Lars' personal Claude Code skill toolkit — a small, curated set of skills used across my machines, my repos, and cloud sessions.

**Status:** personal toolkit (Werkzeugkasten), actively used and pruned.

## What this is

A **toolbox**, not a public marketplace. Every skill here earns its place by one filter: *do I actually use it?* Some are authored from scratch (`spike`), some are vendored from the Claude Code ecosystem with clean attribution and a permissive license. The distinction that matters is not "mine vs. borrowed" — it's "used vs. dead weight."

It ships two ways at once (full picture in [`docs/deployment.md`](docs/deployment.md)):

- as a **plugin marketplace** for my own machines and one collaborator, and
- as skills you **copy into a repo's `.claude/skills/`** (via `scripts/sync-skills.sh`) so they work in cloud/web sessions with no install and no network.

## Skills

| Skill | Source | Mode | License |
|---|---|---|---|
| spike | — (authored) | Authored | MIT |
| repomix | [yamadashy/repomix](https://github.com/yamadashy/repomix) | Vanilla (CLI wrapper) | MIT |
| security-auditor | [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) | Refined | MIT |
| mermaid-diagram-specialist | [davila7/claude-code-templates](https://github.com/davila7/claude-code-templates) | Vanilla | MIT |
| changelog-skill | [myl7/changelog-skill](https://github.com/myl7/changelog-skill) | Vanilla | Apache-2.0 |
| taches-toolkit | [glittercowboy/taches-cc-resources](https://github.com/glittercowboy/taches-cc-resources) | As-is bundle | MIT |

Skills that were removed, and why: [`docs/removed-skills.md`](docs/removed-skills.md). Full attribution: [`THIRD_PARTY_LICENSES.md`](THIRD_PARTY_LICENSES.md).

## Install

**On my machines / for a collaborator** (marketplace — once per machine):

```bash
/plugin marketplace add lars-hh/lars-cc-skills
/plugin install <skill-name>@lars-cc-skills
```

**Into a specific repo** (so cloud/web sessions have the skills — no install, no network):

```bash
scripts/sync-skills.sh /path/to/target-repo         # all skills
scripts/sync-skills.sh /path/to/target-repo spike   # a subset
```

Then commit `.claude/skills/` in that repo. See [`docs/deployment.md`](docs/deployment.md) for cross-device, cloud sessions, and sharing.

## Companions (installed separately)

- **[obra/superpowers](https://github.com/obra/superpowers)** — brainstorming, planning, debugging meta-skills.
- **[glittercowboy/taches-cc-resources](https://github.com/glittercowboy/taches-cc-resources)** — skill-authoring toolkit (also bundled here as `taches-toolkit`).

## Maintaining

- Add or refine a skill: [`docs/adding-a-skill.md`](docs/adding-a-skill.md) + [`docs/veredelung-workflow.md`](docs/veredelung-workflow.md).
- Running findings from real use: [`docs/skill-learnings.md`](docs/skill-learnings.md).
- Verify: `scripts/audit-license.sh` + `scripts/verify-attribution.sh` (authored skills carry `mode: authored` in `origin.yaml`).

## License

MIT for the toolkit structure, scripts, and refinements. Individual vendored skills under `skills/` carry their own compatible licenses — see `THIRD_PARTY_LICENSES.md`.
