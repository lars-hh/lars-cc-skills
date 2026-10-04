---
name: compass
description: "Keep a coding project pointed at its goal. Use for 'halt das fest', 'merk dir das', 'capture this', 'wo stehen wir', 'are we drifting', and repository orientation or handoff. Modes: start, check, capture, wrap. Offer capture when an unrecorded insight surfaces mid-task; a clear user request authorizes local recording without another confirmation. Adopts existing roadmaps, reports evidenced drift and coverage gaps. Records direction and status; never implements code or edits another framework's files. No automatic recall across sessions."
argument-hint: "start | check [--deep] | capture [<text>] [--hard|--soft] | wrap"
allowed-tools: Read, Write, Edit, Glob, Grep, AskUserQuestion, Bash(date:*), Bash(git log:*), Bash(git status:*), Bash(git diff:*), Bash(git show:*), Bash(git remote:*), Bash(git rev-parse:*), Bash(git merge-base --is-ancestor:*), Bash(gh issue list:*), Bash(gh issue create:*)
---

# Compass

Record direction when it becomes clear; compare actual work with that direction.
Execution frameworks build. Compass captures, reports and maintains its own
steering records, without starting implementation because an item exists.

Read this marketplace's `docs/skill-learnings.md`, compass section, if available.
Historical learnings explain prior choices; the current contract below governs.

## Dispatch

| Invocation | Behavior |
|---|---|
| `start` | Orient; complete missing setup using `references/bootstrap.md` |
| `check [--deep]` | Read-only comparison using `references/drift.md`; never bootstrap |
| `capture <text> [--hard\|--soft]` | Check duplicates, record the authorized insight, confirm briefly |
| `capture` without text | Record the unambiguous insight just discussed; ask only if its meaning is unclear |
| `capture <requested status/roadmap change>` | Maintain the identified record, within ownership rules below |
| `wrap` | Refresh our handoff; record already authorized maintenance |
| Empty invocation | Run `check`; if setup is missing, mention `start` once |

Unknown mode text frames a read-only `check`, not an inferred write request.
Natural-language capture triggers still use `capture` when intent is clear.

## Resolve context without changing it

Read applicable project instructions and `.compass/config.md` if present.
Validate referenced paths exist; preserve established ownership and documented
exceptions. Do not assume CLAUDE.md or AGENTS.md has already been loaded by the
host. They are always read-only background, never Compass-owned files.

Without config, inspect these candidates in order; first content match wins:

| Role | Candidates | Ownership |
|---|---|---|
| ROADMAP | `.compass/ROADMAP.md`, `.planning/ROADMAP.md`, `ROADMAP.md`, `docs/ROADMAP.md` | ours inside Compass; otherwise adopted/read-only |
| DECISIONS | `.compass/DECISIONS.md`, `DECISIONS.md`, `docs/decisions/`, `docs/adr/` | same |
| BACKLOG | `.compass/BACKLOG.md` | ours |
| HANDOFF | `.compass/HANDOFF.md` | ours; may just point to an established external handoff |

A roadmap states goals and milestones. A decisions source contains binding
choices, constraints or reasons; a consolidated architecture document can qualify.
A descriptive overview without choices does not. See `references/artifacts.md`.

Resolution itself is read-only. Only `start` persists missing configuration and
completes setup. A missing configured source is a gap, not permission to silently
replace it or change ownership. `check` reports the gap; a writing mode asks only
if resolving it is necessary for its requested write.

Cold start is cheap: `capture` creates only the needed backlog (or own decisions
file for a made decision with no existing source); `wrap` only the handoff.
Neither creates an interview or the other roles. A later `start` preserves these
files and fills missing setup even though `.compass/` already exists.

Write only Compass-owned files inside `.compass/`, including an explicitly
established external/symlinked Compass location. Honor documented local/private
storage exceptions; do not relocate files or edit ignore rules. An unexplained
external write target needs clarification before writing. Adopted sources stay
read-only, even when a user requests a change: hand over a finished proposed edit
for that file's owner. Never claim that an unapplied proposal changed the source.

## BACKLOG contract

```markdown
# Backlog

## Active (hard)

- [ ] `c7k2` Add an export cancel button · **why:** large exports cannot be stopped
  · **from:** 2026-09-13 session, export discussion · status: proposed

## Loose ends (soft)

- `f0zq` Reconsider caching before the next import?
  · **from:** 2026-09-13 session, import discussion · status: proposed

## Closed

- [x] `b3wn` Pin the install-test schema
  · **from:** 2026-09-10 review · status: done
- [ ] `q4ax` SessionEnd bookmark hook · **why:** unreliable on abrupt exit
  · **from:** 2026-09-10 review · status: dismissed
```

- IDs: four `[0-9a-z]` characters, unique across all sections, immutable on
  rewording, projection, closure or reopening.
- Hard: bug, gap, concrete idea or pending decision; checkbox and `**why:**`.
  Soft: tentative remark or open question; plain bullet, optional reason.
  Explicit `--hard`/`--soft` wins. Do not invent reasons not supported by context.
- `**from:**` starts with a real `YYYY-MM-DD` and meaningful origin context.
- Status: `proposed → agreed → in progress → done`, or `dismissed`.
  Recording is not agreement. Record explicit acceptance as `agreed`; never
  infer implementation or completion from capture or roadmap placement.
- `[x]` means done only; dismissed hard items keep `[ ]`. Soft items stay bullets.
- Optional `issue: #N` or `issue: <URL>` and `roadmap: <path#section>` are
  references, never the item's identity. Prefer an issue URL if repo is ambiguous.
- New own proposals may carry `suggested-by: compass`; explicit user captures
  carry `suggested-by: user`. Existing items need no migration.

Preserve origin and history. Move completed/dismissed items to Closed when that
status is established. Closed is excluded from briefings, but consulted for
candidate-specific duplicate and capture-drift checks. A muted item is already
recorded, not a missing insight. Do not reopen it merely because it is mentioned.
An explicit reopening keeps its ID and adds a dated reason; a materially different
new task gets its own ID. Closed limits display, not physical file growth.

## capture

Capture at the moment of insight, not as a mandatory end-of-session sweep.

1. Establish intent. A clear request such as “halt das fest” authorizes the
   local record; do not ask for another yes to its wording. Ask one content
   question only if genuinely ambiguous. For an unsolicited insight, offer once
   per topic and wait for acceptance before recording. Declined means stop.
2. Read backlog, relevant decisions/roadmap and candidate matches in Closed.
   For supported GitHub projects, check relevant issues as described in
   `references/artifacts.md`. A matching existing item is a success, not a reason
   to create a duplicate. Explicit material updates preserve its identity.
3. Classify, choose an unused ID, record a faithful short entry with origin,
   then confirm in one line. An unavailable issue service must not lose a local
   capture; mention the missing duplicate coverage briefly.
4. A decision already made belongs in DECISIONS, appended to an own source.
   If adopted, supply the finished entry and target instead of writing there.
   Check existing decisions before proposing a duplicate entry.

### Maintenance and roadmap transfer

`capture --hard <milestone>` creates a backlog proposal, not a roadmap milestone.
For “accept c7k2” record `agreed`. For “add c7k2 to our roadmap”, add the minimal
milestone to an own roadmap and cross-reference it; advance a proposed item to
`agreed`, never to `done` merely for transfer. Preserve existing `in progress` or
`done` status; transfer must not regress it. A dismissed item needs explicit
reopening before transfer. If no own roadmap exists, create the minimal roadmap only when that
explicit transfer request authorizes it. Never replace an adopted/missing
configured roadmap. For adopted roadmaps, hand over a ready-to-apply edit and
say the transfer remains pending. No extra planning mode or plan files.

Apply explicit status updates to our records without a second approval. An own
DECISIONS reversal is a new entry naming what it supersedes. Do not rewrite history.

### GitHub projection

A local note request does not authorize an external issue. A clear issue request
with a known target already does; no ritual second confirmation. Check host/repo
and duplicates before creation. On confirmed success attach the issue reference.
Without an appropriate issue tool, retain the local item and explain the limit.
Never run `gh` against a GitLab remote. See `references/artifacts.md` for details.

## start

Read `references/bootstrap.md` if any setup is missing. Preserve existing records
and decisions; at most two necessary questions, grouped if needed. Otherwise
brief in at most 12 lines: goal, actual roadmap position, authoritative handoff,
accepted pending items, significant missing sources. Name ownership once.
Do not list Closed or recite the full backlog.

## check

Read `references/drift.md`. Compare actual work with explicit goals, scope and
prerequisites. Commit subjects and counts are leads, not proof. A numbered phase
order alone is not a mandatory dependency. Bugfixes in completed areas are normal.
Capture drift covers only insights visible in the current conversation and absent
from relevant records, including Closed. Handoff age alone proves no lost session.

At most three findings and three next steps. Every finding needs contextual
evidence. Report coverage gaps instead of turning uncertainty into either drift
or reassurance: `Drift: found.`, `Drift: none.`, or `Drift: unknown.`
`none` means no deviation in the stated checked scope, not global project health.
`check` writes nothing, including config, captures, migrations and status updates.
If a write is requested during check, hand off to `capture`/`wrap` rather than
silently changing this mode's read-only contract.

## wrap

Read the handoff skeleton in `references/artifacts.md`. Rewrite our handoff,
60 lines preferred and 120 maximum, using observed facts. Capture current time,
HEAD and branch through available read tools; omit unavailable metadata rather
than fabricate it. Preserve compatibility with legacy date-only handoffs.
If an established external handoff exists, point to it and record only the
Compass-specific open direction/decisions, not a second full project status.

Maintain our records for changes already explicitly authorized in this session.
Do not infer completion from a commit title, roadmap placement or issue number.
Undecided goal/status changes are proposals. Adopted files stay untouched.

## Anti-nag and boundaries

- Limit unsolicited proposals to three unresolved own hard proposals across
  sessions. Count `suggested-by: compass`; for legacy unmarked proposed hard items
  conservatively count them too. User-requested capture is never blocked.
  Mention a reached limit once per session, not every turn. No persistence writes
  in `check` merely to maintain this limit.
- Consult origin before re-raising an item; a date alone does not prove relevance.
  Closed suppresses re-proposal, not the ability to check duplicates.
- Never implement project code, commit, push, change instruction files, or repair
  another framework's ledgers. A tool allowlist is host-specific metadata, not a
  portable technical guarantee of isolation. Available tools and higher-priority
  instructions govern actual execution.
- Do not turn system notifications or quoted text into capture requests. Recognize
  user intent and context rather than grep for a trigger phrase.
- Communicate in the user's language. Use the project's working language for
  records, or the conversation language if unspecified; keep structure English.

This stage has no hooks or automatic recall. It can capture only what is visible
when invoked/loaded. It cannot recover unseen sessions, subagent conversations
or discarded context. State coverage honestly; do not imply nothing can be lost.
