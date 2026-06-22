---
name: karpathy-skills
version: 1.0.0
license: MIT
allowed-tools: Read, Edit, Write
description: |
  Karpathy-inspired behavioral guidelines (authored by forrestchang/multica-ai,
  not by Andrej Karpathy) to reduce common LLM coding mistakes. Four principles
  — think before coding, simplicity first, surgical changes, goal-driven
  execution — applied during writing, reviewing, or refactoring code to avoid
  overcomplication, surface assumptions, and define verifiable success
  criteria. Use when starting a coding task and you want a short behavioral
  checklist, when reviewing code that feels overengineered, or when scoping
  a refactor to keep it surgical.
  Activation hints: "karpathy guidelines", "llm coding pitfalls", "behavioral
  guidelines for coding", "simplicity first", "surgical change", "think before
  coding", "goal-driven execution".
---

> **Learnings (Maintainer):** bekannte Probleme/Erkenntnisse zu diesem Skill in `docs/skill-learnings.md` → Sektion „karpathy-skills".

# Karpathy-inspired Coding Guidelines

## Source & attribution

These four principles are **inspired by** [Andrej Karpathy's X-post on LLM coding pitfalls (2026-01-26)](https://x.com/karpathy/status/2015883857489522876). They were **authored** by Jiayuan Zhang ([@forrestchang](https://github.com/forrestchang)) and contributors under the [multica-ai](https://github.com/multica-ai) organization, in the upstream repo [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) under MIT license.

Karpathy himself does **not** maintain Claude Code skills. Any external references attributing this skill to Karpathy directly are mis-attributions.

## When to use this skill

This is a one-page behavioral checklist, not an execution framework. It pairs well with task-driven execution skills (see "Relation to other goal-driven frameworks" below). Reach for it when:

- You are about to start a coding task and want a short pre-flight check.
- You are reviewing code that feels overengineered and want a vocabulary for what's wrong.
- You are scoping a refactor and need a rule for what NOT to touch.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## Relation to other goal-driven frameworks

The fourth principle, **Goal-Driven Execution**, overlaps in spirit with GSD (`/gsd-*`) and Superpowers' executing-plans workflow. The boundary is scope:

| Layer | This skill | GSD / Superpowers |
|-------|------------|-------------------|
| What it is | A one-page behavioral checklist (4 principles) | A full execution framework (spec → plan → execute → verify) |
| When to invoke | Inline reminder during a coding task | At the start of a feature or refactor |
| Output | Mental adjustment | Files in `.planning/`, atomic commits, verification reports |
| Pairs with | GSD, Superpowers, any task framework | This skill (as the inline reminder during execute-phase) |

In other words: GSD and Superpowers (`/gsd-plan-phase`, `/superpowers:executing-plans`) structure **what** you build and **how the work moves**. These four Karpathy-inspired principles structure **how you write each line** while you do it. Use them together, not instead of each other.

If you find yourself reaching for these principles in place of a planning workflow on a non-trivial task, prefer the planning workflow — these guidelines are not a substitute for a plan with verifiable steps.
