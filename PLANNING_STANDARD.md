<!-- Purpose: Standardize how TFRS defines, sizes, and tracks work before implementation begins. -->
# TFRS Planning Standard

## Issue Anatomy

### Title Format

Use a concise title that leads with the work type:

- `Feature: add customer quote export`
- `Bug: fix duplicate inventory sync`
- `Docs: clarify onboarding checklist`
- `Chore: align lint workflow`

### Required Fields

Every issue should include:

- Problem statement
- Desired outcome
- Acceptance criteria
- Priority or urgency
- Dependencies or blockers
- Owner or next responsible person

### Labels

At minimum, classify work with a type label and a priority label. Align these labels with [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md).

## Epic vs. Story vs. Task

- **Epic:** a multi-PR outcome with several related stories.
- **Story:** a user- or workflow-centered deliverable that can often ship in one PR.
- **Task:** a narrow implementation or maintenance step that supports a story.

## Estimation Approach

Estimate using lightweight relative sizing:

- **S**: can likely ship in a day
- **M**: 2 to 3 days of focused work
- **L**: up to one sprint and probably needs breakdown
- **XL**: too large; split before work starts

## Acceptance Criteria Format

Write acceptance criteria in **Given / When / Then** form whenever behavior matters.

```text
Given a repository without AGENTS.md
When the setup checklist is followed
Then the repository adopts the baseline AI workflow files and references the playbook
```

## Linking Issues to Project Boards

Every active issue should be linked to the relevant GitHub Project item so status, priority, sprint, and reviewer state stay visible in one place.

## From Plan to Backlog

A plan produced against this standard is not yet executable work — it becomes executable when it is converted into GitHub issues with dependencies and execution order set. That conversion is defined in [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md). The executable, step-by-step version of the planning process described in this document is [`commands/plan.md`](./commands/plan.md).

## Related Documents

- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) — what happens after a plan is approved
- [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) — field definitions referenced by issue labels and sizing
- [`commands/plan.md`](./commands/plan.md) — executable procedure
