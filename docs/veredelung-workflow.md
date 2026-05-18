# Veredelungs-Workflow (Refinement Workflow)

8-step process for refining an upstream skill with `taches-cc-resources` tools. „Veredelung" is German for refinement — kept as the project's term to distinguish from generic „customization."

## When to refine vs. when to use vanilla

**Vanilla** is fine when:
- The skill works as-is for the marketplace's audience
- The upstream is well-maintained and the author would update it themselves
- Adding customization would dilute the skill's clarity

**Refine** when:
- The skill is good but missing a needed mode/option (e.g., German language support)
- The upstream is stale but the core is sound
- The skill needs marketplace-specific behavior (e.g., security-auditor needs to check our marketplace's structure)

## The 8 steps

### 1. Source import

```bash
# Copy upstream SKILL.md and LICENSE
mkdir -p skills/<name>
cp /path/to/upstream/SKILL.md skills/<name>/
cp /path/to/upstream/LICENSE skills/<name>/
```

If upstream has no LICENSE file, **stop**. Open an upstream PR or pick an alternative source.

### 2. Audit

```bash
# Audit the imported skill for compliance and best-practices issues
claude /taches-cc-resources:audit-skill skills/<name>/SKILL.md
```

The audit reports issues in three categories:
- **Compliance:** frontmatter, allowed-tools, file structure
- **Quality:** description clarity, examples, error handling
- **Best practices:** progressive disclosure, length, atomicity

### 3. Heal

For each issue the audit reports:

```bash
claude /taches-cc-resources:heal-skill skills/<name>/SKILL.md
```

This is interactive — the heal-skill skill proposes changes, you approve or modify.

### 4. Customize

This is the actual refinement work. Examples from this marketplace:

- **humanizer:** added a German variant with German AI-writing patterns
- **obsidian-markdown:** added configurable `wikilink_style` modes
- **security-auditor:** added marketplace-specific audit checks
- **karpathy-skills:** corrected owner attribution

Keep customizations focused. If you find yourself rewriting the skill, consider creating a new one instead of refining this one.

### 5. Test

For each customization, test against real data:

```bash
# For humanizer
echo "Sample text with em-dashes" | claude /humanizer

# For obsidian-markdown
claude /obsidian-markdown "Create a note about X"

# Document representative outputs in skills/<name>/EXAMPLES.md
```

### 6. Document the divergence

Update `skills/<name>/origin.yaml`:

```yaml
divergence_notes: |
  - Added German pattern list (24 English + ~15 German)
  - Whitelist for Lars-specific writing tells (Fragmente, „naja")
  - English foundation preserved
```

Be specific. "Customized for our needs" is not useful; "Added German pattern list" is.

### 7. Re-audit

After customization:

```bash
claude /taches-cc-resources:audit-skill skills/<name>/SKILL.md
```

Make sure the audit still passes (or that the new failures are intentional and documented).

### 8. Commit

```bash
git add skills/<name>/
git commit -m "Add <skill-name> (refined from <upstream>)

- Imported from <upstream-url> at <date>
- Refinements: <one-line summary>
- License: <SPDX>"
```

Atomic commit per skill. Don't bundle multiple skills in one commit.

## When refinement goes off the rails

Signs to step back:

- You're rewriting more than 50% of the skill — consider a from-scratch skill instead, with proper attribution
- The customizations are very Lars-specific and not generalizable — they belong in the user's CLAUDE.md, not in a public marketplace skill
- The refinement breaks the original skill's clarity — keep the original, document the friction in `divergence_notes`, and consider opening an upstream issue
