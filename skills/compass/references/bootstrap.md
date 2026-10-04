# Bootstrap and partial setup

Used by `start` when any configuration/role is missing. `check` never bootstraps;
`capture` and `wrap` create only the records needed for their requested action.
An existing `.compass/` directory is not proof that setup is complete.

## Inspect first

Read existing config, relevant project instructions, README, existing steering
sources, and dated recent git history where available. Use the candidate table
in SKILL.md; do not maintain a second resolution order here. A planning framework
is a reason to adopt its roadmap, not refuse Compass or create a rival plan.

Preserve all existing Compass items and config exceptions. If a configured source
has disappeared, flag the missing source rather than silently adopt another one.
Resolve only the ambiguity necessary to complete setup. Existing valid decisions
about ownership are not a recurring interview.

A decisions source may be a consolidated architecture document with binding choices.
Do not reject it just because it is not a dated log. A file that merely describes
components without choices remains background. Existing handoffs from other tools
remain owned by those tools; our handoff may be a compact reference to them.

## Infer, then ask only what is missing

For missing direction, infer a draft goal from the project material. Do not treat
commit subjects as future commitments. Propose milestones only if supported by
an existing agreement. Higher-priority project instructions remain authoritative;
a README is evidence, not a way to override them.

Ask at most two necessary questions, grouping unresolved role choices and goal
confirmation where useful. If the user already stated the goal, do not ask again.
If no goal can be inferred, ask directly for it instead of offering an empty draft
and asking the same thing a second time. No stakeholder/success-criteria interview.
A substantive unresolved ownership ambiguity remains pending if the question
budget is exhausted; never guess a write target just to finish setup.

## Complete missing files only

Use skeletons from `references/artifacts.md`. Adopted roles get config references,
not duplicates. Preserve existing backlog, decisions, handoff and their IDs. Create
an empty backlog with headings only when none exists. Persist only resolved roles;
mark unresolved ones explicitly as unresolved, with the reason, rather than a
made-up path. A future start can resolve them; check reports the coverage gap.

List applicable CLAUDE.md/AGENTS.md as background. Their authority/read-only status
does not depend on that list. Existing local/private location and symlink decisions
are valid exceptions to the default `.compass/` location. Do not change ignore rules.

For a new own roadmap:

```markdown
# Roadmap

**Goal:** <the established goal>

## Milestones

<!-- No agreed milestones yet. capture --hard records a backlog proposal;
     an explicit request to adopt it into this roadmap creates the milestone. -->

## Not doing

<!-- Add only established exclusions. -->
```

Do not fill placeholders with invented scope. Without anchors, execution checking
is limited; say so. A blank milestone list is not a successful planning outcome.

## Report

At most 12 lines, including orientation: what was created/adopted, goal/position,
accepted pending work, relevant gaps. Recommend tracking `.compass/` for cross-device
availability on a new default setup; respect an established private-storage choice
and mention its sync limitation only when relevant. Never commit or edit excludes.
