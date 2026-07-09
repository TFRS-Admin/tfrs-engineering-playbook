<!-- Purpose: Define the canonical procedure for converting review findings and plans into GitHub execution artifacts. -->
# TFRS Backlog Standard

## Purpose

This document defines the phase that closes the historical gap in the TFRS lifecycle:

```text
Review → Plan → Backlog → Execute
```

Review produces findings. Planning produces an implementation strategy. Neither is executable work until it exists as tracked, prioritized, dependency-ordered GitHub issues, each carrying a complete `## Metadata` block, and reflected in the repository's own `docs/engineering/` documentation. **Backlog is the phase that performs that conversion.** Nothing moves to `Execute` (see [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md)) without first passing through this phase. No GitHub Project is required for any of this.

This is the canonical guide for turning planning artifacts into GitHub execution. The executable, step-by-step version of this standard — written as a prompt an AI agent can run directly — is [`commands/backlog.md`](./commands/backlog.md).

## Guiding Principle

> Repository-local documentation and GitHub Issues are the operational source of truth. Chat is temporary. GitHub Projects are optional visualization. Reviews create findings. Plans create implementation strategy. Backlog turns both into tracked issues and repository engineering documentation.

A finding or plan that only exists in a chat transcript or a document is not yet real work. It becomes real work the moment it is represented as an Epic or Issue with the `## Metadata` block defined in [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md), and reflected in `docs/engineering/BACKLOG.md` (and, where relevant, `docs/engineering/ROADMAP.md` and `docs/engineering/CURRENT_SPRINT.md`). A GitHub Project, if a repository runs one, may mirror this for visualization — see [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) — but is never a required destination.

## Inputs to This Phase

- An approved plan from [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md), or
- A prioritized roadmap item (see [`commands/roadmap.md`](./commands/roadmap.md)), or
- A finding from [`commands/review.md`](./commands/review.md) that a human has approved for action, or
- A recurring finding from [`REPO_HEALTH_STANDARD.md`](./REPO_HEALTH_STANDARD.md)

Nothing enters the backlog phase without one of the above as its traceable origin. If work has no upstream artifact, run [`commands/review.md`](./commands/review.md) or [`commands/plan.md`](./commands/plan.md) first.

## Repository Readiness

Before generating issues, confirm the repository has the engineering documentation this phase writes to and reads from:

1. Confirm `docs/engineering/ROADMAP.md`, `docs/engineering/BACKLOG.md`, `docs/engineering/CURRENT_SPRINT.md`, and `docs/engineering/REPO_HEALTH.md` exist (create them from the templates in [`templates/README.md`](./templates/README.md#repository-engineering-docs) if this is a new repository or first adoption — see [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md)).
2. Confirm `.github/ISSUE_TEMPLATE/` issue templates already carry the `## Metadata` block from [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md), so every new issue starts with the right shape.
3. If a GitHub Project also exists for this repository, optionally confirm its fields per [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) — this step is never required to proceed.
4. If any required engineering doc is missing, create it before generating issues. Do not generate issues into a repository that has nowhere to record their backlog and sprint state.

## Issue Generation

Convert planning artifacts into issues using this decomposition order:

1. **Master Epic** — for a first backlog pass or a large multi-area initiative, one top-level Epic issue that groups the child Epics below, using [`templates/epic-template.md`](./templates/epic-template.md).
2. **Child Epics** — one Epic issue per roadmap initiative or large plan, using [`templates/epic-template.md`](./templates/epic-template.md), linked as sub-issues of the master Epic where one exists. An Epic is never directly executed; it exists to group and sequence stories/tasks.
3. **Stories and Tasks** — break each Epic into issues sized per [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md) (`S`/`M`/`L`; split anything estimated `XL` before it enters the backlog), using [`templates/engineering-task-template.md`](./templates/engineering-task-template.md).
4. **Technical debt** discovered during review that is out of scope for the current plan still gets an issue, using [`templates/technical-debt-template.md`](./templates/technical-debt-template.md), so it is not lost.
5. **Repository engineering documentation** — update `docs/engineering/BACKLOG.md` with the new Epics/issues, and `docs/engineering/ROADMAP.md` if a new initiative was introduced. This step is not optional: an issue hierarchy that exists only in GitHub with no corresponding entry in the repository's own docs is half-finished backlog work.

Every generated issue must include:

- A title following [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md) title format
- A complete `## Metadata` block per [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md) (no issue enters `Ready` with an empty required field)
- Acceptance criteria in Given/When/Then form, in the `## Acceptance Criteria` section
- Empty but present `## Verification` and `## Dependencies` sections
- A link back to the originating review, plan, or roadmap artifact

A GitHub Project, if one exists for the repository, may optionally mirror the resulting issue hierarchy per [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) — this is never required to consider backlog generation complete.

## Dependency Mapping

1. For every issue, identify what it is blocked by and what it blocks.
2. Represent dependencies using native issue relationships (sub-issues for Epic → Story/Task; "Blocked by #NNN" in the issue body for cross-issue dependencies) so the graph is visible in GitHub, not only in a planning document.
3. Set the `Blocked` field in the issue's `## Metadata` block to `Yes` on any issue with an open upstream dependency. Set it back to `No` the moment the blocking issue closes — do not leave stale blocks in the issue body.
4. An issue with unresolved dependencies does not move to `Ready`, regardless of priority.

## Execution Ordering

Order issues for execution using this precedence, in order:

1. **Unblocks the most other work** — an issue that several others depend on goes first even if its own priority is lower.
2. **Priority** (`P0` > `P1` > `P2` > `P3`).
3. **Risk** — prefer resolving `High`/`Critical` risk items earlier in a sprint so there is runway left to react if they slip.
4. **Size** — when priority and risk are equal, prefer smaller items first to keep throughput visible and reduce the cost of being wrong about scope.

Record the resulting order as the `Sprint` field assignment on each issue and the listed order in `docs/engineering/BACKLOG.md`'s `Ready` section. If a GitHub Project exists, its `Ready` view may mirror this order, but the repository doc is authoritative.

## Acceptance Criteria

Every issue's acceptance criteria must be written in Given/When/Then form per [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md#acceptance-criteria-format). An issue without testable acceptance criteria is not ready for backlog — send it back to `Plan`.

## Verification Expectations

Every issue must state, at backlog time, how it will be verified:

- Set `QA Required` to `Yes` for anything touching user-facing behavior, security boundaries, data integrity, or public APIs; `No` only for internal tooling, docs-only, or low-risk chores.
- Reference the verification approach (automated test, manual walkthrough, both) so [`commands/verify.md`](./commands/verify.md) has a defined target when the issue reaches implementation.
- An issue cannot move to `Done` without a completed [`templates/verification-report-template.md`](./templates/verification-report-template.md) when `QA Required` is `Yes`.

## Sprint Planning

1. Run backlog conversion and dependency mapping before each sprint planning session, not during it — sprint planning should be an ordering conversation, not a discovery conversation.
2. Assign the `Sprint` field to every issue entering the sprint, and update `docs/engineering/CURRENT_SPRINT.md` to list them — the file, not just the field, is what an agent reads to answer "what's in flight right now."
3. Cap sprint load using team-observed throughput, not aspiration; leave headroom for `Blocked`-flagged items to clear.
4. At sprint close, run [`templates/sprint-review-template.md`](./templates/sprint-review-template.md) to capture what shipped, what slipped, and what should feed back into the next `Review` or `Roadmap` pass — closing the loop described in [`AI_ENGINEERING_WORKFLOW.md`](./AI_ENGINEERING_WORKFLOW.md). Clear completed and carried-over items out of `docs/engineering/CURRENT_SPRINT.md` as part of this step.

## Initializing a Backlog From Scratch

When a repository has no existing backlog (new repository, or first adoption of this standard), use [`templates/backlog-initialization-template.md`](./templates/backlog-initialization-template.md) and the step-by-step procedure in [`commands/backlog.md`](./commands/backlog.md) rather than generating issues ad hoc. This always produces both the issue hierarchy (master Epic → child Epics → tasks) and the repository's `docs/engineering/` files — neither half is optional, and no GitHub Project is required for either.

## Related Documents

- [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md) — the Metadata block, field definitions, and allowed values every generated issue carries
- [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) — the optional dashboard a repository may mirror this backlog into
- [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md) — issue anatomy, sizing, acceptance criteria format
- [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md) — what happens once an issue leaves the backlog
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — how an agent chooses which backlog item to pick up next
- [`commands/backlog.md`](./commands/backlog.md) — the executable version of this standard
