# Contributing to lars-cc-skills

This marketplace curates skills from across the Claude Code ecosystem, refines them where useful, and attributes them cleanly. We don't accept every skill — quality and license hygiene matter more than quantity.

## Before opening a PR

1. Read `docs/adding-a-skill.md` for the full workflow
2. Run `scripts/audit-license.sh` against the proposed skill
3. Run `scripts/verify-attribution.sh` to make sure the upstream source is correctly attributed

## What we accept

- Single-purpose, atomic skills (one job, one skill)
- Knowledge-worker use cases: vault tooling, research, writing, light coding
- Permissive licenses only: MIT, Apache-2.0, BSD. **No GPL/AGPL** (incompatible with marketplace MIT)
- Skills with verified LICENSE files at the upstream repo

## What we don't accept

- Skills from repos without a LICENSE file (license = null in GitHub metadata)
- Sales/CRM/marketing-focused skills (not the marketplace's focus)
- Homelab-specific MCP wrappers
- Skills that require external SaaS OAuth (vendor lock-in)
- Skills that overlap with what `taches-cc-resources`, `superpowers`, or `claude-md-management` already do well (recommend those as Companions instead)

## Refinement vs. Vanilla

A skill can enter the marketplace **vanilla** (verbatim from upstream) or **refined** (modified with `taches:audit-skill`, `taches:heal-skill`, custom additions). Both are fine. Either way:

- `origin.yaml` records the upstream source, the last upstream check, and `divergence_notes` describing any modifications
- `THIRD_PARTY_LICENSES.md` lists the original author and license

See `docs/veredelung-workflow.md` (German for "refinement workflow") for the 8-step process.

## License audit

See `docs/license-audit.md` for the checklist every skill must pass before release.
