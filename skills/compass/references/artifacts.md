# Artifacts — the four roles and the files behind them

compass fills four roles. Two of them may already exist in the repository under
someone else's ownership, two are always its own. This file holds the detail:
how to judge a candidate, what compass writes when it owns a role, and how a
hard backlog item becomes a GitHub issue.

- [Which file fills a role](#which-file-fills-a-role)
- [`.compass/config.md`](#compassconfigmd)
- [Skeletons compass writes when it owns a role](#skeletons-compass-writes-when-it-owns-a-role)
- [Projecting a hard item to a GitHub issue](#projecting-a-hard-item-to-a-github-issue)

## Which file fills a role

**The candidate list lives in SKILL.md**, in the role table under "Before any
mode". That is the single source of truth for *where to look*; this file covers
*how to decide* once a candidate is found. Do not maintain a second list here —
two lists drift, and a resolution written into `config.md` is permanent per repo.

BACKLOG and HANDOFF are never adopted. Other handoff artifacts exist
(`HANDOVER.md` from session-handoff, `.continue-here.md` and `HANDOFF.json` from
planning frameworks) and they are worth **reading** for context, but they have
different lifecycles — phase-scoped or ledger-shaped, where compass's is
session-shaped. Writing into them would mean two skills fighting over one file.

### Judging a candidate

Open it. A file fills a role only if its content does:

- **A roadmap** names where the project is going — goals, milestones, phases,
  an order. A changelog, a release-notes page or a feature marketing list is
  not a roadmap.
- **A decisions file** records choices with reasons — ideally dated,
  append-only. A consolidated architecture description, a research summary or a
  design overview is *not* a decision log, however it is named. This case is
  real and is exactly why filenames do not decide.

On doubt, ask once with AskUserQuestion — show the file, your reading of it, and
three options: adopt as the role · read as background only · create our own.
Record the answer in `.compass/config.md` and never ask again.

## `.compass/config.md`

Written at bootstrap, human-editable, the record of what was resolved to what.
It is read before every mode, so changing a line here changes behaviour without
touching the skill.

```markdown
# compass config

- roadmap: .planning/ROADMAP.md        # adopted, read-only
- decisions: .compass/DECISIONS.md     # ours (root DECISIONS.md is an architecture write-up, background only)
- backlog: .compass/BACKLOG.md         # ours
- handoff: .compass/HANDOFF.md         # ours
- background: CLAUDE.md, DECISIONS.md, .planning/.continue-here.md

resolved: 2026-08-13
```

`background:` lists files worth reading for context that fill no role. Anything
listed anywhere here is read; only files marked *ours* are ever written.

`CLAUDE.md` / `AGENTS.md` are the one asymmetric entry: they are read whether
listed or not, so their line is documentation rather than configuration — it
exists so a reader of this file sees everything compass consults without having
to know what the platform loads by itself. Removing the line does not stop them
being read. See `references/bootstrap.md` Step 4.

## Skeletons compass writes when it owns a role

### ROADMAP.md

```markdown
# Roadmap

**Goal:** <one sentence — what this project is for>

## Milestones

- <one sentence each, in order>

## Not doing

- <explicitly out of scope>

<!-- The goal anchor. Without at least one milestone, `check` cannot judge
     execution drift and will say so rather than guess. -->
```

`## Not doing` earns its place immediately: it is how `check` tells
gold-plating apart from work that was already agreed to be out of scope, and it
gives an explicitly rejected option somewhere to live.

### DECISIONS.md

```markdown
# Decisions

<!-- Append-only. Never rewrite an entry; a reversal is a new entry that says
     what it supersedes. -->

## 2026-08-13 — <the decision, in one line>

**Why:** <the reason, not a restatement of the decision>
**From:** <where it was decided — session, call, issue>
```

### BACKLOG.md

Written empty at bootstrap — three headings and nothing else. The filled example
in SKILL.md illustrates the line grammar; it is not what gets written here.

```markdown
# Backlog

<!-- One bullet per item, a permanent 4-char id, an origin pointer with a date,
     a status. Never edit an id. Never delete an item — move it to Closed.
     Section headings are fixed and machine-read. -->

## Active (hard)

## Loose ends (soft)

## Closed
```

### HANDOFF.md

Overwritten by `wrap`, 60 lines soft cap, 120 hard. Frontmatter carries the
date so `check` can compare it against the newest commit and notice a session
that ended without a wrap.

```markdown
---
handoff: 2026-08-13
---

# Handoff

**Where we are:** <2-3 sentences>
**Last worked on:** <what moved, with commit hashes>
**Open:** <what the next session should pick up first>
**Blocked:** <or "nothing">
```

At bootstrap it is written with `No session wrapped yet.` as the body, so the
"ended without wrap" signal starts from a defined value instead of a missing
file.

## Projecting a hard item to a GitHub issue

Only for hard items, only with an explicit yes, only where a remote exists.

1. `git remote` decides whether a remote exists at all — no output means the
   item simply stays a line. `gh issue list` failing for auth reasons is a
   normal outcome too, not an error to escalate.
2. Title = the item text. Body = the `**why:**` and the `**from:**` pointer, so
   the issue carries its origin the same way the line does.
3. On success, append `· issue: #N` to the line. The id stays what it was — the
   issue number is an attribute, never the identity.
4. If a label does not exist, retry without labels and say so. compass does not
   create labels; that is repository configuration.

Without a remote or without `gh`, the item simply stays a line, and compass says
that once rather than failing.

## Sizes

Nothing here grows without bound. HANDOFF is overwritten. BACKLOG moves closed
items to `## Closed`. DECISIONS is append-only by design and is the one file
allowed to grow, because its value is precisely the history.
