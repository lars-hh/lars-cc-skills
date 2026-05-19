#!/usr/bin/env bash
# marketplace_audit.sh — Verify a skill meets the lars-cc-skills marketplace standard.
#
# Three checks:
#   1. LICENSE file present + SPDX in allowlist
#   2. allowed-tools whitelist discipline (no Bash:* wildcards)
#   3. Frontmatter schema (name, description; license+version for refined)
#
# Exit codes: 0 = PASS, 1 = WARN, 2 = FAIL
#
# Usage:
#   marketplace_audit.sh skills/<name>/
#   marketplace_audit.sh --all skills/
#   marketplace_audit.sh --with-security skills/<name>/

set -o pipefail

ALLOWED_LICENSES=("MIT" "Apache-2.0" "BSD-2-Clause" "BSD-3-Clause" "ISC")
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WITH_SECURITY=0
ALL_MODE=0
TARGET=""

for arg in "$@"; do
  case "$arg" in
    --with-security) WITH_SECURITY=1 ;;
    --all)           ALL_MODE=1 ;;
    --help|-h)
      sed -n '2,15p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *) TARGET="$arg" ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  echo "ERROR: pass a skill directory or use --all <dir>" >&2
  exit 2
fi

# Worst-of accumulator: 0 = PASS, 1 = WARN, 2 = FAIL
WORST=0
TOTAL_PASS=0
TOTAL_WARN=0
TOTAL_FAIL=0

bump() {
  local level="$1"
  if (( level > WORST )); then WORST=$level; fi
}

audit_skill() {
  local skill_dir="$1"
  local skill_name
  skill_name=$(basename "$skill_dir")
  local issues=()
  local warnings=()

  # --- Check 1: LICENSE file ---
  if [[ ! -f "$skill_dir/LICENSE" ]]; then
    issues+=("LICENSE file missing in $skill_dir")
  fi

  # --- Origin.yaml SPDX consistency ---
  local declared_license=""
  if [[ -f "$skill_dir/origin.yaml" ]]; then
    declared_license=$(awk -F': *' '/^license:/{print $2; exit}' "$skill_dir/origin.yaml" | tr -d '"' | tr -d "'" | tr -d ' ')
    if [[ -n "$declared_license" ]]; then
      local allowed=0
      for ok in "${ALLOWED_LICENSES[@]}"; do
        if [[ "$declared_license" == "$ok" ]]; then allowed=1; break; fi
      done
      if (( allowed == 0 )); then
        issues+=("license '$declared_license' not in allowed list (${ALLOWED_LICENSES[*]})")
      fi
    fi
  fi

  # --- Frontmatter parse ---
  local skill_md="$skill_dir/SKILL.md"
  if [[ ! -f "$skill_md" ]]; then
    issues+=("SKILL.md missing")
  else
    # Extract frontmatter (between first two --- lines) via python
    python3 - "$skill_md" "$declared_license" <<'PY' || issues+=("frontmatter parse error")
import sys, re, pathlib

path = pathlib.Path(sys.argv[1])
declared_license = sys.argv[2]
text = path.read_text()
m = re.match(r"^---\n(.*?)\n---", text, re.DOTALL)
if not m:
    print("FAIL: no YAML frontmatter delimited by ---", file=sys.stderr)
    sys.exit(1)

fm = m.group(1)

# Very lightweight YAML scan (no PyYAML dependency)
def has_field(name):
    return bool(re.search(rf"^{name}\s*:", fm, re.MULTILINE))

def field_value(name):
    mm = re.search(rf"^{name}\s*:\s*(.*)$", fm, re.MULTILINE)
    return mm.group(1).strip().strip("'\"") if mm else None

errors = []
if not has_field("name"):
    errors.append("FAIL: frontmatter missing required field 'name'")
if not has_field("description"):
    errors.append("FAIL: frontmatter missing required field 'description'")

# Refined-skill checks: if version or license is present, both should be
has_version = has_field("version")
has_license = has_field("license")
if has_version and not has_license:
    errors.append("WARN: 'version' set but no 'license' field (refined skill convention)")
if has_license and declared_license:
    fm_license = field_value("license") or ""
    if fm_license and fm_license != declared_license:
        errors.append(f"WARN: SKILL.md license '{fm_license}' does not match origin.yaml '{declared_license}'")

# allowed-tools wildcard check
at = field_value("allowed-tools")
if at:
    if re.search(r"Bash\s*:\s*\*", at) or re.search(r"Bash\s*\(\s*\*\s*\)", at):
        errors.append("WARN: 'allowed-tools' contains Bash wildcard — justify in origin.yaml notes")

if errors:
    for e in errors:
        print(e, file=sys.stderr)
    # Use exit code 1 for WARN-only, 2 for any FAIL
    if any(e.startswith("FAIL:") for e in errors):
        sys.exit(2)
    sys.exit(1)
PY

    local rc=$?
    if (( rc == 2 )); then
      issues+=("frontmatter schema FAIL")
    elif (( rc == 1 )); then
      warnings+=("frontmatter schema WARN")
    fi
  fi

  # --- Print per-skill verdict ---
  local skill_verdict="✅ PASS"
  local skill_level=0
  if (( ${#issues[@]} > 0 )); then
    skill_verdict="❌ FAIL"
    skill_level=2
  elif (( ${#warnings[@]} > 0 )); then
    skill_verdict="🟡 WARN"
    skill_level=1
  fi

  echo "── $skill_name : $skill_verdict"
  for w in "${warnings[@]}"; do echo "   🟡 $w"; done
  for i in "${issues[@]}";   do echo "   ❌ $i"; done

  bump "$skill_level"
  case "$skill_level" in
    0) TOTAL_PASS=$((TOTAL_PASS+1)) ;;
    1) TOTAL_WARN=$((TOTAL_WARN+1)) ;;
    2) TOTAL_FAIL=$((TOTAL_FAIL+1)) ;;
  esac

  # --- Optional: also run generic security audit ---
  if (( WITH_SECURITY == 1 )); then
    local sec="$SCRIPT_DIR/skill_security_auditor.py"
    if [[ -f "$sec" ]]; then
      echo "   ↪ generic security audit:"
      python3 "$sec" "$skill_dir" 2>&1 | sed 's/^/     /' || true
    fi
  fi
}

echo "╔════════════════════════════════════════════╗"
echo "║  MARKETPLACE COMPLIANCE AUDIT              ║"
echo "╚════════════════════════════════════════════╝"

if (( ALL_MODE == 1 )); then
  for d in "$TARGET"/*/; do
    audit_skill "$d"
  done
else
  audit_skill "$TARGET"
fi

echo ""
echo "── Summary"
echo "   ✅ PASS: $TOTAL_PASS   🟡 WARN: $TOTAL_WARN   ❌ FAIL: $TOTAL_FAIL"

case "$WORST" in
  0) echo "Verdict: ✅ PASS"; exit 0 ;;
  1) echo "Verdict: 🟡 WARN"; exit 1 ;;
  2) echo "Verdict: ❌ FAIL"; exit 2 ;;
esac
