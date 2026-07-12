---
name: spike
description: "Runs a time-boxed spike to answer a single falsifiable feasibility or knowledge question ('would X work?', 'does API Y support Z?') through a gated workflow: charter interview, prediction before evidence, iteration budget, counter-checked verdict, and enforced capture into a searchable spike index. Also parks questions as index candidates (--stub). Use when the user says 'spike this', 'quick experiment', 'can we…', 'would it work if…', or wants to park a research question. NOT for spike SERIES serving a product idea with interactive prototypes (use a feasibility-series framework such as gsd-spike), NOT for open brainstorming without a testable question, NOT for tasks whose outcome is already known (just do those)."
argument-hint: "<question> [--quick] [--stub] | resume"
allowed-tools: Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Bash
---

# Spike

One entry point for spikes: time-boxed experiments that answer a falsifiable
question and leave durable, findable knowledge behind. The skill exists to
enforce the steps that get skipped under time pressure — the prior check, the
prediction before the evidence, the counter-check before VALIDATED, and the
filing that makes the answer findable next quarter.

**Two products per run:** a verdict (one of four tokens) and a spike document
filed where the config says (see `references/config.md`).

## Learnings

> Before starting: read the "spike" section of this marketplace's
> `docs/skill-learnings.md` if present (known pitfalls from real runs).

## Dispatch

| Invocation | Behavior |
|---|---|
| `/spike <question>` | Full workflow P0–P5 (normal case) |
| `/spike --quick <question>` | Skip the charter interview; silently validate falsifiability + prior check (see `references/charter.md`) |
| `/spike --stub <question>` | Park the question: one line in the index Candidates section, no file, no workflow |
| `/spike resume` | Grep configured spike docs for frontmatter `status: open`, list them, continue one — resume at the first incomplete body section in `references/template.md` order (never re-ask completed charter questions; re-check the budget first) |
| `/spike` (empty) | Show the index Candidates section read-only: "what would be worth spiking now?" |

## P0 — Triage

Route deterministically, announce the route, use AskUserQuestion only on genuine
ambiguity:

- **Own workflow (P1–P5)** — the normal case: a single knowledge question
  (API/data/feasibility probe) with an observable yes/no/partial answer,
  estimated ≤ half a day.
- **Feasibility-series framework** (e.g. gsd-spike, if installed) — the question
  serves a product/app idea and decomposes into several connected buildable
  experiments, or experiencing interactive prototypes is the point. If no such
  framework is installed, offer to decompose into sequential single spikes instead.
- **Stub mode** — the question surfaced mid-task and should not derail current
  work: park it, continue working.

**Escalation rule:** if a running spike sprawls — a third follow-up question
appears (judgment call, intentionally not counted), or the budget is breached
twice — actively propose escalating to a
feasibility-series framework instead of silently continuing. A spike that has
become a project must be named one.

## P1 — Charter Gate

**Before Q1:** resolve the filing config per `references/config.md` (run its
first-run prompt if no config exists) — the prior check and the doc location
depend on it.

Read `references/charter.md`. Ask the four questions one at a time, each with a
recommended answer: (1) falsifiable G/W/T, (2) trigger & consequence,
(3) iteration budget & abort criterion, (4) prior-check confirmation.
The prior check scans the configured index + archive BEFORE asking.
Create the spike doc from `references/template.md` with the charter filled in.
**Do not begin P2 until all four charter answers are recorded in the doc.**

## P2 — Prediction before evidence

Collect what [OFFICIAL] docs and [COMMUNITY] sources claim, write them into the
Prediction section with a one-sentence "we expect" — BEFORE running anything.
**Do not start P3 without a written Prediction section.** Skippable only for
pure-logic questions with no external dependency (note the skip in the doc).

## P3 — Experiment

- Throwaway code lives ONLY in a scratch directory (session scratchpad or tmp) —
  never committed into the project.
- Document the Setup section as you go: exact requests, cutoffs, caps,
  credential *paths* never values.
- Findings are numbers, not adjectives. Note raw-data paths.
- Every iteration appends one Investigation Trail line and increments `used`.
- **Budget breach → mandatory AskUserQuestion:** (a) write the verdict now — if
  the question is open, that is honestly INCONCLUSIVE, (b) extend ONCE with a
  new budget and a one-line justification in the doc, (c) escalate (P0 rule).
  On a second breach, option (b) is gone: the verdict is due.

## P4 — Verdict Gate

Four tokens only: `VALIDATED / REFUTED / PARTIAL / INCONCLUSIVE` (uppercase,
English, verbatim — they must be greppable). Before accepting VALIDATED, ask
actively: **"What did you test that could have flipped this verdict?"** A single
happy-path run never validates. Record the counter-check line in the doc.

## P5 — Capture before delete

Refuse to close the spike until, per `references/config.md`:
1. the spike doc is final at the configured `spike_docs` location,
2. the index row is written (verdict token verbatim),
3. the follow-up is routed (task / issue / backlog / "none because …"),
4. the archive copy is filed, if an archive is configured.

Only then may throwaway code be deleted. This order is not negotiable — the
capture is the product; the code was never the point.

## Guardrails

Unrestricted Bash is a deliberate, accepted residual risk — P3 experiments need
arbitrary commands, so these rules are the compensating control. They are not
optional.

- Never write secrets, tokens, or credential values into spike docs or the
  index — reference their paths instead.
- AskUserQuestion before any action that changes state outside the scratch
  directory: API writes (POST/PUT/DELETE against real systems), CRM mutations,
  file deletions outside scratch, git pushes.
- Spike code never moves into production paths. If a finding should become
  product code, that is a follow-up task, written cleanly.
- Interact in the user's language; write the spike doc in the project's working
  language; verdict tokens stay English.

## What this skill is NOT

- Not a prototype-series runner — no MANIFEST, no multi-spike orchestration
  (route those out in P0).
- Not a research-report generator — a spike ends in a verdict, not a survey.
- Not a task executor — "just do X" has no falsifiable question in it.
