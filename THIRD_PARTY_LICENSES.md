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

- **Upstream:** [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills)
- **License:** MIT (TBD — verify at import)
- **Author:** alirezarezvani (verify original skill author in SKILL.md header)
- **This marketplace:** Refined for marketplace-specific audits (LICENSE-file check, bash-whitelist, frontmatter schema)

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
- **License:** MIT (declared in plugin manifest; upstream LICENSE file pending — see GitHub issue/PR if filed)
- **Authors:** Jiayuan Zhang (forrestchang7) and Andriy Zakharko, Shehab Tarek. Inspired by Andrej Karpathy's public tweets on LLM coding pitfalls (see [X-post, 2026-01-26](https://x.com/karpathy/status/2015883857489522876)). **Not authored by Karpathy.**
- **This marketplace:** Refined — owner attribution corrected, Karpathy clearly labelled as inspiration source not author.

### humanizer

- **Upstream:** [davila7/claude-code-templates](https://github.com/davila7/claude-code-templates), path `cli-tool/components/skills/productivity/humanizer/SKILL.md`
- **Original author:** @blader (davila7 is redistributor — verify in SKILL.md header at import)
- **License:** MIT
- **This marketplace:** Refined — added German-language variant with German AI-writing patterns and Lars-specific anti-tells whitelist

### obsidian-markdown

- **Upstream:** [davila7/claude-code-templates](https://github.com/davila7/claude-code-templates), path `cli-tool/components/skills/document-processing/obsidian-markdown/SKILL.md`
- **License:** MIT
- **Author:** davila7 is redistributor; verify original author at import
- **This marketplace:** Refined — added configurable wikilink convention (`lars-para`, `generic`, `custom` modes)

### jq

- **Upstream:** [majiayu000/claude-skill-registry](https://github.com/majiayu000/claude-skill-registry), path `skills/data/jq/SKILL.md`
- **License:** MIT
- **Author:** majiayu000
- **This marketplace:** Vanilla

## How to verify attribution

Run `./scripts/verify-attribution.sh` to check that every skill's `origin.yaml` matches the upstream SKILL.md header and that this file is consistent.

## How to report issues

If you find an attribution error, missing license file, or upstream source that has since gained a license (e.g., ComposioHQ may add one later), open an issue at https://github.com/lars-hh/lars-cc-skills/issues.
