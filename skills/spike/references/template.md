# Spike Document Template

Copy this template for every spike. The frontmatter is the machine-readable layer —
the prior-check (charter question 4) greps `question:`, `verdict:` and `tags:` across
all spike docs, so keep those fields accurate.

## Frontmatter

```yaml
---
type: spike
status: open              # open | closed
question: "Given <precondition>, when <action>, then <observable outcome>?"
verdict: null             # null | VALIDATED | REFUTED | PARTIAL | INCONCLUSIVE
budget: "5 iterations"    # agreed in the charter
used: 0                   # increment with every investigation-trail entry
project: <project-name>
tags: [api, feasibility]  # lowercase, greppable
created: YYYY-MM-DD
closed: null              # set when verdict is written
---
```

## Body sections

```markdown
# Spike: <question as title>

## Charter
- **Question (G/W/T):** Given … when … then …
- **Trigger & consequence:** Who asks, why now, and what the verdict decides.
  (A verdict that changes nothing means this is not a spike.)
- **Budget:** <n> iterations · Abort criterion: <when we stop and write INCONCLUSIVE>
- **Prior check:** <hits from the index scan and what was decided about them>

## Prediction
State what sources claim BEFORE experimenting — the experiment then tests a
real expectation instead of confirming a vibe.
- [OFFICIAL] <docs URL + claim, quoted or tightly paraphrased>
- [COMMUNITY] <forum/blog URL + claim>
- **We expect:** <one sentence>

## Setup
Reproducibility is the point — a stranger must be able to re-run this.
- **System:** <tenant/portal/host — identifiers, never credentials>
- **Auth:** <path to the credential source, NEVER the value>
- **Exact requests/commands:** <method + endpoint + params, or script path>
- **Window/sample:** <time cutoff, sample size> · **Caps:** <pagination/API limits>

## Investigation Trail
One line per iteration. Each line counts against the budget.
| # | What was tried | Result (numbers) |
|---|---|---|

## Findings
Numbers, not adjectives.
| Measurement | Value | Note |
|---|---|---|

Raw data: <path> · Scripts: <path>

## Verdict & Learnings
**Verdict:** VALIDATED | REFUTED | PARTIAL | INCONCLUSIVE — <one sentence>
**Counter-check:** <what was tested that could have flipped this verdict —
mandatory for VALIDATED; a single happy-path run never validates>
- Learning: <including any common assumption this overturned>
- ⚠️ Not tested / limitations: <…>

## Reusables
<script / pattern / filter recipe with path — the thing another project copies>

## Follow-ups
<where the outcome was routed: task / issue / backlog item / "none because …">
```

## Verdict vocabulary (canonical, uppercase, English)

| Token | Meaning |
|---|---|
| `VALIDATED` | Question answered YES, with counter-check evidence |
| `REFUTED` | Question answered NO — equally valuable, prevents wasted builds |
| `PARTIAL` | Works with material caveats; name them |
| `INCONCLUSIVE` | Budget exhausted, question still open — honest, not a failure |

Never soften these into prose ("mostly works"). One token, then the nuance below it.
