<!-- Purpose: Executable procedure for turning an approved finding, roadmap item, or issue into an implementation strategy. -->
# Command: Plan

## Purpose

Turn an approved review finding, roadmap Epic, or raw issue into a concrete implementation strategy: broken into sized tasks, with testable acceptance criteria, risks, and a PR breakdown. Planning produces the strategy; it does not produce code and it does not produce GitHub issues — that's [`commands/backlog.md`](./backlog.md).

## When to Use It

- Immediately after a finding is approved for action (from [`commands/review.md`](./review.md)).
- When breaking a roadmap Epic (from [`commands/roadmap.md`](./roadmap.md)) into its component stories/tasks.
- Any time an issue is created directly without having gone through review, and needs a strategy before it can enter the backlog.

## Required Inputs

- The finding, Epic, or issue being planned.
- A draft or existing acceptance criteria if one exists.
- Relevant constraints (deadlines, architecture limits, prior ADRs).
- Related findings that should inform sequencing or risk.

## Required Skill Consultation

Mandatory per [`SKILLS_STANDARD.md#when-consultation-is-mandatory`](../SKILLS_STANDARD.md#when-consultation-is-mandatory): consult [`skills/planning-and-task-breakdown`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/planning-and-task-breakdown) for task-decomposition mechanics, and [`skills/spec-driven-development`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/spec-driven-development) when [`PLANNING_STANDARD.md#when-a-full-spec-is-required`](../PLANNING_STANDARD.md#when-a-full-spec-is-required) triggers a fuller plan.

## Workflow

1. Read [`PLANNING_STANDARD.md`](../PLANNING_STANDARD.md) for issue anatomy, sizing, and acceptance criteria format.
2. Restate the problem in one sentence — if you cannot, the input isn't ready for planning; send it back to `Review`.
3. Check whether this work meets any trigger in [`PLANNING_STANDARD.md`](../PLANNING_STANDARD.md#when-a-full-spec-is-required); if so, produce the fuller plan described there (including an explicit `Assumptions:` block) rather than just a task list.
4. Break the work into stories/tasks, each independently sized `S`/`M`/`L` (split anything that would be `XL`, and split further if it trips any of the finer-grained triggers in [`PLANNING_STANDARD.md`](../PLANNING_STANDARD.md#estimation-approach)).
5. Write acceptance criteria for each task in Given/When/Then form.
6. Identify risks and unknowns explicitly — do not fold them silently into the estimate. For anything `Risk: High` or `Risk: Critical`, note that [`commands/backlog.md`](./backlog.md) will require the Threat Model First step from [`SECURITY_STANDARD.md`](../SECURITY_STANDARD.md).
7. Identify dependencies between the tasks you just created, and between this work and anything else in flight.
8. Propose a PR breakdown: which tasks can ship as independent PRs, and which are tightly coupled and must land together.
9. Do not begin implementation. The output of this command is a strategy document, not a branch.

## Required Outputs

- A task breakdown (list of stories/tasks with size, acceptance criteria, and dependencies) ready to be handed to [`commands/backlog.md`](./backlog.md) for GitHub issue generation.
- A risk list.
- A proposed PR breakdown / sequencing.

## Quality Gates

- Every task has acceptance criteria that could be verified by someone who did not write the plan.
- Every task is sized `S`, `M`, or `L` — nothing `XL` is passed downstream unsplit.
- Dependencies between tasks are stated explicitly, not left implicit in ordering.
- No code, branch, or commit exists as a result of this command.

## Failure Handling

- **Input is too vague to plan** (no clear problem statement, no acceptance criteria draft): send back to [`commands/review.md`](./review.md) or ask the human for clarification — do not guess at scope.
- **Input is too large to plan as one unit**: split it into multiple plan passes, one per natural sub-problem, rather than producing one unmanageable task list.
- **A dependency on work outside this plan's scope is discovered**: name the dependency explicitly rather than assuming it will resolve itself.

## Example

**Input:**
> Finding: contact form validation is client-side only (see review example in `commands/review.md`).

**Output (excerpt):**
```text
Problem: Server-side validation is missing on the contact form endpoint,
allowing invalid submissions to bypass client-side checks.

Tasks:
  1. [S] Add server-side validation matching existing client-side rules.
     Given a POST to /api/contact with a missing required field
     When the request is processed
     Then the API returns a 400 with a field-level error message
  2. [S] Add integration test coverage for the validation boundary.
     Given the server-side validation from task 1
     When invalid and valid payloads are submitted
     Then the response status and body match the expected contract

Risks: none blocking; low risk, no dependency on other in-flight work.

PR breakdown: tasks 1 and 2 ship together in one PR — validation without
test coverage is not verifiable.
```
