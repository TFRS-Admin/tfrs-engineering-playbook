<!-- Purpose: Production-ready template for the standard unit of executable work — a Story or Task issue. -->
# Engineering Task Template

Copy this into a new GitHub issue when creating a Story/Task from an approved plan (see [`commands/plan.md`](../commands/plan.md) and [`commands/backlog.md`](../commands/backlog.md)). The `## Metadata`, `## Acceptance Criteria`, `## Verification`, and `## Dependencies` sections are required per [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md) — this issue body, not a GitHub Project, is authoritative for this issue's state.

---

## Title

`Add server-side contact form validation`

## Origin

Plan derived from review finding #1 on `tfrs-website`, part of Epic #142 ("Harden tfrs-website form and content pipeline").

## Problem Statement

The contact form endpoint accepts submissions with missing or malformed required fields because validation is enforced only in the client.

## Implementation Notes

- Reuse the existing client-side validation rules (`src/lib/contactFormRules.js`) as the source of truth for server-side rules rather than redefining them.
- Validation errors should use the same field-level error shape already used elsewhere in the API (see `src/api/errors.js`).

## Out of Scope

Redesigning the form UI, adding new fields, or changing the storage backend.

## Metadata

Status: Ready
Priority: P1
Risk: Medium
Size: S
Epic: #142
Sprint: Q3 Sprint 1
Blocked: No
QA Required: Yes
Agent Persona: Implementer

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

[`PLANNING_STANDARD.md`](../PLANNING_STANDARD.md) · [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md) · [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md) · [`commands/execute.md`](../commands/execute.md)
