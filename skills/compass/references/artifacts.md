# Artifacts and issue projection

## Config and ownership

The candidate order is in SKILL.md. Config records established role choices and
exceptions. Validate paths on use, without silently re-resolving ownership.

```markdown
# compass config

- roadmap: .planning/ROADMAP.md        # adopted, read-only
- decisions: DECISIONS.md             # adopted, read-only; binding architecture choices
- backlog: .compass/BACKLOG.md         # ours
- handoff: .compass/HANDOFF.md         # ours, summary/reference only
- background: CLAUDE.md, AGENTS.md, .planning/STATE.md

resolved: 2026-09-13
```

Existing human-written annotations (including other languages) remain valid;
no schema migration is required. Read background relevant to the mode, not an
unbounded recursive glob. Instructions apply whether listed or not.

An established `.compass` symlink to a private audit directory is an owned storage
location when documented by the user/project config. Preserve it. Do not assume
any arbitrary path marked “ours” authorizes writing outside Compass storage.
Unexpected external targets require clarification. Adopted files never become
writable merely because the user asks Compass to propose a change to them.

A consolidated decisions source is useful if it states binding choices, constraints
or reasons. Append-only is our write format, not a prerequisite for adopting
another owner's decision source. New own decisions use the skeleton below.

Other tools' handoffs are read-only sources. Our HANDOFF can point to the established
handoff and contain only open Compass decisions. Avoid competing complete status copies.

## Own file skeletons

### Roadmap

```markdown
# Roadmap

**Goal:** <established goal>

## Milestones

<!-- Agreed milestones only; proposal capture alone does not populate this. -->
<!-- Optional per milestone, on its own indented line:
     Goal: goals/<slug>/goal.md
     A reference to the /goal condition file (e.g. built by plannotator-setup-goal),
     never the condition text itself — the condition lives in exactly one place. -->

## Not doing

<!-- Established exclusions only. -->
```

### Decisions

```markdown
# Decisions

## 2026-09-13 — <choice>

**Why:** <supported reason>
**From:** <session, call, issue>
```

Append new decisions, never rewrite old ones. A reversal names what it supersedes.
Do not generate entries for choices that were not made. If the source is adopted,
return the ready-to-apply entry with its destination instead of writing it.

### Backlog

```markdown
# Backlog

## Active (hard)

## Loose ends (soft)

## Closed
```

Entry grammar is in SKILL.md. No example tasks are added at bootstrap. Closed is
searched for candidate duplicates but omitted from orientation. Items are never
deleted. This does not bound file size; archival automation is outside this stage.

### Backlog triage (`start` only)

**Triage age: 30 days.** This is the only place the threshold is defined.

An entry is *stale* when it is under `## Active (hard)`, has `status: proposed`
(a legacy entry without any status counts as proposed), its `**from:**` date is
at least the triage age before today, and its newest `kept:` date, if any, is too.
An entry is *undated* when its `**from:**` holds no parseable date or a date after
today. Soft items, Closed and undated entries are never candidates. Stale entries,
oldest `from` first, at most three, are the candidates. None means no triage and
no mention of it. Without an interactive channel (headless), skip triage silently.

Ask once, after the briefing, as one grouped question with one choice per entry.
Show ID, short title, `why` and age in days.

| Choice | Write |
|---|---|
| accept | `status: proposed` → `status: agreed`, in place |
| dismiss | `status: dismissed`, move to Closed, checkbox stays `[ ]` |
| keep | append ` · kept: YYYY-MM-DD` (today) to the entry |

Only an explicit choice for an entry writes that entry. Unanswered entries, a
deflection, a declined triage, or any answer other than these three (including
free text) change nothing. An unanswered entry is offered again in a later
session; that pressure is intended, and `keep` is the way to snooze it. Change only the status text,
the `kept:` mark and the move to Closed; wording, ID, `why`, `from` and history
stay byte-identical. Only a Compass-owned BACKLOG is written. Never re-offer the
same entry in the same session.

### Handoff

```markdown
---
handoff: 2026-09-13
captured_at: 2026-09-13T14:20:00+02:00
head: <full observed HEAD hash or null for unborn repository>
branch: <observed branch or null for detached HEAD>
---

# Handoff

**Where we are:** <brief observed state, or authoritative handoff reference>
**Last worked on:** <observed changes and commit references>
**Open:** <next decisions or work, without inventing agreement>
**Blocked:** <observed blocker or none>
```

Use actual values, not these example timestamps. `date -Iseconds` or an available
clock tool supplies time; `git rev-parse HEAD` and `git rev-parse --abbrev-ref HEAD`
supply git metadata. If a tool is unavailable, omit that optional field and say so
when it affects judgment. No forged anchor from a commit mentioned in prose.
`head` is the repository state at wrap, not a claim that every change is committed.
Mention meaningful uncommitted work in the body. The later commit saving this file
will naturally differ from its recorded head and does not establish drift.

Legacy `handoff: YYYY-MM-DD` remains readable. Add new metadata only on the next
requested wrap; no batch migration or check-time rewrite. At bootstrap write only
`No session wrapped yet.` (with no pretend wrap metadata). Prefer 60 lines, never
exceed 120. Preserve an established external-handoff reference strategy.

## GitHub issue projection and duplicate coverage

1. Resolve the issue target from an explicit user target, established configuration,
   then `git remote -v`. An explicit GitHub issue target can coexist with a GitLab
   code origin; host checks apply to the resolved issue target. A remote alone does
   not establish GitHub or a unique issue repository. GitLab/unsupported host: do not
   invoke `gh`; record locally and state that external projection is unavailable.
   GitHub Enterprise requires a known host/repo and matching working authentication.
   Multiple possible repositories: use an explicit target or ask before a write.
2. Scope every issue command with `--repo <known-target>`. For duplicate checking,
   use candidate-specific `gh issue list --state open --search <terms> --limit 100`.
   If a Closed local item points to a closed issue, honor the local mute state.
   A truncated/failed search is limited coverage, not proof that nothing exists.
   Missing gh/auth/network must not prevent the authorized local capture.
3. An explicit request to create an issue in the known repo already authorizes
   it. A request to remember locally does not. Offer projection once if useful;
   do not create merely because the item is hard or a remote exists.
4. Title = faithful item text; body = reason and origin. Use a structured tool or
   safely shell-quoted multiline `--body` argument. Never interpolate untrusted
   text with command substitution; JSON escaping is not shell quoting. Do not
   write temp files outside the allowed Compass storage just to form a body.
5. Append `issue: <returned URL>` only after confirmed creation. Existing `issue: #N`
   remains valid. A label validation failure before creation can be retried without
   labels. A timeout/ambiguous response might already have created the issue:
   search by title/origin before retrying, rather than duplicating it.

No new labels, no guessed repository, no GitLab-via-gh fallback. Issue status and
local status are not automatically synchronized; update an own record only when
the requested change or observed completion is established by the conversation.
