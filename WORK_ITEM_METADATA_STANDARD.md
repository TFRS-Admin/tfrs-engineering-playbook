<!-- Purpose: Define the structured Metadata block every work-item file must carry, and the vocabulary (Epic/Story/Task, sizing, acceptance-criteria format) needed to fill it in. -->
# TFRS Work Item Metadata Standard

## Purpose

Work items are version-controlled markdown files inside each repository, not GitHub Issues — see [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) for the full architecture. One file per work item, living at `docs/engineering/backlog/<EPIC>-<NN>-<kebab-slug>.md`. The file's `## Metadata` block is the operational source of truth for that item's status, priority, risk, size, and dependencies — there is no GitHub Project, no GitHub Issue, and no second index file to keep in sync with it. An agent determines a work item's state by reading the file itself.

## The Metadata Block

Every work-item file must include a `## Metadata` section, immediately followed by `## Acceptance Criteria`, `## Verification`, and `## Dependencies` sections (any of the latter three may be empty, but the heading must be present). Use exactly this shape:

```md
## Metadata

Status: Ready
Priority: P1
Risk: Medium
Size: S
Epic: Security Hardening
Blocked: No
QA Required: Yes

## Acceptance Criteria

## Verification

## Dependencies
```

Each `Field: Value` line is a single line, in `Field: Value` form, so it can be parsed reliably from the raw file without any API call. Do not reorder, rename, or split a field across multiple lines.

## Field Definitions

### Status

The operational state — where the item is right now.

Allowed values: `Backlog`, `Ready`, `In Progress`, `In Review`, `QA`, `Done`

- **Lifecycle:** `Backlog` (default on creation) → `Ready` (dependencies clear, Metadata complete) → `In Progress` (branch/work started) → `In Review` (PR open) → `QA` (only if `QA Required` = `Yes`) → `Done` (merged).
- **Ownership:** updated by whoever is actively working the item, in the file itself, the moment it changes — see [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#5-how-to-update-state).
- **Finding current work:** there is no separate "what's in progress" index file — that would be a second source of truth for the same fact recorded here. To find what's active, glob `docs/engineering/backlog/*.md` for `Status: In Progress` (or `Ready`, or whatever state is being asked about) directly.

### Priority

Business urgency, independent of effort.

Allowed values: `P0`, `P1`, `P2`, `P3`

- **Usage:** `P0` is drop-everything; `P3` is nice-to-have. Used first in execution ordering, after hard dependencies.

### Risk

How much could go wrong if this item is done poorly or fails in production.

Allowed values: `Low`, `Medium`, `High`, `Critical`

- **Usage:** governs how much autonomy an agent should exercise (see [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#4-when-to-stop)) and whether `QA Required` should default to `Yes`. `High`/`Critical` risk items get resolved earlier, not later, and trigger the Threat Model First step in [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md) — that field is a planning-time estimate, distinct from a security audit's own finding-severity scale (see that document for the distinction).
- **Ownership:** default to the more conservative value when uncertain.

### Size

Relative effort:

- **S**: can likely ship in one focused session.
- **M**: a few focused sessions.
- **L**: probably needs breakdown.
- **XL**: too large — split before work starts.

Split further, regardless of the size label above, when any of these is true:
- The work would take more than one focused implementation session.
- Acceptance criteria can't be stated in three or fewer Given/When/Then blocks.
- It touches two or more independent subsystems.
- The title needs the word "and" to describe it — that's usually two work items wearing one title.

### Epic

Which section of `docs/engineering/ROADMAP.md` this item belongs to.

Allowed values: an Epic name matching a `## Epic:` section heading in `ROADMAP.md` (see that file's template), or `None` for a standalone item with no parent initiative. Epics are sections in `ROADMAP.md`, not their own files — a work item's `Epic:` field is the only link between the two; there's no sub-issue relationship to maintain.

### Blocked

Whether the item has an unresolved upstream dependency, independent of `Status`.

Allowed values: `Yes`, `No`

- **Usage:** a boolean overlay flag — an `In Progress` item can also be `Blocked` = `Yes` if a new dependency surfaces mid-work. An item never moves to `Ready` while `Blocked` = `Yes`. The `## Dependencies` section names *what* it's blocked by, using the blocking item's filename (e.g. `Blocked by SEC-02-audit-dependencies.md`) — this field is the boolean checked first.
- **What's lost moving off GitHub Issues:** GitHub's native issue-linking gave a clickable dependency graph in the UI for free. A filename reference doesn't — if you want to see the graph, grep the backlog directory for `Blocked by` and trace it by hand, or script it. This is a real, deliberate trade-off, not an oversight.

### QA Required

Whether the item must pass through a `QA` status before `Done`.

Allowed values: `Yes`, `No`

- **Usage:** `Yes` for anything touching user-facing behavior, security boundaries, data integrity, or public APIs. `No` for internal tooling, docs-only, or low-risk chores. An item cannot reach `Done` with `QA Required` = `Yes` and no completed [`templates/verification-report-template.md`](./templates/verification-report-template.md) filled into its `## Verification` section.
- **Ownership:** defaults to `Yes` when `Risk` is `High` or `Critical`.

## Epic vs. Story vs. Task vs. Tech Debt

- **Epic:** a multi-work-item outcome, tracked as its own section in `docs/engineering/ROADMAP.md` — never a file of its own, and never directly executed.
- **Story/Task:** a workflow-centered deliverable that can usually ship in one PR. The default shape — use [`templates/engineering-task-template.md`](./templates/engineering-task-template.md).
- **Tech debt:** a work item like any other, distinguished only by its origin (discovered during review or execution rather than planned) — use the same template, note the origin in the `## Origin`/problem statement.

Don't introduce a fourth category or a separate template per type; the one template covers all of them.

## Acceptance Criteria Format

Write acceptance criteria in **Given / When / Then** form whenever behavior matters:

```text
Given a repository with no docs/engineering/ directory
When the setup checklist is followed
Then the repository has ROADMAP.md and an empty backlog/ directory
```

No item enters `Ready` with this section empty.

## The Three Trailing Sections

### Acceptance Criteria

Given/When/Then blocks, per above. No item enters `Ready` with this section empty.

### Verification

How the item will be — or was — verified: the planned approach at backlog time, and the completed [`templates/verification-report-template.md`](./templates/verification-report-template.md) evidence once verification has run.

### Dependencies

What this item is blocked by and what it blocks, using the blocking/blocked item's filename.

## How Agents Read and Update This Block

1. **Read**: parse the `## Metadata` section's `Field: Value` lines directly from the work-item file — this is the only required read.
2. **Update**: when a field changes (e.g. `Status: Ready` → `Status: In Progress`), edit the file in place — do not leave a comment or commit message saying the status changed instead of actually changing it.
3. **Never treat a chat summary as a substitute.** If a field's new value isn't reflected in the file itself, it did not happen — see [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#5-how-to-update-state).

## Related Documents

- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) — how work items get created with this block populated
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — how an agent reads and updates these fields as the source of truth
- [`templates/engineering-task-template.md`](./templates/engineering-task-template.md) — the one work-item template, already carrying this block
- [`templates/engineering-roadmap-template.md`](./templates/engineering-roadmap-template.md) — where Epics live, as sections
