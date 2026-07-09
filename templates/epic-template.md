<!-- Purpose: Production-ready template for Epic issues that group related stories and tasks under one initiative. -->
# Epic Template

Copy this into a new GitHub issue when creating an Epic. An Epic is never directly executed — it groups and sequences the Story/Task issues that are.

---

## Title

`Epic: Harden tfrs-website form and content pipeline`

## Origin

Roadmap item from Q3 planning, tracing to review findings #1-#3 on the `tfrs-website` contact form and content pipeline (see [`commands/review.md`](../commands/review.md)).

## Problem Statement

The `tfrs-website` contact form accepts invalid submissions past client-side validation, page metadata is hand-maintained per page with no shared source, and CI has no automated accessibility check. Each is individually low-risk but together represent accumulating drift in the site's content pipeline.

## Outcome

Contact form submissions are validated server-side, page metadata is generated from a single shared source, and CI blocks merges that introduce accessibility regressions.

## Scope

**In scope:**
- Server-side contact form validation
- Shared page-metadata source
- CI accessibility check

**Out of scope:**
- Redesigning the contact form UI
- Migrating to a different metadata/CMS system

## Child Issues

- [ ] #143 — Add server-side contact form validation
- [ ] #144 — Add integration tests for contact form validation boundary
- [ ] #145 — Introduce shared page-metadata source
- [ ] #146 — Add automated accessibility check to CI

## Required Project Fields

| Field | Value |
| --- | --- |
| Status | Backlog |
| Phase | Backlog |
| Priority | P1 |
| Risk | Medium |
| Size | L |
| Sprint | Q3 Sprint 1-2 |
| Epic | (this issue) |
| QA Required | Yes |
| Blocked | No |
| Agent Persona | Planner |

## Definition of Done

All child issues are closed with passing verification reports, and the outcome statement above is demonstrably true in production.

## Related Documents

[`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) · [`commands/backlog.md`](../commands/backlog.md) · [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md)
