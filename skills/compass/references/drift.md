# Drift — the check playbook

`check` is read-only under all circumstances, including when asked to write. It
observes and offers; `capture` writes.

## Inputs — shallow (the default)

One command per call, no pipes and no `&&` — the allowlist is per-command:

```
git rev-parse --abbrev-ref HEAD
git log --oneline -30
git status --short
git remote
```

plus the four resolved roles from `.compass/config.md`, the current
conversation, and — only where `git remote` returned something and `gh` is
authenticated — `gh issue list --state open`.

`--deep` adds `git diff --stat`, `git log --format='%h %cI %s'` bounded by the
handoff date, `git show --stat` on the specific commits it intends to name, and
a root `CLAUDE.md` / `AGENTS.md` if one exists — the former is already in
context on this platform, the latter is one read.

## Execution drift — evidence lives in git

1. **Unmapped work** — commits since the handoff date that match no milestone of
   the resolved roadmap.
2. **Sequence break** — commits in a later milestone while an earlier one is
   still open.
3. **Gold-plating** — repeated commits in an area the roadmap marks done, or in
   something listed under `## Not doing`.
4. **Sprawl** — broad uncommitted changes across unrelated areas in
   `git status`.

## Capture drift — evidence lives in the conversation, and is missing from the files

1. Something named this session that appears in no role file and no open issue.
2. A decision made in conversation with no entry in DECISIONS.
3. HANDOFF older than the newest commit — the last session ended without
   `wrap`. The handoff carries a date, not a timestamp, so only a **strictly
   earlier day** counts. Commits made after a wrap on the same day are the
   normal case and are not evidence of anything.

## Instruction drift — evidence lives in two files that disagree · `--deep` only

`CLAUDE.md` / `AGENTS.md` is permanently adopted: read, never written. One
signal, and deliberately only one:

1. A DECISIONS entry or a roadmap milestone contradicts a line in that file.

**Both sides must be quotable.** `DECISIONS.md:41` says X, `CLAUDE.md:31`
requires Y. One pointer is not enough here — with only one side quoted the claim
is an impression about a file, and it gets dropped like any other unevidenced
observation.

**The bar is a contradiction, not a shared keyword.** A real pair that must
*not* fire: the decisions file says *"SQLite only as local iOS storage, never as
the server DB"*, and the instructions file names another project's *"SQLite
schema as the template for our rules table"*. Same word, opposite-looking
polarity, no conflict — one is about deployment, the other about a schema shape.
Test it by restating both sides in one sentence; if that sentence is not
self-contradictory, there is nothing to report.

**Never judge the file itself.** "CLAUDE.md looks outdated", "these conventions
seem stale", "this should probably be rewritten" are not observations. They are
noise aimed at the one document that outranks everything else in the session,
and a skill that erodes trust in it has done more damage than the contradiction
would have. Report the contradiction and stop; which side is wrong is the user's
call, and it is a next step, never a fix compass performs.

Shallow `check` does not run this pass at all. That is not a budget decision: the
quiet path is the reason the skill still gets read after a month, and a
cross-file comparison is exactly the kind of signal that produces confident
nonsense when run on every invocation.

## Evidence or silence

Every claim carries a pointer: a commit hash, a file path, a line. A commit that
merely *sounds* off-plan is not evidence. Without a pointer, the observation is
dropped — not softened, dropped. This single rule is what keeps the report from
becoming background noise.

## Report shape

Quiet path, and this is the whole output:

```
compass check · <repo> · <branch> · <N> commits since handoff

Goal: <one sentence from the roadmap>
Position: <milestone, and whether it is on track>

Drift: none.
```

`Drift: none.` is a literal token, so "it was quiet" is checkable rather than
inferred. Nothing follows it — no observations that are not drift, no
encouragement.

Drift path: the same header, then at most **three** observations, each labelled
`Drift (execution):`, `Drift (capture):` or — under `--deep` only —
`Drift (instruction):`, each carrying its evidence, then at most **three** next
steps. The cap of three is counted across all labels together, not per label.
Overflow becomes a single line offering `--deep`.

A next step is a decision the user can make, not a task compass intends to
perform.

## When the roadmap has no milestones

Report `Drift (execution): not judgeable — <roadmap path> has no milestones
yet.` and continue with capture drift, which does not need them. Do not
substitute commit clustering for a plan; an invented anchor produces confident
accusations about work nobody agreed to judge.

## Depth dial — calibrate here, and only here

This is the part deliberately left open until the skill has run on real
projects. Nothing outside this file references these signals by name, so tuning
is a one-file edit.

**Default (shallow):** the three git commands plus the role files and the
conversation · execution signals 1–4 · capture signals 1–3 · caps of three and
three.

**`--deep` adds:** per-commit inspection, diff stats, time-bounded history since
the handoff, and the instruction signal against `CLAUDE.md` / `AGENTS.md`.

**To turn it down:** delete signals from the default lists above.
**To turn it up:** add a signal here, and only here. If a new signal needs a new
command, add it to `allowed-tools` in SKILL.md at the same time — a scoped
allowlist means an unlisted command simply will not run.
