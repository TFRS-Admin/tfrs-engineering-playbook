<!-- Purpose: Executable procedure for turning findings and business priorities into a sequenced roadmap of epics. -->
# Command: Roadmap

## Purpose

Turn accumulated review findings, technical debt, and business priorities into a sequenced set of Epics before detailed planning starts on any one of them. Roadmap operates above the level of a single work item — it decides *what* gets planned next and in what order.

## When to Use It

- When starting a new phase of work.
- After a batch of [`commands/review.md`](./review.md) passes or a [`commands/repo-health.md`](./repo-health.md) run have produced more findings than can be planned at once.
- When reprioritizing an existing backlog because priorities changed.

## Required Inputs

- All open, approved findings from recent reviews and health checks.
- Priorities or constraints for the window (from the operator — roadmap priority is not an AI decision).
- The current `docs/engineering/ROADMAP.md`, including any Epic sections already in flight.
- Rough capacity for the window.

## Required Skill Consultation

No direct upstream skill in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) — Roadmap is a TFRS-specific prioritization exercise the reference methodology doesn't model. Optionally consult `skills/planning-and-task-breakdown` when sizing individual candidate Epics in step 5.

## Workflow

1. Collect every candidate: open findings, existing unscheduled Epics, and explicit priorities.
2. Group related findings and asks into candidate Epics — a roadmap item should be big enough to matter and small enough to sequence, not a single task.
3. For each candidate Epic, identify its dependencies on other candidate Epics or on outstanding technical debt.
4. Sequence using: (a) hard dependencies first, (b) priority, (c) risk — front-load high-risk work while there's runway in the window.
5. Assign a rough size (S/M/L/XL per [`WORK_ITEM_METADATA_STANDARD.md#size`](../WORK_ITEM_METADATA_STANDARD.md#size)) to each candidate Epic; anything XL should be flagged for splitting before it is planned in detail.
6. Present the sequenced list to the operator for explicit approval — roadmap sequencing is a trade-off, not something to finalize unilaterally.
7. For each approved Epic, add or update its `## Epic:` section in `docs/engineering/ROADMAP.md`, per [`templates/engineering-roadmap-template.md`](../templates/engineering-roadmap-template.md) — this file is the roadmap's only home; there is no GitHub Project or Epic issue mirroring it.

## Required Outputs

- `docs/engineering/ROADMAP.md` updated with sequenced Epic sections, their origin (which review/finding/ask produced them), size, priority, and dependencies.
- An explicit list of anything intentionally deferred, with the reason.

## Quality Gates

- Every Epic on the roadmap traces to a review finding, health finding, or explicit input — no roadmap item appears from nowhere.
- Sequencing respects known hard dependencies; nothing is sequenced ahead of something it depends on.
- No more than the stated capacity is committed for the window.
- Trade-offs (choosing one Epic's priority over another) are surfaced explicitly to the operator, not decided silently.

## Failure Handling

- **Conflicting priorities**: surface the conflict directly; do not pick a side.
- **Capacity clearly insufficient for the candidate list**: say so and recommend what to cut or defer rather than quietly overcommitting the window.
- **A candidate Epic has no clear justification**: hold it out of the roadmap and flag it for clarification instead of sequencing it anyway.

## Example

**Input:**
> Candidates: 3 findings from a `tfrs-website` review (contact form validation, page metadata, CI accessibility), 1 business ask (add a pricing calculator page). Capacity: 2 Epics this window.

**Output (excerpt):**
```text
Roadmap update:
  1. [P1, M, no dependencies] Harden tfrs-website form and content pipeline
     (origin: review findings 1-3)
  2. [P1, L, no dependencies] Add pricing calculator page (origin: business ask)

Deferred: none — both candidates fit stated capacity.

Approval needed: confirm the pricing calculator outranks form hardening if
only one can ship this window, since both are P1.
```
