<!-- Purpose: Executable procedure for turning findings and business priorities into a sequenced roadmap of epics. -->
# Command: Roadmap

## Purpose

Turn accumulated review findings, technical debt, and business priorities into a sequenced set of Epics before detailed planning starts on any one of them. Roadmap operates above the level of a single issue — it decides *what* gets planned next and in what order, across a quarter or release window.

## When to Use It

- Quarterly, or at the start of a new release window.
- After a batch of [`commands/review.md`](./review.md) passes or a [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md) cycle have produced more findings than can be planned at once.
- When reprioritizing an existing backlog because business priorities changed.

## Required Inputs

- All open, approved findings from recent reviews and health checks.
- Business goals or constraints for the window (from a human — roadmap priority is not an AI decision).
- Existing open Epics and their current `Priority`/`Status`, read from each Epic issue's `## Metadata` block (see [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md)) and `docs/engineering/ROADMAP.md`.
- Rough capacity for the window (how many Epics the team can realistically carry).

## Required Skill Consultation

No direct upstream skill in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) — Roadmap is a TFRS-specific prioritization exercise the reference methodology doesn't model (see the [Terminology Map](../AI_ENGINEERING_WORKFLOW.md#terminology-map)). Optionally consult `skills/planning-and-task-breakdown` when sizing individual candidate Epics in step 5, per [`PLANNING_STANDARD.md`](../PLANNING_STANDARD.md).

## Workflow

1. Collect every candidate: open findings, existing unplanned Epics, and explicit business asks.
2. Group related findings and asks into candidate Epics — a roadmap item should be big enough to matter and small enough to sequence, not a single task.
3. For each candidate Epic, identify its dependencies on other candidate Epics or on outstanding technical debt.
4. Sequence using: (a) hard dependencies first, (b) business priority, (c) risk — front-load high-risk work while there's runway in the window.
5. Assign a rough size (S/M/L/XL per [`PLANNING_STANDARD.md`](../PLANNING_STANDARD.md)) to each candidate Epic; anything XL should be flagged for splitting before it is planned in detail.
6. Present the sequenced list to a human for explicit approval — roadmap sequencing is a business trade-off, not something to finalize unilaterally.
7. For each approved Epic, create or update the GitHub issue using [`templates/epic-template.md`](../templates/epic-template.md) with a complete `## Metadata` block, and record it in `docs/engineering/ROADMAP.md` — this file, not a GitHub Project view, is the roadmap's actual home. A GitHub Project, if the repository runs one, may optionally mirror the same sequencing.

## Required Outputs

- `docs/engineering/ROADMAP.md` updated with sequenced Epics, their origin (which review/finding/ask produced them), size, priority, and dependencies.
- Created or updated Epic issues, each with a `## Metadata` `Status` reflecting readiness (`Backlog` or `Ready`).
- An explicit list of anything intentionally deferred, with the reason.

## Quality Gates

- Every Epic on the roadmap traces to a review finding, health finding, or explicit business input — no roadmap item appears from nowhere.
- Sequencing respects known hard dependencies; nothing is sequenced ahead of something it depends on.
- No more than the stated capacity is committed for the window.
- Trade-offs (choosing one Epic's priority over another) are surfaced explicitly to the human approver, not decided silently.

## Failure Handling

- **Conflicting priorities from different stakeholders**: surface the conflict directly; do not pick a side.
- **Capacity clearly insufficient for the candidate list**: say so and recommend what to cut or defer rather than quietly overcommitting the window.
- **A candidate Epic has no clear owner or business justification**: hold it out of the roadmap and flag it for clarification instead of sequencing it anyway.

## Example

**Input:**
> Candidates: 3 findings from the `tfrs-website` review (contact form validation, page metadata, CI accessibility), 1 business ask (add a pricing calculator page). Capacity: 2 Epics this quarter.

**Output (excerpt):**
```text
Roadmap for Q3:
  1. [P1, M, no dependencies] Harden tfrs-website form and content pipeline
     (origin: review findings 1-3)
  2. [P1, L, no dependencies] Add pricing calculator page (origin: business ask)

Deferred: none this quarter — both candidates fit stated capacity.

Approval needed: confirm pricing calculator outranks form hardening if only
one can ship this quarter, since both are P1.
```
