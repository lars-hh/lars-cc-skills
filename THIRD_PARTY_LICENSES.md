# Third-Party Licenses and Attribution

This file lists the original sources, authors, and licenses of every skill in the `skills/` directory.

For each skill, the upstream LICENSE file (where available) is preserved at `skills/<skill>/LICENSE`. Modifications made by this marketplace are recorded in `skills/<skill>/origin.yaml` under `divergence_notes:`.

## Skills

### caveman

- **Upstream:** [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman)
- **License:** MIT (TBD — verify at import)
- **Author:** JuliusBrussee
- **This marketplace:** Vanilla

### repomix

- **Upstream:** [yamadashy/repomix](https://github.com/yamadashy/repomix)
- **License:** MIT (TBD — verify at import)
- **Author:** yamadashy
- **This marketplace:** Vanilla wrapper around the `repomix` CLI

### security-auditor

- **Upstream:** [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills), path `engineering/skills/skill-security-auditor/` (SKILL.md + `references/threat-model.md` + `scripts/skill_security_auditor.py`)
- **License:** MIT (LICENSE copyright: "2025 Alirezarezvani")
- **Author:** Alireza Rezvani (alirezarezvani) — original author, not a redistributor. Confirmed via commit history (`1851c8fb` 2026-05-02 authored by Reza Rezvani).
- **Upstream commit pinned:** `6bf737fb4aee65ed187a8a64b311e32fead2ff05` (2026-05-19)
- **This marketplace:** Refined — renamed `name:` to `security-auditor` for marketplace plugin parity, added `version: 1.0.0` + `license: MIT` to frontmatter, extended description with marketplace-compliance use case, added new section "Marketplace Compliance Mode" documenting three checks (LICENSE present + SPDX allowlist, allowed-tools whitelist discipline, frontmatter schema), added new wrapper script `scripts/marketplace_audit.sh` (~170 LOC bash + embedded python3) supporting per-skill, `--all`, and `--with-security` modes. Upstream Python scanner and threat-model reference preserved verbatim.

### mermaid-diagram-specialist

- **Upstream:** [davila7/claude-code-templates](https://github.com/davila7/claude-code-templates), path `cli-tool/components/skills/development/mermaid-diagram-specialist/SKILL.md`
- **License:** MIT
- **Author:** davila7 is the redistributor; verify original author in SKILL.md header at import
- **This marketplace:** Vanilla

### changelog-skill

- **Upstream:** [myl7/changelog-skill](https://github.com/myl7/changelog-skill)
- **License:** Apache-2.0 (NOTICE file preserved at `skills/changelog-skill/NOTICE` if upstream has one)
- **Author:** myl7
- **This marketplace:** Vanilla. Replaces the originally-considered `ComposioHQ/awesome-claude-skills/changelog-generator` which had no license.

### karpathy-skills

- **Upstream:** [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills), path `skills/karpathy-guidelines/SKILL.md`
- **License:** MIT — declared in `.claude-plugin/plugin.json` manifest. Upstream LICENSE file is missing; this marketplace ships a locally-reconstructed LICENSE in `skills/karpathy-skills/LICENSE` with a header comment naming the gap. A follow-up upstream PR to multica-ai is tracked as a Lars-action in `skills/karpathy-skills/origin.yaml notes`.
- **Authors:** Jiayuan Zhang ([@forrestchang](https://github.com/forrestchang)) and contributors under the [multica-ai](https://github.com/multica-ai) org (co-commits from Shehab Tarek, Andriy Zakharko). Inspired by Andrej Karpathy's public X-post on LLM coding pitfalls ([X-post, 2026-01-26](https://x.com/karpathy/status/2015883857489522876)). **Not authored by Karpathy himself.**
- **Upstream commit pinned:** `2c606141936f1eeef17fa3043a72095b4765b9c2` (2026-05-19)
- **This marketplace:** Refined — frontmatter `name` corrected from `karpathy-guidelines` to `karpathy-skills` (removes the "official Karpathy guidelines" ambiguity), added version/license/allowed-tools/refined description, new "Source & attribution" section explicitly correcting the community mis-attribution, new "When to use this skill" framing, new "Relation to other goal-driven frameworks" section bounding Principle 4 against GSD and Superpowers. All four principles preserved verbatim.

### humanizer

- **Upstream:** [davila7/claude-code-templates](https://github.com/davila7/claude-code-templates), path `cli-tool/components/skills/productivity/humanizer/SKILL.md`
- **Original author:** @blader (davila7 is redistributor — verify in SKILL.md header at import)
- **License:** MIT
- **This marketplace:** Refined — added German-language variant with German AI-writing patterns and Lars-specific anti-tells whitelist

### obsidian-markdown

- **Upstream:** [SpreMars/obsidian-markdown-skill](https://github.com/SpreMars/obsidian-markdown-skill), path `SKILL.md` + 3 reference files (`CALLOUTS.md`, `EMBEDS.md`, `PROPERTIES.md`)
- **License:** MIT (LICENSE-File copyright: "2026 Trae Skills Community" — Trae IDE community attribution; repo owner: SpreMars)
- **Author:** SpreMars (repo owner), Trae Skills Community (LICENSE-named)
- **Upstream commit pinned:** `bf17720d424917ce0753461694e3a6158cec3ebc` (2026-03-31)
- **Bus-Factor risk:** 0 stars at time of import; documented `fallback_source: davila7/claude-code-templates` redistribution as fallback if SpreMars goes stale.
- **This marketplace:** Refined — added Modes table (generic | lars-para | custom), frontmatter `wikilink_style` variable, `allowed-tools` declaration, new reference `WIKILINKS-LARS-PARA.md` documenting 10 PARA path patterns with slug rules. Upstream `SKILL.md` body and references (CALLOUTS, EMBEDS, PROPERTIES) preserved verbatim.

### jq

- **Upstream:** [majiayu000/claude-skill-registry](https://github.com/majiayu000/claude-skill-registry), path `skills/data/jq/SKILL.md`
- **License:** MIT
- **Author:** majiayu000
- **This marketplace:** Vanilla

## How to verify attribution

Run `./scripts/verify-attribution.sh` to check that every skill's `origin.yaml` matches the upstream SKILL.md header and that this file is consistent.

## How to report issues

If you find an attribution error, missing license file, or upstream source that has since gained a license (e.g., ComposioHQ may add one later), open an issue at https://github.com/lars-hh/lars-cc-skills/issues.
