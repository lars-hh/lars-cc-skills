# Wikilinks — `lars-para` Mode

The `lars-para` mode adapts the `obsidian-markdown` skill to vaults that follow the PARA method (Projects, Areas, Resources, Archives) plus a few additional conventions for People, Daily notes, and capture inboxes. It is a preset, not a hard rule — when in doubt, ask the user to confirm a path.

## Activation

Set in skill frontmatter:

```yaml
---
wikilink_style: lars-para
---
```

Or via invocation flag: `--wikilink-style lars-para`.

When this mode is active, the skill suggests **path-prefixed** wikilinks (`[[People/felix-gessert]]`) instead of bare wikilinks (`[[Felix Gessert]]`).

## The 10 Path Patterns

| # | Type | Format | Example | Notes |
|---|------|--------|---------|-------|
| 1 | Person (Hub) | `[[People/vorname-nachname]]` | `[[People/felix-gessert]]` | Standard contact card. Slug is kebab-case of `vorname-nachname`. |
| 2 | Person (Profile) | `[[People/vorname-nachname/profil]]` | `[[People/felix-gessert/profil]]` | Hub-and-Spoke pattern. Use only when the deeper profile file exists at `People/vorname-nachname/profil.md`. |
| 3 | Project | `[[Projects/projektname]]` | `[[Projects/baur-deal]]` | Deals, partnerships, initiatives. Slug is kebab-case. |
| 4 | Note | `[[Notes/topic]]` | `[[Notes/schreibstil]]` | Knowledge note. Topic is kebab-case. |
| 5 | Daily | `[[Daily/YYYY-MM/YYYY-MM-DD]]` | `[[Daily/2026-05/2026-05-18]]` | Daily notes live in a monthly subfolder. Use ISO dates. |
| 6 | Resource | `[[Resources/resource-name]]` | `[[Resources/vault-docs]]` | Reference material, setup guides, look-up tables. |
| 7 | Area | `[[Areas/area-name]]` | `[[Areas/sales-pipeline]]` | Ongoing area of responsibility (PARA). |
| 8 | Brain (topic) | `[[brain/topic]]` | `[[brain/upcoming]]` | Internal topic file. Note the lowercase folder. These often back automation hooks — avoid linking from external-facing notes if the brain file is private. |
| 9 | Template | `[[Templates/template-name]]` | `[[Templates/daily]]` | Reusable templates. |
| 10 | Inbox capture | `[[Inbox/YYYY-MM/filename]]` | `[[Inbox/2026-05/meeting-claudia]]` | Routing target for unprocessed captures. Monthly subfolder. |

## Slug Rules

- Lowercase
- Spaces become hyphens
- Umlauts stay as UTF-8 (`ä`, `ö`, `ü`, `ß`) — **do not** transliterate to `ae`, `oe`, `ue`, `ss`
- Drop punctuation: `O'Brien` → `obrien`, `Müller-Schmidt` → `müller-schmidt`
- Names: `Vorname Nachname` → `vorname-nachname` (single hyphen)

## When to Pick Hub vs. Profile

For pattern #1 vs #2:

- **Default to the Hub** (`[[People/vorname-nachname]]`). It always exists if the person is in the vault.
- **Link to the Profile** (`[[People/vorname-nachname/profil]]`) only when:
  - You're explicitly referencing detailed analysis (communication style, deal history depth)
  - The user has asked for the "deep" link
  - You can verify `People/vorname-nachname/profil.md` exists (use Glob)

If unsure: link to the Hub. The Hub will itself link to the Profile via a header link.

## Custom-Mode Override

If the user has `wikilink_style: custom` in the note's frontmatter, load `~/.config/obsidian-markdown/wikilinks.yml`. Custom patterns override the `lars-para` defaults item-by-item:

```yaml
# Example ~/.config/obsidian-markdown/wikilinks.yml
patterns:
  Person: "[[Contacts/{slug}]]"             # overrides #1
  Project: "[[Deals/{slug}]]"               # overrides #3
  Daily: "[[Journal/{yyyy}-{mm}-{dd}]]"     # overrides #5
  # ... missing patterns fall back to lars-para
```

If the config is malformed or missing required keys, fall back silently to the `lars-para` default for that pattern and add a `<!-- humanizer-note: custom pattern X missing, fell back to lars-para -->` HTML comment near the affected wikilink.

## What This Mode Does NOT Do

- It does not auto-create missing files. If a wikilink target doesn't exist, the link still works in Obsidian (creates an unresolved link on click).
- It does not enforce uniqueness. If two People entries collide on slug, ask the user to disambiguate.
- It does not validate against a vault index. Slug suggestions are based on convention, not on a Glob of existing files (use `Glob` separately if verification matters).

## Origin

This mode was added as a refinement to the upstream `obsidian-markdown` skill (`SpreMars/obsidian-markdown-skill`) for use in `lars-hh/lars-cc-skills`. The conventions match Lars Nowak's Second Brain vault structure (PARA + Hub-and-Spoke People + monthly Daily/Inbox subfolders).

Other vaults can adopt this preset wholesale or override individual patterns via `wikilink_style: custom`.
