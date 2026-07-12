# Charter Gate — the four questions

A short, convergent interview before any experiment. Ask **one question at a time**,
always with **one recommended answer** derived from context — the user confirms,
corrects, or redirects. After four questions the charter is complete and building
starts. This is not open-ended brainstorming; it converges.

Answers go directly into the Charter section of the spike document (see template.md).

## Q1 — Make the question falsifiable

Reshape the user's raw question into Given/When/Then and present it back:
"Given <precondition>, when <action>, then <observable outcome>?"

Then ask: **"What would an observable NO look like?"**

- If no observable NO exists, the question is not falsifiable — reject it and
  propose a reformulation. Do not proceed with an unfalsifiable question.
- Good: "Given our tenant API key, when we GET /v2/settings/briefs, then we
  receive a 200 with template data."
- Bad: "Is the briefs API any good?" (no observable NO)

## Q2 — Trigger & consequence

Ask who is asking, why now, and **what the verdict will decide**.

- A spike whose verdict changes nothing is not a spike — recommend parking it
  as an index candidate (`--stub`) or dropping it.
- Capture the consequence in one sentence: "If VALIDATED we do X, if REFUTED we do Y."

## Q3 — Iteration budget & abort criterion

Propose a budget derived from the question's shape:
- single API probe → 2–3 iterations
- data/measurement question → 4–6 iterations
- comparison of two approaches → 6–8 iterations

Also agree the abort criterion: "When do we stop and write INCONCLUSIVE?"
Budget is counted in **iterations** (investigation-trail lines), not hours —
iterations are countable by the skill; hours are not.

## Q4 — Prior-check confirmation

Before this question, the skill has ALREADY scanned the index (and any configured
archive) for related spikes — grep frontmatter `question:`, `tags:`, and index lines.

Present the hits and ask: **proceed anyway / reshape the question / already answered?**

- If already answered: point to the prior verdict and stop — that is a success,
  not a failure of the process.
- If related but different: note the prior spike in the Charter's prior-check field.

## `--quick` behavior

Skip the four questions. Still perform silently:
1. Falsifiability check — if the question has no observable NO, stop and ask Q1 only.
2. Prior check — if a direct hit exists, surface it before proceeding.

Everything else (budget default: 5 iterations, standard abort criterion) is assumed
and written into the charter without asking.
