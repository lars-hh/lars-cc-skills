# Contributing to lars-cc-skills

This is a personal toolkit (a Werkzeugkasten), not a community marketplace. It serves one workflow, so the bar is simple: a skill stays only if it is actually used and doesn't duplicate something better elsewhere.

## What belongs here

- Skills I actually reach for — authored from scratch, or vendored from the ecosystem.
- Vendored skills need a **permissive license** (MIT, Apache-2.0, BSD, ISC) with a real LICENSE file at the source, plus an `origin.yaml` and a `THIRD_PARTY_LICENSES.md` entry.
- Single-purpose, atomic skills (one job, one skill).

## What does not belong here

- Anything redundant with my vault `/brain:*` skills, with `superpowers`, or with the bundled `taches-toolkit` — I use those directly instead.
- Skills that require external SaaS OAuth (vendor lock-in) or a live homelab.
- Dead weight: a skill the model already does well without help.

Removed skills and the reason each was cut live in [`docs/removed-skills.md`](docs/removed-skills.md) — read it before re-adding something.

## Adding / refining

1. `docs/adding-a-skill.md` — end-to-end workflow.
2. `docs/veredelung-workflow.md` — refinement (Veredelung) process for vendored skills.
3. `scripts/audit-license.sh` + `scripts/verify-attribution.sh` must pass. Authored skills carry `mode: authored` in `origin.yaml` and need only an `original_author` (no third-party attribution).
4. A real `/plugin marketplace add` + `/plugin install` is the acceptance test — the schema notes below are the traps.

## Learnings & maintenance

- **Skill learnings live in `docs/skill-learnings.md`** — one `## <skill>` section each, append-only with a dated entry (`- YYYY-MM-DD (Label): …`). This is for *running* findings from use/test/maintenance; upstream attribution and deliberate divergence stay in `origin.yaml`. These learnings ship with the repo so they reach every clone and cloud session — do not put them in a personal vault.
- **Versioning is commit-SHA-based.** Plugins use `source: directory` and carry **no per-plugin `version`** in `marketplace.json` — every push is an update (`/plugin marketplace update` → `/plugin update`). **Do not add a per-plugin `version` field to `marketplace.json`** — it would override SHA detection and require a manual bump on every change.
- **Single source of truth:** edit skills only in this repo. Installed/cached copies (and repos synced via `scripts/sync-skills.sh`) are downstream — re-sync after a change.

## marketplace.json — validated schema (2026-06-23)

The v0.1.0 `marketplace.json` had two latent schema bugs that only surfaced on the first real `/plugin marketplace add` + install (install-tests never ran at launch). Correct structure:

```jsonc
{
  "name": "lars-cc-skills",
  "owner": { "name": "Lars Nowak", "email": "..." },   // OBJECT, not a string
  "metadata": { "description": "...", "version": "0.1.0" },  // description+version live HERE, not top-level
  "plugins": [
    { "name": "spike", "description": "...", "category": "...",
      "source": "./skills/spike" }                     // STRING path for local plugins
  ]
}
```

Two gotchas (both break silently until install):

1. **`owner` must be an object** `{name, email}` — a string fails registration (`expected object, received string`).
2. **Per-plugin `source` must be a string path** (`"./skills/<name>"`) for local dirs — the object form `{"source": "directory", "path": "..."}` throws *"source type your Claude Code version does not support"*.

Mirror a known-working marketplace when in doubt. Run a real `/plugin marketplace add` + `/plugin install <one>@lars-cc-skills` as the actual acceptance test — `marketplace_audit.sh` / `verify-attribution.sh` do **not** catch these.
