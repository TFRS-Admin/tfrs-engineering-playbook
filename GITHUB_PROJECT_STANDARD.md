<!-- Purpose: Standardize GitHub Project setup and operating rules for TFRS repositories. -->
# TFRS GitHub Project Standard

## Purpose

GitHub Projects are the operational source of truth for TFRS engineering work — not chat, not a planning doc. This document defines the required fields, allowed values, and board views every TFRS repository's GitHub Project must implement so that state is always visible and consistent across repositories. The executable procedure for populating a project with issues is [`commands/backlog.md`](./commands/backlog.md); the standard governing how issues get here is [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md).

## Required Project Fields

Every TFRS GitHub Project must have all ten of these fields configured before any issue enters `Ready`.

### Status

The operational board column — where the item is right now.

Allowed values: `Backlog`, `Ready`, `In Progress`, `In Review`, `QA`, `Done`

- **Lifecycle:** `Backlog` (default on creation) → `Ready` (dependencies clear, fields complete) → `In Progress` (branch/work started) → `In Review` (PR open) → `QA` (only if `QA Required` = `Yes`) → `Done` (merged and closed).
- **Ownership:** updated by whoever is actively working the item — see [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#5-how-to-update-github) for exactly when an agent must move this.

### Phase

Which stage of the engineering lifecycle currently governs the item — traces the item to the command that last touched it.

Allowed values: `Review`, `Roadmap`, `Plan`, `Backlog`, `Execute`, `Verify`, `Ship`

- **Lifecycle:** set by whichever [`commands/`](./commands/README.md) procedure is currently acting on the item; moves forward through the list above as the item progresses. This is distinct from `Status` — `Phase` records methodology stage, `Status` records board position.
- **Ownership:** set by the agent or human running the corresponding command.

### Priority

Business urgency, independent of effort.

Allowed values: `P0`, `P1`, `P2`, `P3`

- **Usage:** `P0` is drop-everything (active incident or blocking release); `P3` is nice-to-have. Used first in [`execution ordering`](./BACKLOG_STANDARD.md#execution-ordering) after hard dependencies.
- **Ownership:** set by whoever runs [`commands/roadmap.md`](./commands/roadmap.md) or [`commands/backlog.md`](./commands/backlog.md); changed only with explicit human sign-off once set.

### Risk

How much could go wrong if this item is done poorly or fails in production.

Allowed values: `Low`, `Medium`, `High`, `Critical`

- **Usage:** governs review rigor, whether `QA Required` should default to `Yes`, and how much autonomy an agent should exercise (see [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#4-when-to-stop)). `High`/`Critical` risk items get resolved earlier in a sprint, not later.
- **Ownership:** set during [`commands/plan.md`](./commands/plan.md) or [`commands/backlog.md`](./commands/backlog.md); default to the more conservative value when uncertain.

### Size

Relative effort, per [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md#estimation-approach) (defined there — not redefined here to avoid duplication).

Allowed values: `S`, `M`, `L`, `XL`

- **Usage:** `XL` items must be split before entering the backlog — see [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md#issue-generation).
- **Ownership:** set during [`commands/plan.md`](./commands/plan.md).

### Sprint

The sprint, iteration, or date range an item is committed to.

Allowed values: free text matching the repository's sprint cadence (e.g. `Q3 Sprint 1`).

- **Usage:** only set once an item is in `Ready` or later — an item still in `Backlog` should not carry a stale sprint value.
- **Ownership:** set during sprint planning (part of [`commands/backlog.md`](./commands/backlog.md)); cleared and reassigned via [`templates/sprint-review-template.md`](./templates/sprint-review-template.md) for anything that slips.

### Epic

A reference (issue number/link) to the parent Epic this item belongs to.

Allowed values: an Epic issue reference, or `None` for standalone technical debt items.

- **Usage:** every Story/Task must set this except Epics themselves, which leave it blank or self-reference.
- **Ownership:** set when the issue is created, per [`commands/backlog.md`](./commands/backlog.md).

### QA Required

Whether the item must pass through the `QA` status before `Done`.

Allowed values: `Yes`, `No`

- **Usage:** `Yes` for anything touching user-facing behavior, security boundaries, data integrity, or public APIs. `No` for internal tooling, docs-only, or low-risk chores. An item cannot reach `Done` with `QA Required` = `Yes` and no completed [`templates/verification-report-template.md`](./templates/verification-report-template.md).
- **Ownership:** set during [`commands/backlog.md`](./commands/backlog.md); defaults to `Yes` when `Risk` is `High` or `Critical`.

### Blocked

Whether the item has an unresolved upstream dependency, independent of `Status`.

Allowed values: `Yes`, `No`

- **Usage:** a boolean overlay flag — an `In Progress` item can also be `Blocked` = `Yes` if a new dependency surfaces mid-work. An item never moves to `Ready` while `Blocked` = `Yes`.
- **Ownership:** set during dependency mapping in [`commands/backlog.md`](./commands/backlog.md); updated immediately by whoever discovers or clears a blocker, per [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#5-how-to-update-github).

### Agent Persona

Which role — human or AI — is expected to act on this item next.

Allowed values: `Reviewer`, `Planner`, `Backlog-Manager`, `Implementer`, `Verifier`, `Release-Manager`, `Repo-Health-Auditor`

- **Usage:** an agent should only pick up an item whose `Agent Persona` matches the role it is operating as (see [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-issue)). The value updates as the item moves through phases (e.g. `Implementer` while `Phase` = `Execute`, then `Verifier` while `Phase` = `Verify`).
- **Ownership:** defaults are derived from `Phase`; a human may override to assign a specific owner.

## Board Views

Every TFRS GitHub Project must include these eight saved views:

| View | Filter |
| --- | --- |
| **Roadmap** | `Phase` = `Roadmap`, grouped by `Priority`, all Epics regardless of `Status` |
| **Backlog** | `Status` = `Backlog` |
| **Ready** | `Status` = `Ready`, ordered by execution order (see [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md#execution-ordering)) |
| **In Progress** | `Status` = `In Progress` |
| **Review** | `Status` = `In Review` |
| **QA** | `Status` = `QA`, or any `Status` where `QA Required` = `Yes` and not yet `Done` |
| **Release** | `Status` = `Done` and `Phase` = `Ship`, grouped by `Sprint`, until the release actually goes out |
| **Completed** | `Status` = `Done`, all sprints — the permanent archive view |

## Automation Rules to Configure

- New issues land in `Backlog` by default, with `Phase` = `Backlog` and `Blocked` = `No` unless dependency mapping says otherwise.
- Issues with all ten required fields set and `Blocked` = `No` move to `Ready`.
- Opening a linked pull request moves the item to `In Progress`, then `In Review` when the PR is marked ready.
- An item with `QA Required` = `Yes` moves to `QA` before `Done`.
- Merging the PR moves the item to `Done` and sets `Phase` = `Ship`.
- Closed issues without merged work should be reviewed before automation marks them complete.

## How to Link Repositories to a Project

1. Add the repository to the GitHub Project settings.
2. Confirm issues and pull requests from that repository can be added automatically.
3. Align labels and field names so automation rules stay predictable.
4. Reference the project in the repository README or contributor docs.

## Issue Triage Cadence

Run issue triage at least once per week:

- Re-prioritize backlog items
- Close stale or superseded work
- Move ready items into the next sprint or work queue
- Confirm each in-progress item still has an owner and next step

This weekly cadence is also the "GitHub Project hygiene" dimension referenced in [`REPO_HEALTH_STANDARD.md`](./REPO_HEALTH_STANDARD.md) — that document does not define a separate cadence for it.

## Related Documents

- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) — how issues get created and dependency-mapped before entering this project
- [`commands/backlog.md`](./commands/backlog.md) — executable procedure for populating and maintaining a project
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — how an agent reads and updates these fields
- [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md) — project initialization as part of onboarding a repository
