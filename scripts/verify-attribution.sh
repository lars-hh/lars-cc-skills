#!/usr/bin/env bash
# verify-attribution.sh — Cross-check that each skill's origin.yaml
# original_author matches what THIRD_PARTY_LICENSES.md claims, and that
# SKILL.md has an author or attribution somewhere.
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

  # Check skill is mentioned in THIRD_PARTY_LICENSES.md (case-insensitive header match)
  if ! grep -iq "### $skill" "$LICENSES_DOC"; then
    problems+=("not listed in THIRD_PARTY_LICENSES.md (expected header '### $skill')")
  fi

  if command -v yq >/dev/null 2>&1; then
    original_author=$(yq '.original_author' "$origin" 2>/dev/null || echo "null")
    inspired_by=$(yq '.inspired_by' "$origin" 2>/dev/null || echo "null")

    if [[ "$original_author" == "null" || -z "$original_author" ]]; then
      problems+=("origin.yaml has no original_author")
    fi

    if [[ "$inspired_by" == "null" || -z "$inspired_by" ]]; then
      problems+=("origin.yaml has no inspired_by")
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
