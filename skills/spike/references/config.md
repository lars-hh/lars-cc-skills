# Config — where spikes are filed

The skill never hardcodes filing locations. It resolves them in this order:

1. **Project config:** `.spike-config.md` in the repository root
2. **User config:** `~/.claude/spike-config.md`
3. **Default (no config):** project-local, single-tier

## Config file format

```markdown
# spike-config

- spike_docs: <where spike documents live inside a project, e.g. docs/spikes/ or .planning/>
- archive: <OPTIONAL central archive that receives a copy of every closed spike doc>
- index: <the index file that receives one TL;DR line per closed spike>
```

Only `spike_docs` and `index` are required. `archive` is for users who keep a
cross-project knowledge base; omit it for single-repo use.

## Default (no config found)

- Spike docs: `docs/spikes/<YYYY-MM-DD>-<slug>.md`
- Index: `docs/spikes/INDEX.md`
- No archive copy.

## First run

If no config exists, ask ONCE (AskUserQuestion): "Use the default filing layout
(docs/spikes/ + INDEX.md), or configure custom paths?" Write the chosen answer to
`~/.claude/spike-config.md` (or `.spike-config.md` if the user wants it project-only)
and never ask again.

## Index file format

The index is the memory of the whole system — the prior check depends on it.
Two sections:

```markdown
# Spike Index

## Closed spikes (newest first)
| Date | Question | Verdict + 1-liner | Reusable | Doc |
|---|---|---|---|---|
| 2026-07-12 | Can X do Y? | VALIDATED — works via Z | filter recipe (path) | [link] |

## Candidates (parked questions)
- [ ] <question> — parked <date> — source: <where it came up>
```

- **Closed spikes:** exactly one row per closed spike, written during P5.
  The verdict token appears verbatim (greppable).
- **Candidates:** written by `--stub` mode. One line, no file. When a candidate
  is later spiked, check it off and add the closed-spike row.

## Rules

- P5 (capture-before-delete) refuses to finish until the doc exists at
  `spike_docs`, the index row is written, and — if configured — the archive
  copy is filed.
- Never write secrets or token values into any of these files; reference
  credential *paths* only.
