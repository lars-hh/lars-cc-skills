# Deployment

How this toolkit reaches the three places it needs to be. Verified against the Claude Code docs (2026-08-13).

## The three goals

1. My own machines (Mac + Windows).
2. One collaborator.
3. **Cloud / web sessions** (claude.ai/code) that only have a GitHub repo checked out — no access to my local machine or `~/.claude`.

## The key fact

A plugin marketplace is **per-machine**: `/plugin marketplace add` writes to `~/.claude/plugins/known_marketplaces.json`, which does **not** sync across machines and is **not** visible to a cloud session.

What a cloud session loads is the repo's committed **`.claude/skills/<name>/SKILL.md`** — auto-discovered on every surface (CLI, desktop, cloud) with **no install and no network call**. That, not the marketplace, is what puts skills into cloud sessions.

So the toolkit ships two ways:

| Goal | Mechanism |
|---|---|
| My machines | `/plugin marketplace add lars-hh/lars-cc-skills` + `/plugin install` (once per machine) |
| A collaborator | Same — they add the public marketplace once |
| Cloud sessions | Committed `.claude/skills/` in the target repo, put there by `scripts/sync-skills.sh` |

## Per-machine (marketplace)

```bash
/plugin marketplace add lars-hh/lars-cc-skills
/plugin install spike@lars-cc-skills
/plugin update            # after pushing changes
```

Repeat once on each machine. A collaborator does the same against the public repo — that is all they need.

## Per-repo (for cloud sessions)

```bash
scripts/sync-skills.sh /path/to/repo         # copy all skills into .claude/skills/
scripts/sync-skills.sh /path/to/repo spike   # or a named subset
```

Then commit `.claude/skills/` in that repo. Every cloud session on that repo now has the skills, with nothing to install.

`taches-toolkit` is a command/agent bundle, not a plain skill — it travels via the marketplace, not `.claude/skills/`.

## Keeping it alive

Two habits, not a heavy process:

- **Propagate:** after changing a skill, re-run `sync-skills.sh` for the repos that use it, and commit their `.claude/skills/`.
- **Learn:** when real use surfaces something, append one dated line to `docs/skill-learnings.md`. That file travels with the repo to every clone and cloud session.

## Caveat (not yet verified in a live cloud session)

A committed `.claude/settings.json` with `extraKnownMarketplaces` + `enabledPlugins` *may* let a cloud session pull the marketplace directly, avoiding copied skill files — but it needs network access, and the relative-path resolution in the cloud environment is not confirmed in the docs. Until tested in a real cloud session, committed `.claude/skills/` is the zero-ambiguity path. Worth a one-off spike later.
