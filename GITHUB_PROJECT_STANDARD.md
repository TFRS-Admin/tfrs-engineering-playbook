<!-- Purpose: Standardize the optional GitHub Project dashboard for TFRS repositories that choose to run one. -->
# TFRS GitHub Project Standard (Optional Visualization)

## Purpose

**GitHub Projects are optional visualization, not the operational source of truth.** [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md) defines the `## Metadata` block every issue body carries — that block, plus repository-local docs under `docs/engineering/` (see [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md)), is where state actually lives. An agent must be able to fully operate — determine status, pick the next issue, update state — reading only issues and repository-local docs, with no GitHub Project in existence at all.

A repository may still stand up a GitHub Project (v2) as a human-friendly visual board, for people who prefer that view over reading issue bodies. This document defines what that optional board should look like if a repository chooses to run one, so boards stay consistent across TFRS repositories that use them. **Nothing in this playbook requires an agent to create, read, or maintain one.**

## When to Use a GitHub Project

Stand one up when a repository's humans want a visual kanban-style view. Skip it entirely otherwise — a repository with no Project is not degraded, incomplete, or "not onboarded" on that basis alone. See [`REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist`](./REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist), where a GitHub Project is listed as a fully optional convenience, not a checklist item.

## Recommended Project Fields

If a repository does configure a GitHub Project, mirror the same nine fields defined in [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md) as custom fields, so the board's values never diverge from what's written in each issue's `## Metadata` block:

`Status`, `Priority`, `Risk`, `Size`, `Sprint`, `Epic`, `QA Required`, `Blocked`, `Agent Persona` — allowed values for each are defined once, in [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md#field-definitions); this document does not redefine them to avoid the two ever drifting apart.

The issue body's `## Metadata` block is authoritative. If a Project field and an issue's `## Metadata` block ever disagree, the issue body wins — update the Project field to match, not the other way around.

## Recommended Board Views

If running a Project, these eight saved views keep it consistent with other TFRS repositories that use one:

| View | Filter |
| --- | --- |
| **Roadmap** | All Epic issues, grouped by `Priority`, regardless of `Status` — mirroring `docs/engineering/ROADMAP.md` (see [`templates/README.md#repository-engineering-docs`](./templates/README.md#repository-engineering-docs)) |
| **Backlog** | `Status` = `Backlog` |
| **Ready** | `Status` = `Ready`, ordered by execution order (see [`BACKLOG_STANDARD.md#execution-ordering`](./BACKLOG_STANDARD.md#execution-ordering)) |
| **In Progress** | `Status` = `In Progress` |
| **Review** | `Status` = `In Review` |
| **QA** | `Status` = `QA`, or any `Status` where `QA Required` = `Yes` and not yet `Done` |
| **Release** | `Status` = `Done`, grouped by `Sprint`, until the release actually goes out |
| **Completed** | `Status` = `Done`, all sprints — the permanent archive view |

## Automation Rules to Configure

- New issues land in `Backlog` by default, matching the `Status` line already set in the issue's `## Metadata` block.
- Opening a linked pull request moves the item to `In Progress`, then `In Review` when the PR is marked ready — an agent should also update the issue body's `Status` line, since that's the copy that's actually required.
- An item with `QA Required` = `Yes` moves to `QA` before `Done`.
- Merging the PR moves the item to `Done`.
- Closed issues without merged work should be reviewed before automation marks them complete.

## How to Link Repositories to a Project

1. Add the repository to the GitHub Project settings.
2. Confirm issues and pull requests from that repository can be added automatically.
3. Align field names to [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md) so automation stays predictable and never becomes the only place a value is recorded.
4. Reference the project in the repository README or contributor docs as a visualization convenience, not as required infrastructure.

## Issue Triage Cadence

Run issue triage at least once per week, whether or not a Project exists:

- Re-prioritize backlog items (in the issue `## Metadata` blocks, and in `docs/engineering/BACKLOG.md`).
- Close stale or superseded work.
- Move ready items into the next sprint or work queue (update `docs/engineering/CURRENT_SPRINT.md`).
- Confirm each in-progress item still has an owner and next step.

If a Project exists, this cadence is also its board-hygiene pass — see the "Issue metadata hygiene" dimension in [`REPO_HEALTH_STANDARD.md`](./REPO_HEALTH_STANDARD.md), which does not define a separate cadence for it.

## Related Documents

- [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md) — the actual operational source of truth this document's fields mirror
- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) — how issues get created and dependency-mapped before entering the backlog
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — how an agent reads and updates state without ever needing this document
- [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md) — where this optional layer fits (or doesn't) in onboarding
