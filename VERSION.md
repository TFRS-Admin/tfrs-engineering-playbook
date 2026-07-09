<!-- Purpose: Track the current playbook version and explain how change levels are versioned. -->
# TFRS Engineering Playbook Version

## Current Version

**1.0.0**

## Versioning Rules

- **Major**: breaking standard change that requires downstream repositories to adjust how they work
- **Minor**: new section, template, or standard capability that is backwards compatible
- **Patch**: clarification, typo fix, or low-risk improvement to existing guidance

## Changelog Format

Record changes using this format:

```text
## <version> - <YYYY-MM-DD>
- Type: major | minor | patch
- Summary: short description of the playbook change
- Impact: what downstream repositories should do next
```

## Changelog

## 1.0.0 - 2026-07-09
- Type: major
- Summary: Initial canonical scaffold for the TFRS engineering playbook repository.
- Impact: Downstream repositories can now adopt a shared set of AI, planning, review, execution, and GitHub standards.
