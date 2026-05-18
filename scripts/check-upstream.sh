#!/usr/bin/env bash
# check-upstream.sh — Compare each skill's origin.yaml last_upstream_check
# against the current upstream HEAD. Reports drift.
#
# Usage: ./scripts/check-upstream.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"

if ! command -v yq >/dev/null 2>&1; then
  echo "ERROR: yq required. Install: brew install yq" >&2
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "ERROR: gh CLI required. Install: brew install gh" >&2
  exit 1
fi

DRIFT_COUNT=0
CHECKED_COUNT=0

for skill_dir in "$SKILLS_DIR"/*/; do
  skill=$(basename "$skill_dir")
  origin="$skill_dir/origin.yaml"

  if [[ ! -f "$origin" ]]; then
    echo "SKIP: $skill — no origin.yaml"
    continue
  fi

  CHECKED_COUNT=$((CHECKED_COUNT + 1))

  inspired_by=$(yq '.inspired_by' "$origin" 2>/dev/null || echo "null")
  last_check=$(yq '.last_upstream_check' "$origin" 2>/dev/null || echo "null")
  pinned_commit=$(yq '.upstream_commit // ""' "$origin" 2>/dev/null || echo "")

  if [[ "$inspired_by" == "null" || -z "$inspired_by" ]]; then
    echo "SKIP: $skill — no inspired_by in origin.yaml"
    continue
  fi

  # Get current upstream HEAD
  current_head=$(git ls-remote "https://github.com/$inspired_by.git" HEAD 2>/dev/null | awk '{print $1}' || echo "")

  if [[ -z "$current_head" ]]; then
    echo "WARN: $skill — cannot reach upstream $inspired_by"
    continue
  fi

  if [[ -n "$pinned_commit" && "$pinned_commit" != "$current_head" ]]; then
    echo "DRIFT: $skill"
    echo "  upstream: $inspired_by"
    echo "  pinned:   $pinned_commit"
    echo "  current:  $current_head"
    echo "  last_upstream_check: $last_check"
    DRIFT_COUNT=$((DRIFT_COUNT + 1))
  else
    echo "OK: $skill (upstream $inspired_by, last check $last_check)"
  fi
done

echo ""
echo "Summary: $CHECKED_COUNT skill(s) checked, $DRIFT_COUNT drift(s) detected."

exit $((DRIFT_COUNT > 0 ? 1 : 0))
