<!-- Purpose: Seed docs/engineering/ROADMAP.md — where sequenced Epics live as sections, and the only place an Epic's own detail (problem statement, scope, child work items) is recorded. -->
# Engineering Roadmap Template

Copy this to `docs/engineering/ROADMAP.md` at the repository root. This file is where Epics live — an Epic is a section here, never its own file. [`commands/roadmap.md`](../commands/roadmap.md) writes the summary table and sequencing directly; [`commands/backlog.md`](../commands/backlog.md) adds/updates an Epic's own section when work-item files are generated under it.

---

# Roadmap: tfrs-website

## Current Window

Q3 2026 — capacity: 2 Epics.

## Sequenced Epics

| Order | Epic | Origin | Size | Priority | Dependencies |
| --- | --- | --- | --- | --- | --- |
| 1 | Harden tfrs-website form and content pipeline | Review findings #1-#3 | M | P1 | None |
| 2 | Add pricing calculator page | Business ask | L | P1 | None |

## Epic: Harden tfrs-website form and content pipeline

**Origin:** Review findings #1-#3 on the `tfrs-website` contact form and content pipeline.

**Problem Statement:** The contact form accepts invalid submissions past client-side validation, and page metadata is hand-maintained per page with no shared source.

**Outcome:** Contact form submissions are validated server-side, and page metadata is generated from a single shared source.

**Scope:**
- In: server-side contact form validation, shared page-metadata source.
- Out: redesigning the contact form UI, migrating to a different metadata/CMS system.

**Child work items:**
- `docs/engineering/backlog/FORM-01-add-server-side-contact-form-validation.md`
- `docs/engineering/backlog/FORM-02-add-contact-form-validation-tests.md`

**Status:** In Progress (tracked at the Epic level as a rollup of its child items' `Status` fields — not a separate field to keep in sync by hand).

## Deferred

None this quarter — both candidates fit stated capacity.

## Last Updated

2026-07-09, by [`commands/roadmap.md`](../commands/roadmap.md).

## Related Documents

[`commands/roadmap.md`](../commands/roadmap.md) · sibling `docs/engineering/backlog/` · [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) · [`WORK_ITEM_METADATA_STANDARD.md`](../WORK_ITEM_METADATA_STANDARD.md)
