#!/usr/bin/env bash
# sync-skills.sh — copy this toolkit's skills into another repo's
# .claude/skills/ so they are available in that repo everywhere, including
# cloud/web sessions (which auto-discover .claude/skills/ with NO install and
# NO network). This is the propagation mechanism for the toolkit.
#
# Usage:
#   ./scripts/sync-skills.sh <target-repo> [skill ...]
#   ./scripts/sync-skills.sh --dry-run <target-repo> [skill ...]
#
# With no skill names, every skill under skills/ is synced. Named skills sync
# only those. Each synced skill fully replaces its counterpart in the target
# (kit skills are refreshed); any OTHER skills already in the target's
# .claude/skills/ are left untouched.
#
# NOT synced: the taches-toolkit bundle. It is a command/agent plugin, not a
# plain skill, so it is delivered via the marketplace (/plugin install), not
# via .claude/skills/.
#
# After running, commit <target>/.claude/skills/ in that repo — cloud sessions
# read the committed tree, not your local machine.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"

DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
  shift
fi

TARGET="${1:-}"
if [[ -z "$TARGET" ]]; then
  echo "usage: $0 [--dry-run] <target-repo> [skill ...]" >&2
  exit 2
fi
shift

if [[ ! -d "$TARGET" ]]; then
  echo "ERROR: target '$TARGET' is not a directory" >&2
  exit 1
fi

# Which skills? Named args, or every skill under skills/.
if [[ $# -gt 0 ]]; then
  SKILLS=("$@")
else
  SKILLS=()
  for d in "$SKILLS_DIR"/*/; do
    SKILLS+=("$(basename "$d")")
  done
fi

DEST="$TARGET/.claude/skills"
echo "Syncing ${#SKILLS[@]} skill(s) into $DEST"
[[ $DRY_RUN -eq 1 ]] && echo "(dry-run: nothing written)"

synced=0
for name in "${SKILLS[@]}"; do
  src="$SKILLS_DIR/$name"
  if [[ ! -d "$src" ]]; then
    echo "  SKIP $name — not found under skills/" >&2
    continue
  fi
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "  would sync $name"
    continue
  fi
  mkdir -p "$DEST"
  rm -rf "${DEST:?}/$name"
  cp -R "$src" "$DEST/$name"
  find "$DEST/$name" -name '.DS_Store' -delete 2>/dev/null || true
  echo "  synced $name"
  synced=$((synced + 1))
done

echo "Done."
if [[ $DRY_RUN -eq 0 ]]; then
  echo "Now commit $DEST in that repo so cloud sessions pick the skills up."
fi
