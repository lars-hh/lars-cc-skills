# Third-Party Licenses and Attribution

This file lists the original sources, authors, and licenses of every skill in the `skills/` directory.

For each skill, the upstream LICENSE file (where available) is preserved at `skills/<skill>/LICENSE`. Modifications made by this marketplace are recorded in `skills/<skill>/origin.yaml` under `divergence_notes:`.

## Skills

### caveman

- **Upstream:** [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman), path `plugins/caveman/skills/caveman/SKILL.md`
- **License:** MIT (LICENSE copyright: JuliusBrussee)
- **Author:** Julius Brussee ([@JuliusBrussee](https://github.com/JuliusBrussee))
- **Upstream commit pinned:** `18e45320a0b1aecc959a807f8568ee44b3aaa055` (2026-05-19, 62,078 stars)
- **This marketplace:** Vanilla (body and frontmatter verbatim from upstream; `name: caveman` already matches the plugin name in marketplace.json — no rename needed).

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
- **License:** MIT (LICENSE copyright per majiayu000's repo-level LICENSE)
- **Author:** Jiayu Ma ([@majiayu000](https://github.com/majiayu000)) — original author, the repo is a `claude-skill-registry` collection (registry-style, not aggregator-style).
- **Upstream commit pinned:** `fa3abd30d36ee95c5b42d257edb9e814847ccd4b` (2026-05-19, 310 stars)
- **Bus-Factor risk:** Medium — 310 stars. `fallback_source: lanej/dotfiles` documented in origin.yaml as an ideas source, but its own LICENSE has not been verified — would need a separate check before adoption.
- **This marketplace:** Vanilla (body and frontmatter verbatim from upstream; `name: jq` already matches the plugin name in marketplace.json — no rename needed).

## How to verify attribution

Run `./scripts/verify-attribution.sh` to check that every skill's `origin.yaml` matches the upstream SKILL.md header and that this file is consistent.

## How to report issues

If you find an attribution error, missing license file, or upstream source that has since gained a license (e.g., ComposioHQ may add one later), open an issue at https://github.com/lars-hh/lars-cc-skills/issues.
