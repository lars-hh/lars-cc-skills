# Adding a Skill to the Marketplace

This document describes the end-to-end workflow for proposing and adding a skill to `lars-cc-skills`.

## TL;DR

1. Find an upstream skill with a permissive license
2. Run the license audit
3. Decide: vanilla or refined
4. Add the skill to `skills/<name>/`
5. Update `marketplace.json` and `THIRD_PARTY_LICENSES.md`
6. Run all scripts to verify

## Full workflow

### Step 1 — Source discovery

Find a candidate skill. Sources we trust:

- `davila7/claude-code-templates` (large redistributor — verify original author per skill)
- `alirezarezvani/claude-skills` (large collection — cherry-pick atoms)
- `anthropics/skills` (first-party Apache-2.0)
- Single-purpose repos with clear license (e.g., `myl7/changelog-skill`)

**Hard requirement:** the upstream repo MUST have a LICENSE file. Repos with `"license": null` in GitHub's metadata cannot be cherry-picked. See `docs/license-audit.md`.

### Step 2 — Read the upstream SKILL.md

Before copying anything, read the source SKILL.md carefully:

- Does it have `allowed-tools` declarations? Are they reasonable?
- Are there bash calls? What do they do? Network access?
- Does it depend on external services (OAuth, API keys, cloud-only)?
- Is the original author clearly identified (especially in redistributor repos)?

If any answer is "I don't know," stop and dig deeper before adding.

### Step 3 — License audit

Run:

```bash
./scripts/audit-license.sh
```

The skill must have a `LICENSE` file in `skills/<name>/` and an `origin.yaml` declaring a permissive license (MIT, Apache-2.0, BSD, ISC).

### Step 4 — Refinement decision

Decide vanilla or refined. Both are valid.

- **Vanilla:** copy upstream SKILL.md as-is, add `origin.yaml`, add LICENSE, done.
- **Refined:** use `taches:audit-skill` → `taches:heal-skill` → manual customizations → `taches:audit-skill` again. Document the changes in `origin.yaml divergence_notes`.

See `docs/veredelung-workflow.md` for the 8-step refinement process.

### Step 5 — Add to `skills/<name>/`

Minimum files:

```
skills/<name>/
├── SKILL.md           # The skill itself
├── LICENSE            # Upstream's LICENSE (copy verbatim)
└── origin.yaml        # Source tracking
```

Optional:

```
skills/<name>/
├── NOTICE             # Required for Apache-2.0 sources if upstream has one
├── EXAMPLES.md        # Refined skills can include refined-specific examples
└── README.md          # If the skill needs its own context
```

### Step 6 — `origin.yaml` schema

```yaml
inspired_by: owner/repo            # GitHub slug of the upstream
source_url: https://github.com/... # Full URL to the upstream repo
source_path: path/to/SKILL.md      # Path inside the upstream repo
last_upstream_check: 2026-MM-DD    # Date of the last drift check
upstream_commit: <40-char SHA>     # Pinned commit for drift detection
license: MIT                        # SPDX identifier (MIT, Apache-2.0, BSD-*, ISC)
version: 1.0.0                      # Mirrors SKILL.md frontmatter for refined skills
original_author: name               # Especially important for redistributor repos
fallback_source: owner/repo         # Optional: alternative if upstream dies
divergence_notes: |                 # What we changed (or "vanilla")
  - vanilla   # ...or specific notes
known_deviations: |                 # Optional: audit findings deliberately left unfixed
  - XML migration deferred to v0.2
notes: |                            # Optional: free-text context (bus-factor, LICENSE risks, follow-ups)
  - Bus-factor low, fallback verified
```

### Step 7 — Update marketplace files

- `THIRD_PARTY_LICENSES.md`: add a `### <skill-name>` section
- `.claude-plugin/marketplace.json`: add the skill to the `plugins` array

### Step 8 — Verify

Run all three scripts:

```bash
./scripts/audit-license.sh
./scripts/verify-attribution.sh
./scripts/check-upstream.sh
```

All three should exit 0.

### Step 9 — Local install test

```bash
/plugin marketplace add /path/to/lars-cc-skills
/plugin install <skill-name>@lars-cc-skills
```

Verify the skill loads and works as expected.

### Step 10 — Open PR

PR description should include:

- Upstream source link
- License (and link to upstream LICENSE file)
- Vanilla / refined and what was changed
- Why the skill belongs in this marketplace
