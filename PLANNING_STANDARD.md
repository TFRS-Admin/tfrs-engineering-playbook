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

These are the same `S`/`M`/`L`/`XL` values used by the `Size` field in [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) — don't introduce a second sizing scale with different labels for the same concept.

Split further, regardless of the day-estimate above, when any of these is true:
- The work would take more than one focused implementation session.
- Acceptance criteria can't be stated in three or fewer Given/When/Then blocks.
- It touches two or more independent subsystems (frontend and a separate service, two unrelated modules).
- The title needs the word "and" to describe it — that's usually two tasks wearing one title.

An agent (or a human) performs best on `S` and `M` work; treat a task that keeps tripping these triggers as a signal the plan was under-scoped, not a reason to push through.

## When a Full Spec Is Required

Most issues need nothing beyond the acceptance criteria format below. Produce a fuller written plan — covering the problem statement, constraints, explicit assumptions, and a testing/verification approach — during [`commands/plan.md`](./commands/plan.md) when any of these apply:

- The work is sized `L` (or would be `XL` before splitting).
- Requirements are ambiguous or come from more than one stakeholder with potentially conflicting priorities.
- The work touches an architectural decision that should be recorded as an ADR (see [`templates/adr-template.md`](./templates/adr-template.md)).
- It's a new project or a significant, cross-cutting feature rather than a bounded fix.

For everything else — a typo fix, a single-line correction, an unambiguous small change — the lightweight issue anatomy below is the whole plan; don't manufacture process for a change that doesn't need it.

When producing a fuller plan, surface assumptions explicitly rather than silently picking one and moving on — state them as an `Assumptions:` block in the plan so a human can correct one before it's built into the implementation. If genuinely unclear which assumption is right, that's when to ask rather than proceed, per [`CLAUDE.md`](./CLAUDE.md#when-to-ask-vs-when-to-proceed).

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
