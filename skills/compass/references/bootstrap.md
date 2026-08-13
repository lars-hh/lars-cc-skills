# Bootstrap — the first run in a repository

Read once per repository, ever. The governing constraint: **at most two
questions.** A third question is a planning apparatus arriving through the back
door, and avoiding that apparatus is the reason this skill exists.

## Step 0 — look around before deciding anything

```
git rev-parse --abbrev-ref HEAD
git log --oneline -20
```

and check what steering material already exists: `.planning/`, `ROADMAP.md`,
`DECISIONS.md`, `HANDOVER.md`, `docs/`. Three shapes come up:

| What you find | What compass does |
|---|---|
| Nothing | Creates all four. compass is the direction here. |
| A handoff file from another skill (`HANDOVER.md`) | Creates all four, reads that file as background, never writes it. |
| A planning framework (`.planning/ROADMAP.md`, phase folders) | **Adopts** the roadmap, creates BACKLOG and HANDOFF, treats decisions per the doubt rule. |

**A planning framework is not a reason to refuse.** It owns the plan; compass
contributes what it does not have — catching ideas the moment they surface, and
reporting drift against that framework's own roadmap. Two roadmaps would be the
duplication compass exists to avoid; adopting one is the point.

Never add `.compass/` to `.gitignore`. Committed is the whole mechanism — it is
how the direction reaches other machines and cloud sessions.

## Step 1 — infer before asking

Free inputs, no questions spent: the README's first heading and first paragraph ·
`package.json` / `pyproject.toml` / `Package.swift` name and description ·
the last twenty commit subjects · an existing roadmap or TODO if one exists.

From those, draft a one-sentence goal and, where the material supports it, up to
four milestones. Commit subjects are usually enough to see the shape of the work
even when no document describes it.

## Step 2 — one question

AskUserQuestion, with the drafted goal sentence as the recommended answer:

- accept it as drafted
- correct it (the user supplies the sentence)
- fresh start, the goal is this instead

## Step 3 — a second question only if nothing could be inferred

Only this one, only if step 1 came up empty: *"One sentence: what is this
project for?"*

Never ask for milestones, scope, success criteria, stakeholders or a name for
the first phase. Milestones arrive later through `capture --hard`, one at a time,
when they are actually known.

## Step 4 — write all four at once

Including the near-empty ones. `capture` and `check` both assume the files
exist; creating them lazily buys a branch in every mode to save three lines of
markdown. Skeletons are in `references/artifacts.md`.

Where a role was adopted, no file is created for it — the adoption goes into
`.compass/config.md` instead.

## Step 5 — report, do not commit

Name what was created, what was adopted, and what is being read as background.
Then one line: `.compass/` is meant to be committed, and compass does not commit
— that stays the user's move.

## What a fresh roadmap looks like from one sentence

```markdown
# Roadmap

**Goal:** Turn the raw ESPN fantasy export into a weekly matchup report I
actually read.

## Milestones

- (none recorded yet — add one with `/compass capture --hard <milestone>`)

## Not doing

- (nothing recorded yet)
```

An empty milestone list is honest and has a defined consequence: `check` reports
that execution drift is not judgeable yet, rather than inventing an anchor and
accusing commits against it. That is better than a fabricated plan, and it makes
the first `capture --hard` obviously worth doing.
