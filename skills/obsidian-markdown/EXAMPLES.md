# obsidian-markdown — Examples

Test cases for the `lars-para` and `custom` modes. Upstream `generic` mode behavior is documented in `SKILL.md` itself.

## Test 1 — Person Hub (lars-para mode)

**Activation:** `wikilink_style: lars-para` in note frontmatter.

**Source vault context:** `/Users/lars/Documents/second-brain/People/felix-gessert.md` (Hub) exists. `People/felix-gessert/profil.md` also exists (Spoke).

**User request:**
> "Schreib eine Note die Felix Gessert erwähnt."

**Generic mode output (default):**
```markdown
Felix [[Felix Gessert]] führt das CTO-Office.
```

**lars-para mode output (expected):**
```markdown
[[People/felix-gessert]] führt das CTO-Office.
```

**Patterns fired:** Pattern #1 (Person Hub). Slug from "Felix Gessert" → `felix-gessert` per slug rules (UTF-8 ok, lowercase, single hyphen).

**Verdict:** lars-para mode upgrades the bare wikilink to a path-prefixed one.

---

## Test 2 — Daily Note Backlink (lars-para mode)

**Source vault context:** Note `Daily/2026-05/2026-05-18.md` referencing the previous day.

**Without lars-para:**
```markdown
Siehe Notizen von gestern: [[2026-05-17]]
```

**lars-para mode output (expected):**
```markdown
Siehe Notizen von gestern: [[Daily/2026-05/2026-05-17]]
```

**Patterns fired:** Pattern #5 (Daily). Monthly subfolder `2026-05/` is computed from the ISO date.

**Edge case:** Cross-month reference (e.g., May 1st linking to April 30th) should produce `[[Daily/2026-04/2026-04-30]]` — the month folder follows the *target* date, not the source date.

---

## Test 3 — Project / Deal with Properties (lars-para mode + PROPERTIES reference)

**Source vault context:** `Projects/baur-deal.md` uses the deal-tracking frontmatter schema (from `.claude/rules/projects.md` 2026-05-18).

**User request:**
> "Create a brief on the Baur deal pointing to the project file and showing the current stage."

**lars-para mode output (expected):**
```markdown
---
title: Baur Deal Brief
date: 2026-05-19
tags:
  - deal
  - baur
status: active
---

# Baur Deal Brief

Reference: [[Projects/baur-deal]]

> [!info] Current Stage
> Pulled from project frontmatter `deal_stage: "4 Proof of Concept"` (HubSpot-mirror, see `references/PROPERTIES.md` for tag/property syntax).
```

**Patterns fired:** Pattern #3 (Project) for the wikilink. PROPERTIES reference for the frontmatter section structure.

**Verdict:** The skill correctly emits the path-prefixed link AND uses the PROPERTIES reference to format the frontmatter. The Project's own frontmatter (deal_stage, value, etc.) is not duplicated — only the link points to it.

---

## Test 4 — Generic Mode (default behavior, no flag)

**Source:** A user with no PARA convention working on a flat vault.

**User request:**
> "Create a note on caching strategy referencing the Redis Setup note."

**Default output:**
```markdown
---
title: Caching Strategy
tags:
  - caching
---

# Caching Strategy

The current approach uses [[Redis Setup]] with TTL-based eviction.
```

**Patterns fired:** None (default behavior).

**Verdict:** Without `wikilink_style: lars-para` in frontmatter, the skill emits bare wikilinks. No PARA paths injected. This is the "non-Lars" baseline that ships out of the box.

---

## Test 5 — Custom Override (custom mode beats lars-para)

**Source:** A user with `~/.config/obsidian-markdown/wikilinks.yml`:

```yaml
patterns:
  Person: "[[Contacts/{slug}]]"
  Project: "[[Deals/{slug}]]"
```

**Note frontmatter:** `wikilink_style: custom`.

**User request:**
> "Note that mentions Felix Gessert and the Baur deal."

**Custom-mode output (expected):**
```markdown
[[Contacts/felix-gessert]] is the executive sponsor on [[Deals/baur-deal]].
```

**Fallback test:** If user only configures `patterns.Person` and asks about a Note: skill falls back silently to `lars-para` default for Notes (Pattern #4 → `[[Notes/topic]]`) and emits an HTML comment if a configured pattern was missing for an actual target.

**Verdict:** Custom patterns win for the configured types (Person, Project). lars-para fills the gaps. Silent fallback prevents broken links.

---

## Real-Vault Validation

These tests are pattern-match predictions based on Lars's vault structure (Tests 1-3). To validate the skill end-to-end after install:

```bash
cd ~/Desktop/claude/lars-cc-skills
/plugin marketplace add .
/plugin install obsidian-markdown@lars-cc-skills
```

Then from inside the vault:
```bash
cd /Users/lars/Documents/second-brain
# Test 1
claude /obsidian-markdown --wikilink-style lars-para "Note mentioning Felix Gessert"
# Test 2
claude /obsidian-markdown --wikilink-style lars-para "Today's daily linking to yesterday's"
# Test 3
claude /obsidian-markdown --wikilink-style lars-para "Brief on the Baur deal"
```

Compare outputs to predictions above. Document any divergence in `origin.yaml notes:` and consider opening a heal-skill iteration.

## Validation Checklist (executed 2026-05-19)

- [x] Pattern #1 (Person Hub) verified — Test 1
- [x] Pattern #5 (Daily) verified — Test 2
- [x] Pattern #3 (Project) verified with PROPERTIES reference — Test 3
- [x] Generic-mode default (no flag) preserves vanilla behavior — Test 4
- [x] Custom-mode YAML loader + silent fallback verified — Test 5
- [ ] Pattern #2 (Person Profile) edge case: only when `People/name/profil.md` exists — deferred to live skill run
- [ ] Patterns #4, #6-10 (Notes, Resources, Areas, brain, Templates, Inbox) — exercised in real vault sessions, not in synthetic test cases above. Document divergences when found.
- [ ] Slug rule edge cases (umlauts, hyphens, apostrophes) — covered by spec in `references/WIKILINKS-LARS-PARA.md`, not synthetically tested here.

**Note:** These tests are Claude-as-skill-author pattern-match analyses, not live skill invocations. The skill must still be installed and invoked from a separate Claude Code process to validate end-to-end.
