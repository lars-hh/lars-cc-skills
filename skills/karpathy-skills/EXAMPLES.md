# Examples — karpathy-skills

These are pattern-match predictions by Claude reading the skill, not live
skill runs from a separate process. Run `/karpathy-skills` after install
for real outputs.

## Prediction 1 — Overengineering check (Principle 2: Simplicity First)

**User prompt:** "Add a config-driven retry mechanism to the API client so we can tune backoff per-environment."

**Expected skill-driven response:** Surface the Karpathy "simplicity first" filter before writing code.

```
Before I add this: do we currently have more than one environment with
different retry needs? If not, "config-driven" is speculative flexibility.
Two simpler alternatives:
  (a) Hardcode the values that work for prod; revisit when staging
      actually needs different ones.
  (b) Three lines of `const RETRIES = process.env.RETRIES ?? 3` —
      env-var, no config system.

Which problem are we actually solving?
```

The skill nudges the model to apply Principle 2 ("No 'flexibility' or
'configurability' that wasn't requested") *before* writing 200 lines of
retry infrastructure.

## Prediction 2 — Surgical-change discipline (Principle 3: Surgical Changes)

**User prompt:** "Fix the typo in the error message on line 42 of `auth.py`. While you're in there, you'll probably notice the function above could use cleanup."

**Expected skill-driven response:**

```
Fixed the typo on line 42. I noticed the surrounding function has some
patterns I'd refactor (deeply nested ifs, repeated string concatenation),
but I'm leaving that untouched — the request was the typo. If you want a
cleanup pass on that function, say so and I'll do it as a separate change.
```

Principle 3's "Don't 'improve' adjacent code… Match existing style"
prevents drive-by refactoring that bloats PRs. The skill also surfaces
the noticed issue (per Principle 3's "mention it - don't delete it") so
the user can choose explicitly.

## Prediction 3 — Goal-driven framing (Principle 4: Goal-Driven Execution)

**User prompt:** "Make the user search faster."

**Expected skill-driven response:**

```
Before implementing, let me convert this into a verifiable goal. Three
candidate success criteria, depending on what's actually slow:

  1. "Search returns in under 200ms for queries with 1-3 terms against
     the current 10k-user dataset." (latency target)
  2. "Reduce DB roundtrips per search from N to 1 — verify via query log."
     (efficiency target)
  3. "Eliminate the visible spinner for typeahead — perceived latency."
     (UX target)

Which one are you actually trying to fix? I'll write the test that
verifies it, then make the code pass.
```

Principle 4's „Transform tasks into verifiable goals" surfaces three
distinct interpretations of the vague request, lets the user pick, then
follows the test-then-implement loop.

## What Lars must run separately after install

After `/plugin install karpathy-skills@lars-cc-skills`, sanity-check:

1. Skill activates on coding-task starts — try a prompt like "Add a
   feature flag for X" and confirm the skill nudges toward Principle 2
   (simplicity check) before code is written.
2. Skill does NOT activate on pure-conversation prompts. Concrete check:
   ask "what is the difference between Principle 1 (Think Before Coding)
   and Principle 3 (Surgical Changes)?" — Claude should answer the
   conceptual question without invoking the skill against any code.
3. Verify the GSD-abgrenzung holds: ask "should I use this instead of
   GSD?" — answer should explain coexistence, not pick one over the
   other.
