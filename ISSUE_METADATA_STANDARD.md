<!-- Purpose: Define the structured Metadata block every GitHub Issue body must carry, since GitHub Project fields are optional, not required. -->
# TFRS Issue Metadata Standard

## Purpose

The architecture this playbook operates on is:

```text
Repository-local docs and guidance
        ↓
GitHub Issues and issue hierarchy
        ↓
TFRS Engineering Playbook
        ↓
TFRS-Admin/agent-skills
```

**Repository-local documentation and GitHub Issues are the operational source of truth. GitHub Projects are optional visualization.** An agent must be able to determine an issue's status, priority, risk, size, sprint, blockers, and owner from the issue itself — never from a Project board that may not exist. This document defines the structured `## Metadata` block that makes that possible, and is the field vocabulary [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) mirrors when a repository chooses to layer an optional Project dashboard on top.

## Where This Fits

- [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md) defines issue anatomy in general; this document defines the one required structured section every issue body must carry.
- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) is the phase that writes this block onto every issue it creates.
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) is how an agent reads this block to determine current state and the next issue to pick up.
- [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) is the optional dashboard layer — useful for humans who want a visual board, never required for an agent to operate.

## The Metadata Block

Every issue body must include a `## Metadata` section, immediately followed by `## Acceptance Criteria`, `## Verification`, and `## Dependencies` sections (any of the latter three may be empty, but the heading must be present so an agent — or a human scanning the issue — always knows where to look). Use exactly this shape:

```md
## Metadata

Status: Ready
Priority: P1
Risk: Medium
Size: S
Epic: Security Hardening
Sprint: Sprint 0
Blocked: No
QA Required: Yes
Agent Persona: Backend

## Acceptance Criteria

## Verification

## Dependencies
```

Each `Field: Value` line is a single line, in `Field: Value` form, so it can be parsed reliably from the raw issue body without a Project API call. Do not reorder, rename, or split a field across multiple lines.

## Field Definitions

These are the same nine fields and allowed values previously expressed only as GitHub Project custom fields — they now live in the issue body directly, and a Project field (if a repository chooses to configure one) is a mirror of this block, not the other way around.

### Status

The operational state — where the item is right now.

Allowed values: `Backlog`, `Ready`, `In Progress`, `In Review`, `QA`, `Done`

- **Lifecycle:** `Backlog` (default on creation) → `Ready` (dependencies clear, Metadata complete) → `In Progress` (branch/work started) → `In Review` (PR open) → `QA` (only if `QA Required` = `Yes`) → `Done` (merged and closed).
- **Ownership:** updated by whoever is actively working the item — see [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#5-how-to-update-state) for exactly when an agent must move this.

### Priority

Business urgency, independent of effort.

Allowed values: `P0`, `P1`, `P2`, `P3`

- **Usage:** `P0` is drop-everything (active incident or blocking release); `P3` is nice-to-have. Used first in [execution ordering](./BACKLOG_STANDARD.md#execution-ordering) after hard dependencies.
- **Ownership:** set by whoever runs [`commands/roadmap.md`](./commands/roadmap.md) or [`commands/backlog.md`](./commands/backlog.md); changed only with explicit human sign-off once set.

### Risk

How much could go wrong if this item is done poorly or fails in production.

Allowed values: `Low`, `Medium`, `High`, `Critical`

- **Usage:** governs review rigor, whether `QA Required` should default to `Yes`, and how much autonomy an agent should exercise (see [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#4-when-to-stop)). `High`/`Critical` risk items get resolved earlier in a sprint, not later, and trigger the Threat Model First step in [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md) — note that field is a planning-time estimate, distinct from a security audit's finding-severity scale (see that document for the distinction).
- **Ownership:** set during [`commands/plan.md`](./commands/plan.md) or [`commands/backlog.md`](./commands/backlog.md); default to the more conservative value when uncertain.

### Size

Relative effort, per [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md#estimation-approach) (defined there — not redefined here to avoid duplication).

Allowed values: `S`, `M`, `L`, `XL`

- **Usage:** `XL` items must be split before entering the backlog — see [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md#issue-generation).
- **Ownership:** set during [`commands/plan.md`](./commands/plan.md).

### Epic

A reference to the parent Epic this item belongs to.

Allowed values: an Epic issue reference (number, link, or title), or `None` for standalone technical debt items.

- **Usage:** every Story/Task must set this except Epics themselves, which leave it blank or self-reference.
- **Ownership:** set when the issue is created, per [`commands/backlog.md`](./commands/backlog.md).

### Sprint

The sprint, iteration, or date range an item is committed to.

Allowed values: free text matching the repository's sprint cadence (e.g. `Sprint 0`, `Q3 Sprint 1`), tracked in [`docs/engineering/CURRENT_SPRINT.md`](./templates/README.md#repository-engineering-docs).

- **Usage:** only set once an item is in `Ready` or later — an item still in `Backlog` should not carry a stale sprint value.
- **Ownership:** set during sprint planning (part of [`commands/backlog.md`](./commands/backlog.md)); cleared and reassigned via [`templates/sprint-review-template.md`](./templates/sprint-review-template.md) for anything that slips.

### Blocked

Whether the item has an unresolved upstream dependency, independent of `Status`.

Allowed values: `Yes`, `No`

- **Usage:** a boolean overlay flag — an `In Progress` item can also be `Blocked` = `Yes` if a new dependency surfaces mid-work. An item never moves to `Ready` while `Blocked` = `Yes`. The `## Dependencies` section names *what* it's blocked by; this field is the boolean an agent checks first.
- **Ownership:** set during dependency mapping in [`commands/backlog.md`](./commands/backlog.md); updated immediately by whoever discovers or clears a blocker, per [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#5-how-to-update-state).

### QA Required

Whether the item must pass through a `QA` status before `Done`.

Allowed values: `Yes`, `No`

- **Usage:** `Yes` for anything touching user-facing behavior, security boundaries, data integrity, or public APIs. `No` for internal tooling, docs-only, or low-risk chores. An item cannot reach `Done` with `QA Required` = `Yes` and no completed [`templates/verification-report-template.md`](./templates/verification-report-template.md) filled into its `## Verification` section.
- **Ownership:** set during [`commands/backlog.md`](./commands/backlog.md); defaults to `Yes` when `Risk` is `High` or `Critical`.

### Agent Persona

Which role — human or AI — is expected to act on this item next.

Allowed values: `Reviewer`, `Planner`, `Backlog-Manager`, `Implementer`, `Verifier`, `Release-Manager`, `Repo-Health-Auditor` — a repository may extend this with domain-specific values (e.g. `Backend`, `Frontend`) where useful, as long as [`AI_AGENT_OPERATING_MODEL.md#8-agent-personas`](./AI_AGENT_OPERATING_MODEL.md#8-agent-personas)'s seven lifecycle personas remain the ones that govern *which command runs next*.

- **Usage:** an agent should only pick up an item whose `Agent Persona` matches the role it is operating as (see [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-issue)). The value updates as the item moves through phases (e.g. `Implementer` while `Status` moves through `Ready` → `In Progress`, then `Verifier` while it's in `QA`).
- **Ownership:** defaults are derived from the lifecycle phase; a human may override to assign a specific owner.

## The Three Trailing Sections

### Acceptance Criteria

Given/When/Then blocks per [`PLANNING_STANDARD.md#acceptance-criteria-format`](./PLANNING_STANDARD.md#acceptance-criteria-format). No issue enters `Ready` with this section empty.

### Verification

How the item will be — or was — verified: the planned approach at backlog time (automated test, manual walkthrough, both), and the completed [`templates/verification-report-template.md`](./templates/verification-report-template.md) evidence once [`commands/verify.md`](./commands/verify.md) has run.

### Dependencies

What this issue is blocked by and what it blocks, using `Blocked by #NNN` / `Blocks #NNN` references so the dependency graph is visible directly in the issue body and in GitHub's native issue-linking UI — without requiring a Project to visualize it.

## How Agents Read and Update This Block

1. **Read**: parse the `## Metadata` section's `Field: Value` lines directly from the issue body — this is the only required read; a GitHub Project, if one exists, is a convenience, not a fallback path to check first.
2. **Update**: when a field changes (e.g. `Status: Ready` → `Status: In Progress`), edit the issue body to update that line in place — do not just leave a comment saying the status changed. If the repository also maintains an optional GitHub Project per [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md), mirror the change there too, but the issue body edit is the one that is never optional.
3. **Never treat a chat summary as a substitute.** If a field's new value isn't reflected on the issue itself, it did not happen — the same rule [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#5-how-to-update-state) states for GitHub generally.

## Related Documents

- [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) — the optional dashboard that may mirror these fields
- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) — how issues get created with this block populated
- [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md) — general issue anatomy and acceptance criteria format
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — how an agent reads and updates these fields as the source of truth
- [`templates/epic-template.md`](./templates/epic-template.md), [`templates/engineering-task-template.md`](./templates/engineering-task-template.md), [`templates/technical-debt-template.md`](./templates/technical-debt-template.md) — issue templates that already carry this block
