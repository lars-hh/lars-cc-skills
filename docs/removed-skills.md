# Removed Skills

Skills that were part of this toolkit and later removed, with the reason. Kept
as a durable record so a removed skill is not silently re-added or re-evaluated
from zero. Every removed skill is recoverable from git history (and from its
upstream) — removal is not loss.

## 2026-08-13 — Werkzeugkasten pivot (5 removed)

The repo shifted from "curated marketplace" to **personal toolkit**. The filter
changed from *is it well-built?* to *do I actually use it?* Each of the ten
skills was used once more against a real example and judged. Five were cut:

| Skill | Why removed |
|---|---|
| `caveman` | No real trigger in the owner's workflow. Caveman-speak is a gimmick; the owner's "brief" means padding-free German, not pidgin. |
| `karpathy-skills` | Redundant with superpowers + the owner's own CLAUDE.md discipline. The skill itself admits it is no substitute for a plan. |
| `humanizer` | Redundant with the owner's vault skill `/brain:de-ai-ify`, which is tuned finer to the owner's voice. |
| `jq` | Static cheat-sheet; the model already knows jq. Dead weight. |
| `obsidian-markdown` | Redundant with the owner's vault CLAUDE.md wikilink/PARA conventions exactly where it would be used; the `lars-para` profile does not belong in a shared skill. |

Kept in the same pass: `spike` (authored), `mermaid-diagram-specialist`,
`changelog-skill`, `security-auditor`, `repomix` (CLI installed + live-tested),
plus the `taches-toolkit` bundle.

### Recovery

```bash
# find the last commit that still had the skill
git log --all --diff-filter=D --oneline -- skills/<name>
# restore it from the commit before deletion
git checkout <sha>^ -- skills/<name>
```

Upstream sources for each removed skill are in the git history of
`THIRD_PARTY_LICENSES.md` (before this pivot).
