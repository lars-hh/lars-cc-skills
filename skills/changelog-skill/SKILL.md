---
name: changelog-skill
description: |
  Generate or update CHANGELOG.md following Keep a Changelog 1.1.0 and Semantic
  Versioning. Use when recording changes for a software release, moving
  Unreleased entries into a versioned section, setting up a new CHANGELOG.md
  from scratch, or auditing whether an existing changelog matches the
  Keep-a-Changelog conventions (Added / Changed / Deprecated / Removed /
  Fixed / Security categories).
license: Apache-2.0
metadata:
  author: Yulong Ming <i@myl7.org>
---

Follow [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/).

## Template

```md
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-01-01

### Added

- New feature description.

### Changed

- Existing behavior modification.

### Deprecated

- Feature to be removed in future.

### Removed

- Previously deprecated feature now gone.

### Fixed

- Bug fix description.

### Security

- Vulnerability fix description.

[Unreleased]: https://github.com/user/repo/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/user/repo/releases/tag/v1.0.0
```

## Rules

- File name: `CHANGELOG.md`.
- Versions in reverse chronological order (latest first).
- Dates in ISO 8601 format (`YYYY-MM-DD`).
- Always keep an `[Unreleased]` section at the top for upcoming changes.
- Each version and section must be linkable. Add comparison links at the bottom.
- Yanked releases: append `[YANKED]` after the date, e.g., `## [1.0.1] - 2026-02-01 [YANKED]`.
- Only include sections that have entries. Omit empty sections.
- One entry per line. Start with a capital letter and end with a period.
- Write for humans, not machines. Do not dump git log.

## Change Types

Use only these six types as `###` headings, in this order:

| Type | When |
|------|------|
| Added | New features |
| Changed | Changes in existing functionality |
| Deprecated | Soon-to-be-removed features |
| Removed | Now-removed features |
| Fixed | Bug fixes |
| Security | Vulnerability fixes |

## When Releasing

Move entries from `[Unreleased]` into a new version section with today's date.
Update the comparison links at the bottom of the file.
