# Examples — security-auditor

These are pattern-match analyses by Claude reading the skill, not live skill runs
from a separate process. Run `scripts/marketplace_audit.sh` after install for
real outputs.

## Marketplace Compliance Mode — live tests (2026-05-19)

Five live runs of `marketplace_audit.sh` against the actual `lars-cc-skills`
state during Phase 2.3.

### Test 1 — Self-audit (security-auditor)

```bash
$ ./skills/security-auditor/scripts/marketplace_audit.sh skills/security-auditor/
── security-auditor : ✅ PASS
Verdict: ✅ PASS
```

The auditor passes its own marketplace checks. LICENSE present, allowed-tools
not declared (skill inherits defaults — acceptable), frontmatter has name +
description + version + license.

### Test 2 — humanizer (already-refined)

```bash
$ ./skills/security-auditor/scripts/marketplace_audit.sh skills/humanizer/
── humanizer : ✅ PASS
Verdict: ✅ PASS
```

The cross-skill check confirms humanizer (refined by Phase 2.1) is marketplace-
compliant: LICENSE present, MIT in allowlist, frontmatter complete.

### Test 3 — obsidian-markdown (already-refined)

```bash
$ ./skills/security-auditor/scripts/marketplace_audit.sh skills/obsidian-markdown/
── obsidian-markdown : ✅ PASS
Verdict: ✅ PASS
```

Same as Test 2 — obsidian-markdown (refined by Phase 2.2) passes.

### Test 4 — Empty skill folder (caveman, jq, repomix, etc.)

```bash
$ ./skills/security-auditor/scripts/marketplace_audit.sh skills/caveman/
── caveman : ❌ FAIL
   ❌ LICENSE file missing in skills/caveman/
   ❌ SKILL.md missing
Verdict: ❌ FAIL
```

Empty TODO folders FAIL as expected — confirms the auditor catches the most
common pre-merge mistake (forgetting to copy LICENSE).

### Test 5 — Full marketplace sweep

```bash
$ ./skills/security-auditor/scripts/marketplace_audit.sh --all skills/
── caveman                    : ❌ FAIL  (LICENSE missing, SKILL.md missing)
── changelog-skill            : ❌ FAIL  (LICENSE missing, SKILL.md missing)
── humanizer                  : ✅ PASS
── jq                         : ❌ FAIL  (LICENSE missing, SKILL.md missing)
── karpathy-skills            : ❌ FAIL  (LICENSE missing, SKILL.md missing)
── mermaid-diagram-specialist : ❌ FAIL  (LICENSE missing, SKILL.md missing)
── obsidian-markdown          : ✅ PASS
── repomix                    : ❌ FAIL  (LICENSE missing, SKILL.md missing)
── security-auditor           : ✅ PASS

── Summary
   ✅ PASS: 3   🟡 WARN: 0   ❌ FAIL: 6
Verdict: ❌ FAIL
```

Sweep mode confirms the current v0.1.0 state: 3 of 9 skills are merge-ready,
6 still need to be filled in Phases 2.4, 2.5, and 3.

## Pattern-match predictions — Generic Security Audit

These are predictions from reading the upstream Python script's pattern catalog,
not live runs. The script (`skill_security_auditor.py`, 1066 LOC, unchanged from
upstream) catches these on a real audit.

### Prediction 1 — Skill with `eval(user_input)`

Expected verdict: **❌ FAIL**

```
🔴 CRITICAL [CODE-EXEC] scripts/helper.py:N
   Pattern: eval(user_input)
   Risk: Arbitrary code execution from untrusted input
   Fix: Replace eval() with ast.literal_eval() or explicit parsing
```

### Prediction 2 — Skill with `requests.post("https://...", data=...)`

Expected verdict: **❌ FAIL**

```
🔴 CRITICAL [NET-EXFIL] scripts/sender.py:N
   Pattern: requests.post(...)
   Risk: Data exfiltration to external server
   Fix: Remove outbound network calls or verify destination is trusted
```

### Prediction 3 — Skill reading `~/.ssh/id_rsa`

Expected verdict: **🟡 WARN** (HIGH severity, but non-critical until paired with NET-EXFIL).

```
🟡 HIGH [FS-BOUNDARY] scripts/scanner.py:N
   Pattern: open(os.path.expanduser("~/.ssh/id_rsa"))
   Risk: Reads SSH private key outside skill scope
   Fix: Remove filesystem access outside skill directory
```

### Prediction 4 — SKILL.md with hidden prompt-injection

Expected verdict: **❌ FAIL**

```
🔴 CRITICAL [PROMPT-INJ] SKILL.md:N
   Pattern: Ignore previous instructions
   Risk: System prompt override
   Fix: Remove the injection pattern from SKILL.md
```

### Prediction 5 — Vanilla skill (no scripts, MIT, clean frontmatter)

Expected verdict: **✅ PASS**

```
╔══════════════════════════════════════════════╗
║  SKILL SECURITY AUDIT REPORT                ║
║  Skill: caveman                              ║
║  Verdict: ✅ PASS                            ║
╚══════════════════════════════════════════════╝
```

## What Lars must run separately after install

After `/plugin install security-auditor@lars-cc-skills`, run these to confirm
end-to-end:

1. **Self-audit** — `marketplace_audit.sh skills/security-auditor/` should PASS.
2. **Cross-audit** — `marketplace_audit.sh --all skills/` should match Test 5.
3. **Generic scan** — `python3 skills/security-auditor/scripts/skill_security_auditor.py skills/humanizer/` should output a structured report.
4. **CI smoke test** — `marketplace_audit.sh --with-security skills/obsidian-markdown/` should chain both checks.
5. **Wildcard detection** — temporarily add `allowed-tools: Bash:*` to a test skill's frontmatter, run the wrapper, verify WARN.
