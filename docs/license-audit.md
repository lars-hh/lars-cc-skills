# License Audit Checklist

Run before merging any skill PR into the marketplace.

## Repo-level check (DO THIS FIRST)

Before reading the skill itself:

1. **Visit the upstream repo on GitHub**
2. **Check the License sidebar** on the right side of the repo page
3. **Run** `gh api repos/<owner>/<repo>/license` — does it return JSON or 404?

If the license field is `null`, the License sidebar is missing, or the API returns 404:

**STOP. The repo is not cherry-pick-able**, regardless of how trivial the skill is.

This is non-negotiable. GitHub's default-no-license policy (`"license": null` = all rights reserved) overrides good intentions. Even a 3-line single-purpose prompt skill cannot be redistributed in a public MIT marketplace.

**Action:** open a GitHub issue at the upstream repo politely asking them to add a license. Note it in `Resources/marketplace-watchlist.md`. Move on to an alternative.

This rule comes from Lesson 7 (2026-05-19, ComposioHQ verification). See the watchlist Review Log.

## Skill-level checklist

Once the repo has a valid LICENSE file, verify per-skill:

- [ ] `skills/<name>/LICENSE` exists (copy verbatim from upstream)
- [ ] `skills/<name>/origin.yaml` declares the same license
- [ ] License is in the allowed list (MIT, Apache-2.0, BSD-2-Clause, BSD-3-Clause, ISC)
- [ ] If Apache-2.0 and upstream has a NOTICE file: `skills/<name>/NOTICE` exists too
- [ ] `THIRD_PARTY_LICENSES.md` has a `### <skill-name>` section
- [ ] Original author is correctly attributed (especially for redistributor sources like davila7)

## Redistributor-specific checks

For skills sourced from aggregator repos (davila7/claude-code-templates, alirezarezvani/claude-skills, etc.):

- [ ] **Verify the original author** in the SKILL.md frontmatter `author:` field, README, or a header comment
- [ ] If the original author differs from the aggregator: attribute to **both** in `origin.yaml` (`original_author:` and a note that the aggregator redistributed it)
- [ ] If the original author has their own repo: link to it as `fallback_source:` and consider sourcing directly from them in a future version

## Manifest-says-MIT-but-no-file edge case

Sometimes a plugin's `plugin.json` declares MIT but the repo has no LICENSE file. This happened with `multica-ai/andrej-karpathy-skills`.

Resolution options (in priority order):

1. **Open an upstream PR** adding a LICENSE file (preferred — clean fix)
2. **Open an upstream issue** asking for explicit licensing (slower but works)
3. **Include the skill with a Risk Note** in `origin.yaml notes:` and a paragraph in `THIRD_PARTY_LICENSES.md` documenting the manifest-only declaration
4. **Skip the skill** for now and revisit when the upstream responds

Option 1 is what we did for multica-ai. Document the PR/issue URL in `origin.yaml notes:`.

## LICENSE-filename edge case

Some upstreams ship the license as `LICENSE.txt`, `LICENSE.md`, or `COPYING` rather than the bare `LICENSE` filename that `scripts/audit-license.sh` checks for. The script does NOT support multiple filename globs — it expects exactly `skills/<name>/LICENSE`.

**Resolution:** copy the upstream file verbatim into `skills/<name>/LICENSE` (no symlink — atomic content, not a reference). Document the rename in `origin.yaml divergence_notes` so the lineage is auditable.

**Example from Phase 2.5** (changelog-skill): upstream `myl7/changelog-skill` ships `LICENSE.txt`. We copied it as `LICENSE` and noted in `divergence_notes`:

> LICENSE filename: upstream is `LICENSE.txt`, copied locally as `LICENSE` so audit-license.sh finds it without a glob change. SPDX identifier and license text unchanged.

**Why not patch the script to accept multiple filenames?** Defense in depth — the marketplace's standard filename is `LICENSE` (no extension). A single canonical name means no ambiguity about what the audit script reads. The rename happens once at import time, then never again.

## Automation

```bash
./scripts/audit-license.sh
```

Runs the basic checks. Manual verification still needed for the repo-level check (the script can't tell intent — only the human reviewer can decide if a "no license" repo is salvageable via upstream contact).

## Updating this checklist

When we hit a new license edge case, add a section here and update Lesson N in `Resources/marketplace-watchlist.md`. The watchlist is the strategic doc; this file is the operational checklist.
