#!/usr/bin/env bash
# verify-attribution.sh — Cross-check attribution for the skills in skills/.
#
# Two kinds of skill are recognised via origin.yaml `mode:`:
#   - third-party (default): must be listed in THIRD_PARTY_LICENSES.md and
#     carry original_author + inspired_by in origin.yaml.
#   - authored (mode: authored): a from-scratch skill by the repo owner. It
#     needs an original_author, but NO third-party attribution (no upstream,
#     not listed in THIRD_PARTY_LICENSES.md). This is a personal toolkit, so
#     authored skills are first-class citizens, not an exception.
#
# Usage: ./scripts/verify-attribution.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"
LICENSES_DOC="$REPO_ROOT/THIRD_PARTY_LICENSES.md"

if [[ ! -f "$LICENSES_DOC" ]]; then
  echo "ERROR: THIRD_PARTY_LICENSES.md not found at $LICENSES_DOC" >&2
  exit 1
fi

ISSUES=0
PASSED=0

for skill_dir in "$SKILLS_DIR"/*/; do
  skill=$(basename "$skill_dir")
  origin="$skill_dir/origin.yaml"

  if [[ ! -f "$origin" ]]; then
    echo "SKIP: $skill — no origin.yaml"
    continue
  fi

  problems=()

  # Mode detection is yq-independent so the script still works without yq.
  mode="third-party"
  if grep -Eq '^[[:space:]]*mode:[[:space:]]*authored\b' "$origin"; then
    mode="authored"
  fi

  original_author="null"
  inspired_by="null"
  if command -v yq >/dev/null 2>&1; then
    original_author=$(yq '.original_author' "$origin" 2>/dev/null || echo "null")
    inspired_by=$(yq '.inspired_by' "$origin" 2>/dev/null || echo "null")
  fi

  if [[ "$mode" == "authored" ]]; then
    # Owner-written skill: no upstream, no third-party listing required.
    label="$skill (authored)"
    if command -v yq >/dev/null 2>&1; then
      if [[ "$original_author" == "null" || -z "$original_author" ]]; then
        problems+=("authored skill has no original_author")
      fi
    fi
  else
    # Third-party skill: must be attributed.
    label="$skill"
    if ! grep -iq "### $skill" "$LICENSES_DOC"; then
      problems+=("not listed in THIRD_PARTY_LICENSES.md (expected header '### $skill')")
    fi
    if command -v yq >/dev/null 2>&1; then
      if [[ "$original_author" == "null" || -z "$original_author" ]]; then
        problems+=("origin.yaml has no original_author")
      fi
      if [[ "$inspired_by" == "null" || -z "$inspired_by" ]]; then
        problems+=("origin.yaml has no inspired_by")
      fi
    fi
  fi

  if [[ ${#problems[@]} -eq 0 ]]; then
    echo "PASS: $label"
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
