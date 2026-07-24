<!-- Purpose: Define the canonical procedure for converting review findings and plans into tracked work-item files. -->
# TFRS Backlog Standard

## Purpose

This document defines the phase that closes the gap in the TFRS lifecycle:

```text
Review → Plan → Backlog → Execute
```

Review produces findings. Planning produces an implementation strategy. Neither is executable work until it exists as a tracked work-item file, carrying a complete `## Metadata` block, and reflected in `docs/engineering/ROADMAP.md` where it belongs to an Epic. **Backlog is the phase that performs that conversion.** Nothing moves to `Execute` (see [`RULESET.md`](./RULESET.md)) without first passing through this phase.

This is the canonical guide for turning planning artifacts into tracked work. The executable, step-by-step version of this standard — written as a prompt an AI agent can run directly — is [`commands/backlog.md`](./commands/backlog.md).

## Guiding Principle

> Repository-local documentation and work-item files are the operational source of truth. Chat is temporary. Reviews create findings. Plans create implementation strategy. Backlog turns both into tracked work-item files and updates the repository's engineering documentation.

A finding or plan that only exists in a chat transcript or a document is not yet real work. It becomes real work the moment it is represented as a work-item file with the `## Metadata` block defined in [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md), and reflected in `docs/engineering/ROADMAP.md` where relevant.

## Inputs to This Phase

- An approved plan from [`commands/plan.md`](./commands/plan.md), or
- A prioritized roadmap Epic, or
- A finding from [`commands/review.md`](./commands/review.md) that the operator has approved for action, or
- A finding from [`commands/repo-health.md`](./commands/repo-health.md)

Nothing enters the backlog phase without one of the above as its traceable origin. If work has no upstream artifact, run [`commands/review.md`](./commands/review.md) or [`commands/plan.md`](./commands/plan.md) first.

## Repository Readiness

Before generating work-item files, confirm the repository has the engineering documentation this phase writes to and reads from:

1. Confirm `docs/engineering/ROADMAP.md` and an empty-or-populated `docs/engineering/backlog/` directory exist (create them per [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md) if this is a new repository or first adoption).
2. If any required engineering doc is missing, create it before generating work items. Do not generate work items into a repository that has nowhere to record them.

## Work Item Generation

Convert planning artifacts into work-item files using this decomposition order:

1. **Confirm or create the Epic.** An Epic is a `## Epic:` section in `docs/engineering/ROADMAP.md`, never its own file — see [`templates/engineering-roadmap-template.md`](./templates/engineering-roadmap-template.md) for the section format. For a single-item plan with no larger initiative, use `Epic: None`.
2. **Create a work-item file for each task**, using [`templates/engineering-task-template.md`](./templates/engineering-task-template.md), at `docs/engineering/backlog/<EPIC>-<NN>-<kebab-slug>.md`. This is the one template — a technical-debt item discovered during review or execution uses the same shape.

Every generated work-item file must include:

- A title following the acceptance-criteria and sizing guidance in [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md)
- A complete `## Metadata` block (no item enters `Ready` with an empty required field)
- Acceptance criteria in Given/When/Then form
- Empty but present `## Verification` and `## Dependencies` sections
- A link back to the originating review, plan, or roadmap artifact

## Dependency Mapping

1. For every work item, identify what it is blocked by and what it blocks.
2. Record dependencies in the `## Dependencies` section using the blocking/blocked item's filename (e.g. `Blocked by SEC-02-audit-dependencies.md`) — there is no native cross-link the way GitHub Issues had; the filename reference is the whole mechanism (see [`WORK_ITEM_METADATA_STANDARD.md#blocked`](./WORK_ITEM_METADATA_STANDARD.md#blocked) for what's lost by not having GitHub's graph).
3. Set `Blocked` to `Yes` in the `## Metadata` block on anything with an open upstream dependency. Set it back to `No` the moment the blocking item reaches `Done` — do not leave stale blocks in the file.
4. A work item with unresolved dependencies does not move to `Ready`, regardless of priority.

## Execution Ordering

Order work items for execution using this precedence, in order:

1. **Unblocks the most other work** — an item several others depend on goes first even if its own priority is lower.
2. **Priority** (`P0` > `P1` > `P2` > `P3`).
3. **Risk** — prefer resolving `High`/`Critical` risk items earlier so there is runway left to react if they slip.
4. **Size** — when priority and risk are equal, prefer smaller items first.

There is no separate index file recording this order — it's derivable at any time by globbing `docs/engineering/backlog/*.md` and sorting by these fields directly; don't create one, it would be a second source of truth for facts already in each file.

## Acceptance Criteria

Every work item's acceptance criteria must be written in Given/When/Then form per [`WORK_ITEM_METADATA_STANDARD.md#acceptance-criteria-format`](./WORK_ITEM_METADATA_STANDARD.md#acceptance-criteria-format). A work item without testable acceptance criteria is not ready for backlog — send it back to `Plan`.

## Verification Expectations

Every work item must state, at backlog time, how it will be verified:

- Set `QA Required` to `Yes` for anything touching user-facing behavior, security boundaries, data integrity, or public APIs; `No` only for internal tooling, docs-only, or low-risk chores.
- Reference the verification approach (automated test, manual walkthrough, both) so [`commands/verify.md`](./commands/verify.md) has a defined target when the item reaches implementation.
- A work item cannot move to `Done` without a completed [`templates/verification-report-template.md`](./templates/verification-report-template.md) when `QA Required` is `Yes`.

## Related Documents

- [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md) — the Metadata block, field definitions, and allowed values every generated work item carries
- [`RULESET.md`](./RULESET.md) — planning-effort calibration and commit/branch conventions
- [`commands/backlog.md`](./commands/backlog.md) — the executable version of this standard
