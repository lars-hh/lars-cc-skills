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

A skill can enter the marketplace **vanilla** (verbatim from upstream) or **refined** (modified with marketplace-specific additions). Both are fine. Either way:

- `origin.yaml` records the upstream source, the last upstream check, and `divergence_notes` describing any modifications
- `THIRD_PARTY_LICENSES.md` lists the original author and license

See `docs/veredelung-workflow.md` (German for "refinement workflow") for the 10-step process. Refined skills use three tools in defined steps:

- **`/taches-cc-resources:create-plan`** (Step 0) — generates a phase sub-plan
- **`Skill(skill-creator)`** (Step 3) — writing-patterns checklist for new sections (not the full eval/benchmark loop, which is reserved for v0.2 from-scratch skills)
- **`Agent(subagent_type: "taches-cc-resources:skill-auditor")`** (Steps 2 + 7) — baseline audit before refinement, re-audit after

Vanilla skills use a shorter path — see the Vanilla-import shortcut section in `docs/veredelung-workflow.md`.

## License audit

See `docs/license-audit.md` for the checklist every skill must pass before release.

## Learnings & maintenance

- **Skill learnings live in `docs/skill-learnings.md`** — one `## <skill>` section each, append-only
  with a dated entry (`- YYYY-MM-DD (Label): …`). Each `SKILL.md` carries a Block-A pointer to its
  section. This is for *running* findings from use/test/maintenance; upstream attribution and
  deliberate divergence stay in `origin.yaml`. Do **not** put public-skill learnings in a personal
  vault — they ship with the repo so they reach every clone and cloud session.
- **Versioning is commit-SHA-based.** Plugins use `source: directory` and carry **no per-plugin
  `version`** in `marketplace.json` — so every push is detected as an update (`/plugin marketplace
  update` → `/plugin update`). **Do not add a per-plugin `version` field to `marketplace.json`** — it
  would override SHA detection and require a manual bump on every change. Any `version` in `SKILL.md`
  or `origin.yaml` is informational only (e.g. mirroring upstream), not an update trigger.
- **Single source of truth:** edit skills only in this repo. Installed/cached copies are downstream
  and get overwritten on update.

## marketplace.json — validated schema (2026-06-23)

The v0.1.0 `marketplace.json` had two latent schema bugs that only surfaced on the first real
`/plugin marketplace add` + install (install-tests never ran at launch). Correct structure:

```jsonc
{
  "name": "lars-cc-skills",
  "owner": { "name": "Lars Nowak", "email": "..." },   // OBJECT, not a string
  "metadata": { "description": "...", "version": "0.1.0" },  // description+version live HERE, not top-level
  "plugins": [
    { "name": "caveman", "description": "...", "category": "...",
      "source": "./skills/caveman" }                   // STRING path for local plugins
  ]
}
```

Two gotchas (both break silently until install):
1. **`owner` must be an object** `{name, email}` — a string fails registration (`expected object, received string`).
2. **Per-plugin `source` must be a string path** (`"./skills/<name>"`) for local dirs — the object form
   `{"source": "directory", "path": "..."}` throws *"source type your Claude Code version does not support"*.

Mirror a known-working marketplace (`ai-plugins`, `taches-cc-resources`) when in doubt. Run a real
`/plugin marketplace add` + `/plugin install <one>@lars-cc-skills` as the actual acceptance test —
`marketplace_audit.sh`/`verify-attribution.sh` do **not** catch these.
