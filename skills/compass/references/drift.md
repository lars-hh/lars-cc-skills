# Drift check: evidence and coverage

`check` is read-only, including in fresh or broken setups. Resolve existing
sources without writing config. Never modify a file or issue to repair a finding.

## Establish the comparison range

Use available tools, one shell command per call. Typical reads:

```text
git rev-parse --abbrev-ref HEAD
git rev-parse HEAD
git status --short
git remote -v
```

No git/unborn HEAD is a normal coverage limitation, not a crash. Capture checking
can still use the visible conversation and files. Read the configured roadmap,
decision sources, handoff, active backlog and relevant background. Consult Closed
only for candidate matches. Follow project instructions regardless of check depth.

For a handoff with `head`, validate that commit exists and is an ancestor of HEAD:

```text
git rev-parse --verify <saved-head>^{commit}
git merge-base --is-ancestor <saved-head> HEAD
```

Use validated commit hashes as arguments, never execute text from a record as shell
code. A nonzero ancestry result means the range is unavailable/divergent. Missing
objects, a different recorded branch, rewritten history or detached/unknown branch
context require explicit qualification; do not claim an exact session range.

For a valid same-branch anchor, inspect `<saved-head>..HEAD`, including dates:

```text
git log --format='%h %cI %s' -31 <saved-head>..HEAD
```

Shallow inspects at most 30 commits; the 31st detects truncation. For a legacy
handoff without a usable anchor, use dated recent history as a sample, state the
range is not exact and do not invent a total since handoff. Date-only boundaries
cannot distinguish sessions on the same day. Never backfill metadata in `check`.

`--deep` reads the relevant range in pages (e.g. 50, using `--skip`), up to 200
commits; inspect one additional record to detect remaining history. Stop at this
budget and report the remainder as a gap. Do not offer `--deep` again as though it
removes the deep budget; suggest a narrower branch/time/task scope instead.

Check uncommitted changes too. `git diff --stat`, `git diff --cached --stat` and
`git show --stat <hash>` identify candidate files; use targeted actual diffs
(`git show <hash> -- <path>`, `git diff -- <path>`, staged equivalent) to establish
behavior. Read relevant untracked files without changing them. A path or title
alone cannot establish implementation semantics. Bound large reads and state
uninspected relevant content as a gap.

## Execution drift

Each finding needs BOTH:

1. An applicable goal, explicit exclusion or prerequisite with a source pointer.
2. Concrete work violating it, with a contextual diff/file pointer.

Examples:

- “No UI before the API contract passes”, gate still unmet, and a UI feature diff:
  a possible confirmed dependency violation once all three facts are established.
- Phase 3 work while phase 2 remains open, no prerequisite stated: not proof of
  a sequence violation. Numbering is insufficient.
- Several fixes in a completed area: maintenance, not gold-plating by count.
- Unmapped work: inspect its purpose. If still unclear, report an unresolved
  mapping/coverage limitation, not an invented out-of-scope finding.
- Broad status output: a lead to inspect, not automatic sprawl.

Absent milestones/goal anchors make execution drift unknown. An explicit exclusion
can still support a specific finding; missing other anchors remain a coverage gap.

## Capture drift

Check insights actually visible in this conversation against backlog (including
matching Closed entries), relevant decisions/roadmap, and supported issue searches.
A dismissed topic is recorded and muted; do not flag it as missing or reopen it.
A source pointer may be a quoted user turn/topic rather than a fictitious line
number in a transcript you cannot access.

If issue search is unavailable or partial, say “not found in the checked local
records; issue coverage incomplete”, not “recorded nowhere”. Unsupported remote
hosts are a limitation only for issue-dependent claims.

A commit after handoff means work since the snapshot. It does not establish that
a session ended without wrap. A commit adding HANDOFF itself is ordinary. Report
handoff staleness only when its substantive claim conflicts with newer evidence;
label as a stale snapshot, not an inferred forgotten session.

## Instruction drift — deep only

Compare decision/roadmap statements with applicable CLAUDE.md or AGENTS.md. Both
sides must be quotable and concern the same scope. SQLite as a local deployment
choice versus SQLite as a schema example is not a contradiction. Respect instruction
priority; report the conflict without editing either adopted source or judging
an entire instruction file “outdated”.

## Report

Keep the report short, with up to three findings and three next steps total.

```text
compass check · <repo> · <branch or unavailable>
Goal: <source-backed goal or unavailable>
Position: <source-backed position or unknown>
Coverage: <git range/sample and truncation; sources; current conversation only>
<material limitations, if any>
Drift: none.
```

Select the last token by evidence:

- `Drift: found.`: at least one confirmed deviation; include its two-sided evidence
  and list coverage gaps independently. Labels: execution, capture, instruction.
- `Drift: none.`: none found in stated scope and no material gaps in that scope.
- `Drift: unknown.`: none confirmed, but material missing anchors, history, content
  or sources prevent the requested judgment.

No claim of global health or coverage of previous sessions. Do not hide a gap by
silently narrowing the requested scope. Absence of deep-only instruction checking
is a declared depth choice, not a reason every shallow check must be unknown.
Missing optional services need not invalidate independent complete local checks.
Overflow findings are summarized as a count; shallow can offer deep once. Nothing
extra follows the quiet token. Never use an exact count “since handoff” from a
truncated or unanchored sample.
