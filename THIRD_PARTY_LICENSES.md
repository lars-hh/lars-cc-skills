# Third-Party Licenses and Attribution

This file lists the original sources, authors, and licenses of every third-party skill in the `skills/` directory. Skills authored from scratch by the repo owner (`mode: authored` in their `origin.yaml`, e.g. `spike`) are not third-party and are not listed here.

For each skill, the upstream LICENSE file (where available) is preserved at `skills/<skill>/LICENSE`. Modifications made here are recorded in `skills/<skill>/origin.yaml` under `divergence_notes:`.

## Skills

### repomix

- **Upstream:** [yamadashy/repomix](https://github.com/yamadashy/repomix) — this is a CLI tool, not a Claude Code skill. The upstream LICENSE is shipped verbatim under `skills/repomix/LICENSE`.
- **License:** MIT (LICENSE copyright: 2024 Kazuki Yamada)
- **Author:** Kazuki Yamada ([@yamadashy](https://github.com/yamadashy))
- **Upstream commit pinned:** `fabc367d329e65ef5d6afb8edb4d141801efaf26` (2026-05-19, 25,088 stars)
- **This marketplace:** **Wrapper SKILL.md** — there is no upstream SKILL.md to copy. This marketplace ships a `SKILL.md` that documents the CLI's installation, common flags, when-to-use guidance, and `allowed-tools` declaration. Users must install the CLI separately (`brew install repomix` or `npm install -g repomix`).

### security-auditor

- **Upstream:** [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills), path `engineering/skills/skill-security-auditor/` (SKILL.md + `references/threat-model.md` + `scripts/skill_security_auditor.py`)
- **License:** MIT (LICENSE copyright: "2025 Alirezarezvani")
- **Author:** Alireza Rezvani (alirezarezvani) — original author, not a redistributor. Confirmed via commit history (`1851c8fb` 2026-05-02 authored by Reza Rezvani).
- **Upstream commit pinned:** `6bf737fb4aee65ed187a8a64b311e32fead2ff05` (2026-05-19)
- **This marketplace:** Refined — renamed `name:` to `security-auditor` for marketplace plugin parity, added `version: 1.0.0` + `license: MIT` to frontmatter, extended description with marketplace-compliance use case, added new section "Marketplace Compliance Mode" documenting three checks (LICENSE present + SPDX allowlist, allowed-tools whitelist discipline, frontmatter schema), added new wrapper script `scripts/marketplace_audit.sh` (~170 LOC bash + embedded python3) supporting per-skill, `--all`, and `--with-security` modes. Upstream Python scanner and threat-model reference preserved verbatim.

### mermaid-diagram-specialist

- **Upstream:** [davila7/claude-code-templates](https://github.com/davila7/claude-code-templates), path `cli-tool/components/skills/creative-design/mermaid-diagrams/` (SKILL.md + 6 reference files in `references/`)
- **License:** MIT (LICENSE copyright per davila7's repo-level LICENSE)
- **Author:** davila7 (Daniel Avila, [@davila7](https://github.com/davila7)). The upstream SKILL.md header carries no separate original-author attribution, and `gh search repos "mermaid-diagram-specialist skill"` surfaced no dedicated upstream — davila7 is the best-available source.
- **Upstream commit pinned:** `2b558d59d7482aa0e94a53d72a6b9d0e465a5fc3` (2026-05-19)
- **This marketplace:** Vanilla with one allowed frontmatter rename — `name: mermaid-diagrams → name: mermaid-diagram-specialist` to match the plugin name in marketplace.json. Body verbatim. 6 reference files (`advanced-features.md`, `c4-diagrams.md`, `class-diagrams.md`, `erd-diagrams.md`, `flowcharts.md`, `sequence-diagrams.md`) imported verbatim into `skills/mermaid-diagram-specialist/references/`.

### changelog-skill

- **Upstream:** [myl7/changelog-skill](https://github.com/myl7/changelog-skill), path `changelog/SKILL.md`
- **License:** Apache-2.0 — upstream ships it as `LICENSE.txt`; this marketplace copies it verbatim as `skills/changelog-skill/LICENSE` so the repo's `audit-license.sh` finds it without a glob change. **No NOTICE file** in upstream (verified 2026-05-19), so no NOTICE preservation is required.
- **Author:** Yulong Ming ([@myl7](https://github.com/myl7)) — i@myl7.org. Original author, not a redistributor.
- **Upstream commit pinned:** `fb04aa89c0b771fece60d77f3703b9ef1885f26b` (last upstream activity 2026-04-14)
- **This marketplace:** Minimal-vanilla — single allowed change is the frontmatter rename `name: changelog` → `name: changelog-skill` to match the plugin name in `marketplace.json`. Body is verbatim. Replaces the originally-considered `ComposioHQ/awesome-claude-skills/changelog-generator` (rejected 2026-05-19 because the upstream had `"license": null` at the repo level — see Lesson 7 in `marketplace-watchlist.md`).

### taches-toolkit (commands + agents bundle)

- **Upstream:** [glittercowboy/taches-cc-resources](https://github.com/glittercowboy/taches-cc-resources), paths `commands/*` + `agents/*`
- **License:** MIT (LICENSE copyright: 2025 Lex Christopherson)
- **Author:** Lex Christopherson ([@glittercowboy](https://github.com/glittercowboy))
- **Upstream commit pinned:** `0d915b80b95f9889673e1dc6a9059ed239764cde` (2026-06-23)
- **This marketplace:** Selective 1:1 as-is import of KEEP commands (16 top-level + consider/ 12) + 3 auditor agents. DROP: add-to-todos, check-todos, create-hook, research/* (8). Reshape deferred.

## How to verify attribution

Run `./scripts/verify-attribution.sh` to check that every third-party skill's `origin.yaml` matches the upstream SKILL.md header and that this file is consistent. Authored skills (`mode: authored`) are checked for an `original_author` only.

## How to report issues

If you find an attribution error, missing license file, or upstream source that has since gained a license, open an issue at https://github.com/lars-hh/lars-cc-skills/issues.
