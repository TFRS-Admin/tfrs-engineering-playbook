<!-- Purpose: Production-ready template for the standard unit of executable work — a Story or Task issue. -->
# Engineering Task Template

Copy this into a new GitHub issue when creating a Story/Task from an approved plan (see [`commands/plan.md`](../commands/plan.md) and [`commands/backlog.md`](../commands/backlog.md)).

---

## Title

`Add server-side contact form validation`

## Origin

Plan derived from review finding #1 on `tfrs-website`, part of Epic #142 ("Harden tfrs-website form and content pipeline").

## Problem Statement

The contact form endpoint accepts submissions with missing or malformed required fields because validation is enforced only in the client.

## Acceptance Criteria

```text
Given a POST to /api/contact with a missing required field
When the request is processed
Then the API returns a 400 with a field-level error message

Given a POST to /api/contact with all required fields present and valid
When the request is processed
Then the API returns a 200 and the submission is stored
```

## Implementation Notes

- Reuse the existing client-side validation rules (`src/lib/contactFormRules.js`) as the source of truth for server-side rules rather than redefining them.
- Validation errors should use the same field-level error shape already used elsewhere in the API (see `src/api/errors.js`).

## Out of Scope

Redesigning the form UI, adding new fields, or changing the storage backend.

## Required Project Fields

| Field | Value |
| --- | --- |
| Status | Ready |
| Phase | Backlog |
| Priority | P1 |
| Risk | Medium |
| Size | S |
| Sprint | Q3 Sprint 1 |
| Epic | #142 |
| QA Required | Yes |
| Blocked | No |
| Agent Persona | Implementer |

## Verification Plan

Automated integration test covering both acceptance criteria, run via [`commands/verify.md`](../commands/verify.md) before the PR is marked ready for review.

## Related Documents

[`PLANNING_STANDARD.md`](../PLANNING_STANDARD.md) · [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md) · [`commands/execute.md`](../commands/execute.md)
