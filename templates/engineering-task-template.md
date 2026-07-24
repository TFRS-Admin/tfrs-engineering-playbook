<!-- Purpose: Production-ready template for the one work-item shape — feature, bug, chore, or technical debt alike. -->
# Work Item Template

Copy this into a new file at `docs/engineering/backlog/<EPIC>-<NN>-<kebab-slug>.md` when creating a work item from an approved plan (see [`commands/plan.md`](../commands/plan.md) and [`commands/backlog.md`](../commands/backlog.md)). The `## Metadata`, `## Acceptance Criteria`, `## Verification`, and `## Dependencies` sections are required per [`WORK_ITEM_METADATA_STANDARD.md`](../WORK_ITEM_METADATA_STANDARD.md) — this file, not a GitHub Issue, is authoritative for this item's state.

This is the one template for every kind of work item. A technical-debt item discovered during review or a health-checklist pass uses the same shape — lead the title with `Tech Debt:` (or `Feature:`/`Bug:`/`Chore:`) so the kind of work is legible at a glance; there is no separate `Type` field.

---

## Title

`Add server-side contact form validation`

## Origin

Plan derived from review finding #1 on `tfrs-website`, part of the "Harden tfrs-website form and content pipeline" Epic in `docs/engineering/ROADMAP.md`.

## Problem Statement

The contact form endpoint accepts submissions with missing or malformed required fields because validation is enforced only in the client. (For a technical-debt item, this section is where the current state and why it matters go — e.g. "four dependencies are two or more major versions behind, one of them end-of-life with no further security patches.")

## Implementation Notes

- Reuse the existing client-side validation rules (`src/lib/contactFormRules.ts`) as the source of truth for server-side rules rather than redefining them.
- Validation errors should use the same field-level error shape already used elsewhere in the API (see `src/api/errors.ts`).

## Out of Scope

Redesigning the form UI, adding new fields, or changing the storage backend.

## Metadata

Status: Ready
Priority: P1
Risk: Medium
Size: S
Epic: Harden tfrs-website form and content pipeline
Blocked: No
QA Required: Yes

## Acceptance Criteria

```text
Given a POST to /api/contact with a missing required field
When the request is processed
Then the API returns a 400 with a field-level error message

Given a POST to /api/contact with all required fields present and valid
When the request is processed
Then the API returns a 200 and the submission is stored
```

## Verification

Planned: automated integration test covering both acceptance criteria, run via [`commands/verify.md`](../commands/verify.md) before the PR is marked ready for review. (Filled in with actual results once verification runs.)

## Dependencies

None.

## Related Documents

[`WORK_ITEM_METADATA_STANDARD.md`](../WORK_ITEM_METADATA_STANDARD.md) · [`RULESET.md`](../RULESET.md) · [`commands/execute.md`](../commands/execute.md)
