# Veredelungs-Workflow (Refinement Workflow)

10-step process for refining an upstream skill with `taches-cc-resources` and Anthropic-official tooling. „Veredelung" is German for refinement — kept as the project's term to distinguish from generic „customization."

## When to refine vs. when to use vanilla

**Vanilla** is fine when:
- The skill works as-is for the marketplace's audience
- The upstream is well-maintained and the author would update it themselves
- Adding customization would dilute the skill's clarity

**Refine** when:
- The skill is good but missing a needed mode/option (e.g., German language support)
- The upstream is stale but the core is sound
- The skill needs marketplace-specific behavior (e.g., security-auditor needs to check our marketplace's structure)

## Tooling used by this workflow

| Tool | Type | Invocation | Step |
|------|------|------------|------|
| `create-plan` | slash command | `/taches-cc-resources:create-plan <what to plan>` | 0 |
| `create-plans` | skill (wrapped by `create-plan`) | invoked automatically | 0 |
| `skill-creator` | skill | `Skill(skill="skill-creator")` or read its SKILL.md as a checklist | 3 |
| `skill-auditor` | subagent | `Agent(subagent_type: "taches-cc-resources:skill-auditor")` | 2, 7 |

**Note on `skill-creator` scope here:** for marketplace v0.1 veredelung we use only the
"Write the SKILL.md", "Writing Patterns" and "Writing Style" sections as a
checklist when drafting new sections (e.g., the GSD-abgrenzung section in
karpathy-skills, the Marketplace Compliance section in security-auditor). The
full eval/benchmark loop (test cases, subagent runs, viewer, iteration) is
reserved for v0.2 from-scratch skills.

## The 10 steps

### 0. Generate a phase-level sub-plan (refined skills only)

```bash
# Manual invocation (slash command from user)
/taches-cc-resources:create-plan refine <skill-name> from <upstream-repo>
```

The slash command invokes the `create-plans` skill, which produces a sub-plan
at `~/.claude-personal/plans/phase-X-Y-<slug>-<adjective>.md` with:

- Objective + context
- 2-3 atomic tasks per sub-plan (aggressive atomicity)
- Verification criteria
- Critical files to read / modify

**Skip Step 0** for vanilla imports unless the phase has unusual complications
(e.g., Apache-2.0 NOTICE-file discipline, LICENSE-PR coordination).

### 1. Source import + LICENSE-File-Check

```bash
PIN=$(gh api repos/<upstream>/commits/main | jq -r .sha)
mkdir -p skills/<name>
curl -sL "https://raw.githubusercontent.com/<upstream>/$PIN/<path>/SKILL.md" \
  -o skills/<name>/SKILL.md
curl -sL "https://raw.githubusercontent.com/<upstream>/$PIN/LICENSE" \
  -o skills/<name>/LICENSE
```

If upstream has **no LICENSE file** despite a manifest license declaration
(common pattern — composiohq, multica-ai/andrej-karpathy-skills), the
decision tree:

1. Open an upstream PR with a LICENSE file matching the manifest declaration.
2. If urgent: reconstruct LICENSE locally based on the manifest declaration,
   with a header comment naming the gap and `notes:` entry in `origin.yaml`.
3. If neither: skip the source and find an alternative.

Run `./scripts/audit-license.sh` to confirm.

### 2. Baseline audit (vanilla source)

```
Agent(
  subagent_type: "taches-cc-resources:skill-auditor",
  prompt: "Audit skills/<name>/SKILL.md as imported from upstream. \
           Provide baseline findings before refinement begins."
)
```

The auditor reports issues in three categories:
- **Compliance:** frontmatter, allowed-tools, file structure
- **Quality:** description clarity, examples, error handling
- **Best practices:** progressive disclosure, length, atomicity

Use the report as a baseline. Findings the upstream owns are not blockers
unless they affect marketplace compliance.

### 3. Structural refinement skeleton (skill-creator principles)

For each new section you add to the refined skill, apply the principles from
`skill-creator/SKILL.md`:

- **Imperative form** in instructions.
- **Defining output formats** as `ALWAYS use this exact template:` blocks.
- **Examples pattern** with explicit `Input:` / `Output:` pairs.
- **Theory of mind > heavy-handed MUSTs** — explain *why* something is
  important, not just demand compliance.
- **Lean prompts** — remove paragraphs not pulling their weight before commit.

Read `skill-creator/SKILL.md` sections "Write the SKILL.md", "Writing Patterns"
and "Writing Style" once at the start of a phase as a checklist. Do NOT run
its full eval/benchmark loop for v0.1 marketplace refinement — that's
reserved for v0.2 from-scratch skills.

### 4. Manual customization

This is the actual refinement work. Examples from this marketplace:

- **humanizer:** added a German variant with 12 German AI-writing patterns
- **obsidian-markdown:** added configurable `wikilink_style` modes
- **security-auditor:** added marketplace-specific audit checks
- **karpathy-skills:** corrected owner attribution + added GSD abgrenzung

Keep customizations focused. If you find yourself rewriting >50% of the
skill, consider creating a new one from scratch instead of refining.

Required frontmatter for refined skills:

```yaml
---
name: <skill-name>           # matches marketplace.json plugin name
version: 1.0.0               # refined skills track their own version
description: |               # rewritten if upstream description was thin
  ...
license: MIT|Apache-2.0|BSD-*|ISC
allowed-tools: <explicit list, no Bash:* wildcards>
---
```

### 5. Test against real inputs

For each customization, run the skill against representative inputs and
record outputs in `skills/<name>/EXAMPLES.md`. Note that Claude cannot invoke
the marketplace's own skills from inside the authoring session — these
examples are pattern-match predictions, not live runs. The end-user runs
the live test after `/plugin install`.

If the skill ships a script (e.g., security-auditor's `marketplace_audit.sh`),
the bash output IS a live run and should be captured verbatim in `EXAMPLES.md`.

### 6. Document the divergence

Update `skills/<name>/origin.yaml`:

```yaml
inspired_by: owner/repo
source_url: https://github.com/owner/repo
source_path: path/to/SKILL.md
last_upstream_check: YYYY-MM-DD
upstream_commit: <sha>            # pinned for drift detection
license: MIT
version: 1.0.0                    # mirrors SKILL.md frontmatter
original_author: "Real name (handle) — https://github.com/handle"
fallback_source: owner/repo       # optional
divergence_notes: |
  - Specific changes with why-context
known_deviations: |
  - Known audit findings deliberately left unfixed, with reason
notes: |
  - Bus-factor / LICENSE-risk / Lars-action follow-ups
```

Be specific. "Customized for our needs" is not useful; "Added German pattern
list (12 patterns G1-G12)" is.

### 7. Re-audit

```
Agent(
  subagent_type: "taches-cc-resources:skill-auditor",
  prompt: "Audit skills/<name>/SKILL.md (refined version, with origin.yaml \
           context). Critical issues + Quick Fixes + Recommendations."
)
```

Make sure the audit still passes, or that new failures are deliberate and
documented in `origin.yaml known_deviations`.

### 8. Apply audit fixes

Pattern that worked across humanizer, obsidian-markdown, security-auditor:

1. Initial commit (the refined skill as it stands).
2. Read audit report → apply Critical Issues + Quick Fixes in-place.
3. Second commit: `<skill>: apply audit fixes (N critical + N quick)`.
4. Document deferrals (e.g., XML migration) in `known_deviations`.

### 9. Verification scripts + commit

```bash
./scripts/audit-license.sh         # LICENSE + SPDX allowlist
./scripts/verify-attribution.sh    # THIRD_PARTY_LICENSES.md ↔ origin.yaml
./scripts/check-upstream.sh        # drift detection vs. pinned commit
./skills/security-auditor/scripts/marketplace_audit.sh skills/<name>/   # combined
```

All must PASS for the skill (the marketplace `--all` summary will still show
TBD skills as FAIL until they are filled).

Update `THIRD_PARTY_LICENSES.md` — replace any TBD placeholder for this
skill with the real upstream + author + license details.

Atomic commits per skill (initial + audit-fix). Don't bundle multiple
skills in one commit.

## When refinement goes off the rails

Signs to step back:

- You're rewriting more than 50% of the skill — consider a from-scratch
  skill instead, with proper attribution.
- The customizations are very Lars-specific and not generalizable — they
  belong in the user's CLAUDE.md, not in a public marketplace skill.
- The refinement breaks the original skill's clarity — keep the original,
  document the friction in `divergence_notes`, and consider opening an
  upstream issue.

## Vanilla-import shortcut

For vanilla skills (no refinement intended):

1. Step 1 (source import + LICENSE)
2. Write origin.yaml with `divergence_notes: vanilla`
3. Step 9 (verification + commit)

Skip steps 0, 2, 3, 7, 8. Step 5 (test) is encouraged but not blocking.
