---
name: repomix
version: 1.0.0
license: MIT
allowed-tools: Bash(repomix:*), Bash(brew:*), Bash(npm:*), Read
description: |
  Pack an entire repository (or a subdirectory / a curated file set) into a
  single AI-friendly file, ready to feed into a long-context LLM session.
  Wraps the `repomix` CLI (https://github.com/yamadashy/repomix) for use
  inside Claude Code. Use when you want to bring an external project into
  the current Claude session as cross-project context, when you need a
  shareable single-file dump of a codebase, when you are preparing a code
  review or audit and want one file to scroll through, or when you want
  to feed your own codebase to a different LLM for comparison.
  Activation hints: "pack repo", "bundle the repo", "feed codebase to LLM",
  "cross-project context", "single-file dump", "repomix", "share this
  codebase".
---

# repomix — Repository Packer

`repomix` is a CLI tool that walks a directory tree, applies `.gitignore`
and a configurable include/exclude policy, and concatenates everything
into one annotated file (XML, Markdown, or plain text) sized to fit
inside an LLM context window.

This skill is a thin wrapper that documents the CLI for Claude Code use.
It does not ship a re-implementation — install the upstream binary once,
then invoke as shown below.

## Installation (one-time)

```bash
# macOS / Linux via Homebrew
brew install repomix

# Or via npm (works on any platform with Node)
npm install -g repomix
```

Confirm: `repomix --version` should print a 0.x.x number.

## Quick Start

```bash
# Pack the current directory into repomix-output.xml
repomix .

# Same, but write to a named file (Markdown format)
repomix . --output context.md --style markdown

# Include only certain files
repomix . --include "src/**/*.ts,README.md"

# Exclude noisy paths beyond .gitignore
repomix . --ignore "**/*.test.ts,docs/**,node_modules/**"

# Pack a specific subdirectory
repomix ./packages/core

# Pack a remote repo without cloning first (clones to temp + cleans up)
repomix --remote https://github.com/owner/repo
```

The output file is the artifact Claude reads. After `repomix .` the file
`repomix-output.xml` (or whatever `--output` named) is the single source
of truth for the packed view.

## When to use this skill

- **Bring an external repo into the current session.** Claude has no
  access to repos outside the working directory. `repomix --remote <url>`
  produces a single file you can `cat` or open directly.
- **Send a codebase to another LLM for comparison.** A single Markdown
  file is far easier to upload to ChatGPT / Gemini / Claude.ai than
  multi-file selection.
- **Code review / audit prep.** One scrollable artifact beats jumping
  between IDE tabs when you want a holistic read.
- **Onboarding a teammate.** "Read this packed file, then we'll talk."

## Output formats

| Format | Flag | Best for |
|--------|------|----------|
| XML (default) | `--style xml` | LLM-friendly, explicit tags around each file |
| Markdown | `--style markdown` | Human-readable, GitHub-renderable |
| Plain | `--style plain` | Minimal envelope, when you want the raw text |

## Tuning the include set

```bash
# Estimate token count before packing (no file written)
repomix . --token-count

# Show a tree of what would be included given current ignore rules
repomix . --tree

# Compress comments + reduce whitespace (cheaper context)
repomix . --compress
```

`--compress` typically saves 30-50% of tokens. Recommended for any
codebase you are about to feed into an LLM session.

## When NOT to use this skill

- For **searching** inside a codebase, use `grep`, `rg`, or the project's
  `Explore` subagent — `repomix` is for packing, not querying.
- For very large monorepos (>500k LOC), pack subdirectories instead of
  the whole tree. Even with `--compress`, a million-line repo will
  exceed any LLM's context budget.
- If you only need a handful of files, just `cat` or `Read` them
  directly. `repomix` is for whole-tree or whole-package context, not
  ad-hoc snippets.

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `command not found: repomix` | Re-run installation, restart the shell |
| Output too large for context | Use `--compress`, `--include`, or pack a subdir |
| Sensitive files included | Add to `.repomixignore` (same syntax as `.gitignore`) |
| Want repomix to also follow custom includes | Set `repomix.config.json` in the repo root |

For deeper configuration (config files, custom output templates,
integration with CI), see the upstream README at
https://github.com/yamadashy/repomix.

## License

repomix itself is MIT (Copyright 2024 Kazuki Yamada). This wrapper SKILL.md
is also MIT under the lars-cc-skills marketplace. See `LICENSE`.
