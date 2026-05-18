#!/usr/bin/env bash
# audit-license.sh — Verify each skill has a LICENSE file and origin.yaml
# declares an SPDX-compatible license.
#
# Usage: ./scripts/audit-license.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"
ALLOWED_LICENSES=("MIT" "Apache-2.0" "BSD-2-Clause" "BSD-3-Clause" "ISC")

ISSUES=0
PASSED=0

for skill_dir in "$SKILLS_DIR"/*/; do
  skill=$(basename "$skill_dir")
  problems=()

  # Check LICENSE file
  if [[ ! -f "$skill_dir/LICENSE" ]]; then
    problems+=("missing LICENSE file")
  fi

  # Check SKILL.md exists
  if [[ ! -f "$skill_dir/SKILL.md" ]]; then
    problems+=("missing SKILL.md")
  fi

  # Check origin.yaml
  if [[ ! -f "$skill_dir/origin.yaml" ]]; then
    problems+=("missing origin.yaml")
  else
    if command -v yq >/dev/null 2>&1; then
      license=$(yq '.license' "$skill_dir/origin.yaml" 2>/dev/null || echo "null")
      if [[ "$license" == "null" || -z "$license" ]]; then
        problems+=("origin.yaml has no license field")
      else
        # Check license is allowed
        allowed=0
        for ok in "${ALLOWED_LICENSES[@]}"; do
          if [[ "$license" == "$ok" ]]; then
            allowed=1
            break
          fi
        done
        if [[ $allowed -eq 0 ]]; then
          problems+=("license '$license' not in allowed list (${ALLOWED_LICENSES[*]})")
        fi
      fi
    fi
  fi

  if [[ ${#problems[@]} -eq 0 ]]; then
    echo "PASS: $skill"
    PASSED=$((PASSED + 1))
  else
    echo "FAIL: $skill"
    for p in "${problems[@]}"; do
      echo "  - $p"
    done
    ISSUES=$((ISSUES + 1))
  fi
done

echo ""
echo "Summary: $PASSED passed, $ISSUES failed."

exit $((ISSUES > 0 ? 1 : 0))
