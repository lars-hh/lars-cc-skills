---
name: compass
description: "Keeps a coding project pointed at its goal: records direction in `.compass/`, reports when work drifts. Modes `start` (orientation briefing), `check` (read-only drift report), `capture` (record an idea, gap, bug or open question the moment it surfaces), `wrap` (rewrite the handoff). Reach for `capture` MID-TASK and unasked the moment something surfaces that is not yet recorded — that is the point of this skill, not an interruption. Use when the user says 'halt das fest', 'merk dir das', 'schreib das auf', 'das dürfen wir nicht vergessen', 'capture this', 'note that down', 'wo stehen wir', 'where are we', 'verzetteln wir uns', 'are we drifting', 'was war nochmal das Ziel', or when opening or closing work on a repository. NOT an executor — it records and waits at `status: proposed`, never implements, plans or researches. NOT a spike runner. NOT a repair tool for another skill's ledger: session-handoff owns root HANDOVER.md and ROADMAP.md, compass writes only inside `.compass/`."
argument-hint: "start | check [--deep] | capture [<text>] [--hard|--soft] | wrap"
allowed-tools: Read, Write, Edit, Glob, Grep, AskUserQuestion, Bash(git log:*), Bash(git status:*), Bash(git diff:*), Bash(git show:*), Bash(git remote:*), Bash(git rev-parse:*), Bash(gh issue list:*), Bash(gh issue create:*)
---

# Compass

Holds where a project is meant to go, and says so when the work drifts away
from it. It exists because execution frameworks are good at building and bad at
remembering: each session starts clean, the goal does not survive the context
window, and good ideas surface mid-task and evaporate.

**compass steers, the execution framework builds.** It never implements
anything itself — it records, reports, and waits.

## Learnings

> Before starting: read the "compass" section of this marketplace's
> `docs/skill-learnings.md` if present (known pitfalls from real runs).

## Dispatch

| Invocation | Behavior |
|---|---|
| `/compass start` | Resolve the four roles, then give an orientation briefing. First run in a repo bootstraps what is missing (`references/bootstrap.md`) |
| `/compass check [--deep]` | Read-only drift report (`references/drift.md`). Writes nothing, ever — not even when asked |
| `/compass capture <text> [--hard\|--soft]` | Dup-check, then record one item. Confirm the one-line wording before writing |
| `/compass capture` (no text) | Capture what was just discussed: restate it in one line, confirm, write. The "halt das fest" case |
| `/compass wrap` | Rewrite `.compass/HANDOFF.md`. Propose — never apply unasked — updates to roadmap and decisions. Does **not** commit |
| `/compass` (empty) | No `.compass/` yet → offer to bootstrap. Otherwise run `check`, then one line naming `start` and `wrap` |

An argument that is not a known mode routes to `check`, framed by that text —
never to `capture`. A misrouted `check` costs nothing; a misrouted `capture`
writes a file.

**Cold start.** Only `start` bootstraps. If `.compass/` does not exist yet,
`capture` creates just `BACKLOG.md` and records the item, `wrap` creates just
`HANDOFF.md`, and `check` reports what it can from git alone. Each mentions once
that `start` would set up the rest. An unprompted `capture` in a fresh repo must
not turn into a two-question interview — that is how capture gets skipped.

## Before any mode: resolve the four roles

compass has four **roles**, not four fixed files. Resolve them once per repo and
record the result in `.compass/config.md`, so the answer is stable and
inspectable rather than re-derived every session.

| Role | Resolution order — first match wins | Ownership |
|---|---|---|
| ROADMAP | `.compass/ROADMAP.md` · `.planning/ROADMAP.md` · `ROADMAP.md` · `docs/ROADMAP.md` | adopted ⇒ read-only · created ⇒ compass writes |
| DECISIONS | `.compass/DECISIONS.md` · `DECISIONS.md` · `docs/decisions/` · `docs/adr/` | same |
| BACKLOG | always `.compass/BACKLOG.md` | compass, always |
| HANDOFF | always `.compass/HANDOFF.md` | compass, always |

This list is the single source of truth for resolution; `references/artifacts.md`
adds how to judge a candidate, not more places to look.

**The rule that carries everything: what compass owns, it writes. What it
adopted, it only reads** — and when something belongs there, it says so in the
report instead of writing it. Two skills writing one file with two formats is
how both formats rot.

**Content decides, not the filename.** A file fills a role only if what is
inside it actually fits. A `DECISIONS.md` can turn out to be a consolidated
architecture write-up with no decisions in it; a root `ROADMAP.md` can be a
product marketing page. Per role:

1. **Clear match** → adopt it, name it in the briefing, move on.
2. **No candidate** → create it in `.compass/`. This is the normal case for
   BACKLOG, which planning frameworks generally do not have.
3. **Doubt** → do not guess. Show the file and your reading of it, ask once
   (adopt / read as background only / create our own), and write the answer into
   `.compass/config.md`. Never ask a second time.

A repo that already has a planning framework is **not** a reason to stop.
Adopt its roadmap and contribute the half it lacks: catching ideas at the moment
they surface, and reporting drift against the roadmap it already owns.

Details, file skeletons and the `config.md` format: `references/artifacts.md`.

## The BACKLOG.md contract

Inline rather than in a reference, because `capture` fires mid-task and must
stay cheap. If recording one line costs an extra file read, it gets skipped —
which is the exact failure this skill exists to prevent.

```markdown
## Active (hard)

- [ ] `c7k2` Sync script needs a `--check` mode · **why:** drift between the kit
      and the synced copies is invisible today
      · **from:** 2026-08-13 session, after the first sync run · status: proposed

## Loose ends (soft)

- `f0zq` Maybe rethink caching before the next import?
  · **from:** 2026-08-13 session, during the repomix test · status: proposed

## Closed

- [x] `b3wn` Pin the marketplace schema in the install test
      · **from:** 2026-08-11 CONTRIBUTING review · status: done
- [ ] `q4ax` SessionEnd bookmark hook · **why:** 1.5 s budget, dies on Ctrl+C
      · **from:** 2026-08-13 research run · status: dismissed
```

| Field | Rule |
|---|---|
| id | 4 chars `[0-9a-z]`, in backticks, minted at capture, **never changed** — not on rewording, not when an issue appears, not on close |
| **hard** | bug · gap · concrete idea · a decision still to be made. Gets `- [ ]`, a `**why:**`, and an issue where a remote exists |
| **soft** | vague remark · rejected option · open question. Plain `-`, no checkbox, `**why:**` optional |
| `**from:**` | required, starts `YYYY-MM-DD`. This is the origin pointer — the noise defence |
| `status:` | `proposed → agreed → in progress → done`, or `dismissed` at any point |
| checkbox | `[x]` only when `status: done`. A dismissed item keeps `[ ]` — it was closed, not finished |
| `issue: #N` | an attribute of a projected item, never its identity |

**A decision already made is not a backlog item** — it belongs in DECISIONS (see
`capture` below). Only a decision still *waiting* to be made is a hard item.

**`status: proposed` is where compass stops.** It records and waits for a
decision; it never starts building because something is written down.

**The origin pointer is what makes over-capturing safe.** Before re-raising an
item, check whether its origin still holds. Anything stale devalues itself, so
erring toward catching costs nothing.

**Nothing is ever deleted.** `done` and `dismissed` move to `## Closed`, which
`check` and `start` never read. That is also the mute list: an item pushed away
stays away.

Structural tokens (`## Active (hard)`, `**why:**`, `status:`) are English and
machine-read. Item prose follows whatever language the conversation is in.

## start

Resolve the roles: if `.compass/config.md` exists, read it and trust it — that is
what it is for. Only run the full resolution above when it is missing. If
`.compass/` itself is missing, bootstrap first — `references/bootstrap.md`, at
most two questions.

Then a briefing of at most 12 lines, shaped to be handed straight to an
execution framework: the goal in one sentence · current position on the roadmap ·
what the last session left open (from HANDOFF) · anything at `status: agreed`
waiting to be built. Name which files were adopted and which compass owns, once.

## check

Read-only. Read `references/drift.md` for the playbook and the depth dial.

Two kinds of drift, told apart by where the evidence lives:

- **Execution drift — evidence is in git.** Commits since the last handoff that
  match no roadmap milestone; work in a later milestone while an earlier one is
  open; repeated commits in an area already marked done.
- **Capture drift — evidence is in the conversation and missing from the
  files.** Something named this session that appears nowhere; a decision made
  with no entry; a HANDOFF older than the newest commit, meaning the last
  session ended without `wrap`.

**Evidence or silence.** Every claim carries a pointer — a commit hash, a path,
a line. A commit that merely sounds off-plan is not evidence.

**When nothing is off, say so in four lines and stop.** The quiet output ends
with the literal token `Drift: none.` so that silence is checkable rather than
hoped for. At most three drift observations and three next steps; overflow
becomes one line offering `--deep`.

If the resolved roadmap has no milestones yet, execution drift is not
judgeable — say that instead of inventing an anchor.

## capture

Runs **at the moment of insight**, never as a sweep at the end of a session.
Two triggers, and only two:

1. **The user says so** — "halt das fest", "merk dir das", "schreib das auf",
   "capture this", "das dürfen wir nicht vergessen".
2. **You notice** — mid-work, a decision was just made, a gap just found, an
   idea just floated, and it is not recorded anywhere. Offer it. Once per topic
   per session; if declined, let it go.

Then, in order: read BACKLOG and (if a remote exists) the open issues, and say
plainly if something already covers this — offering to update the existing item
beats adding a near-duplicate. Classify hard or soft, `--hard`/`--soft`
overrides you. Mint an id: four characters from `[0-9a-z]`, and since BACKLOG is
already open from the duplicate check, pick one that no existing item uses.
**Show the one line and get a yes before writing it.** For a hard item with a
remote, offer an issue; on a yes, create it and record `issue: #N`.

A decision goes to DECISIONS instead — appended, never rewritten. If DECISIONS
was adopted from elsewhere, compass does not write there: it hands over the
finished entry and says where it belongs.

## wrap

Rewrite `.compass/HANDOFF.md` — that is the one thing wrap does unasked, because
it is its job. Everything else it only proposes: roadmap corrections, decisions
worth recording, items whose status has moved. Moving a `done` or `dismissed`
item down into `## Closed` is part of that proposal, and it is where the mute
list gets maintained — so it needs a yes like any other edit.

**wrap does not commit**, and it does not touch files it does not own.

## Anti-nag

A steering skill that nags gets tuned out, and then it is worse than nothing.

- Hard caps: `check` at most 3 observations and 3 next steps; `start` at most
  12 lines; HANDOFF 60 lines soft, 120 hard.
- The quiet path is a specified output, not a hope: `Drift: none.`
- Evidence or silence.
- `## Closed` is the mute list — never re-read, so nothing pushed away returns.
- **Governor:** if `## Active (hard)` already holds three items at
  `status: proposed`, stop proposing new ones and say so instead: three
  undecided items are open, decide one before adding a fourth. This governs
  **compass's own proposals only** — a capture the user asked for is never
  blocked, because nothing may be lost.

## Guardrails

- **Write only inside `.compass/`.** Adopted files are read. `HANDOVER.md`,
  `ROADMAP.md` at root and anything under `.planning/` belong to other skills.
- **`CLAUDE.md` and `AGENTS.md` are permanently adopted.** Read them, name them
  in a report, hand over a finished paragraph — never write them. They fill no
  role, so they belong under `background:` in `config.md`, not in the role
  table. They already have owners, and compass stops at `status: proposed`:
  editing them would be applying a decision rather than recording one. They also
  outrank this skill, which is the deeper reason — a skill that edits its own
  instructions changes every later session, including other skills' sessions.
- **Never commit.** Not after `wrap`, not after `capture`. The git allowlist is
  reads only, so this is enforced and not merely promised. Committing is the
  user's move.
- **Never implement.** `status: proposed` is the end of compass's job. Wanting
  to build the item is a signal to hand off, not to start.
- **`gh issue create` needs an explicit yes** every time — it is visible to
  other people. Without a remote or without `gh`, the item stays a line and
  compass says so rather than failing.
- **Capture is never a grep for a trigger phrase.** A prompt-matching capture
  hook in this ecosystem fired on a system notification and wrote 20 KB of
  garbage into an inbox, with one genuine hit in six months. The trigger is a
  model recognising an insight, and it always confirms the wording first.
- Interact in the user's language; write records in the project's working
  language; the structural tokens above stay English.

**What this stage cannot do.** compass has no hooks. It catches an insight only
when you say so, or when it is in context and notices. Anything raised while
compass is not loaded — inside a subagent, after a `/clear`, in a session where
it never came up — is gone, and no `check` will find it: the capture-drift pass
reads the current conversation only. Best-effort by construction. Do not let
this skill's existence make you feel covered.

## What this skill is NOT

- Not an executor. It never writes project code, and never starts work because
  an item exists.
- Not a planner or a research tool — no plan files, no research runs.
- Not a repair tool for another framework's ledger. It reads them; it fixes
  nothing in them.
- Not a hook. It is silent unless invoked, and cannot see what it was not shown.
