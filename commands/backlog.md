<!-- Purpose: Executable procedure for converting an approved plan into GitHub Issues, an issue hierarchy, and repository engineering documentation. -->
# Command: Backlog

## Purpose

This is the executable version of [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) — the step-by-step procedure that closes the historical gap between planning and implementation by turning a plan into real, tracked, dependency-ordered GitHub issues, each carrying a `## Metadata` block, with the result reflected in the repository's own `docs/engineering/` documentation. **No GitHub Project is required** — see [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md).

## When to Use It

- Immediately after [`commands/plan.md`](./plan.md) produces an approved task breakdown.
- When initializing a backlog for a new repository (see [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md)).
- When a [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md) finding needs to become tracked work.
- When a bug fix has no existing `Ready` tracking issue — per [`DECISION_ROUTER.md#forbidden-until-plannedbacklogged`](../DECISION_ROUTER.md#forbidden-until-plannedbacklogged), even a small, obvious fix passes through this command (converting its one-task plan into a real, fielded issue) before [`commands/execute.md`](./execute.md) can run against it.

## Required Inputs

- An approved plan (task breakdown, acceptance criteria, risks, dependencies) from [`commands/plan.md`](./plan.md).
- The target repository, its `docs/engineering/` files, and its GitHub Project if one exists (optional).
- Current sprint/cadence context if issues are being assigned to a specific sprint now — read from `docs/engineering/CURRENT_SPRINT.md`.

## Required Skill Consultation

Check for `skills/tfrs/backlog-initialization` in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) first — a TFRS-specific skill wins when one exists. As of this writing it does not exist in the fork yet (see [`SKILLS_STANDARD.md#skill-selection`](../SKILLS_STANDARD.md#skill-selection)); until it does, follow this command and [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) directly — there is no generic upstream skill to substitute, since TFRS's issue-hierarchy and Metadata-block conventions are TFRS-specific.

## Workflow

1. **Confirm repository readiness.** Verify `docs/engineering/ROADMAP.md`, `docs/engineering/BACKLOG.md`, and `docs/engineering/CURRENT_SPRINT.md` exist (create from the templates in [`templates/README.md#repository-engineering-docs`](../templates/README.md#repository-engineering-docs) if missing), and that `.github/ISSUE_TEMPLATE/` already carries the `## Metadata` block from [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md). If a GitHub Project also exists for this repository, optionally confirm its fields per [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md) — never a blocker to proceeding.
2. **Create or confirm the master Epic.** For a first backlog pass covering multiple areas, create one top-level Epic issue using [`templates/epic-template.md`](../templates/epic-template.md) that groups the child Epics below. For a single-initiative plan, skip straight to step 3.
3. **Create or confirm child Epics.** If the plan is part of a larger initiative, create one child Epic issue per initiative using [`templates/epic-template.md`](../templates/epic-template.md), linked as a sub-issue of the master Epic where one exists, or confirm the existing Epic it belongs to.
4. **Create issues for each task.** For each task in the plan, create an issue using [`templates/engineering-task-template.md`](../templates/engineering-task-template.md) (or [`templates/technical-debt-template.md`](../templates/technical-debt-template.md) for debt items). Link it as a sub-issue of its Epic.
5. **Set the complete `## Metadata` block on every issue** per [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md): `Status`, `Priority`, `Risk`, `Size`, `Epic` (parent reference), `Sprint`, `Blocked`, `QA Required`, `Agent Persona`. Leave `Status: Backlog` until dependency mapping (next step) confirms it can move to `Ready`.
6. **Map dependencies.** For each issue, record what blocks it and what it blocks in the `## Dependencies` section. Use "Blocked by #NNN" in the issue body and set `Blocked: Yes` in the `## Metadata` block on anything with an open upstream dependency.
7. **Set execution order.** Order unblocked issues by: unblocks-the-most-work first, then `Priority`, then `Risk`, then `Size` (see [`BACKLOG_STANDARD.md#execution-ordering`](../BACKLOG_STANDARD.md#execution-ordering)). Move unblocked, fully-fielded issues from `Status: Backlog` to `Status: Ready`.
8. **Update repository engineering documentation.** Write the new Epics/issues into `docs/engineering/BACKLOG.md` (and `docs/engineering/ROADMAP.md` if a new initiative was introduced) — this step is required, not optional; an issue hierarchy that exists only in GitHub with nothing recorded in the repository itself is incomplete backlog work.
9. **Assign to a sprint** if sprint planning is happening now: set the `Sprint` field on each issue and add them to `docs/engineering/CURRENT_SPRINT.md`, confirming the sprint's total load is within observed team throughput.
10. **Confirm verification expectations** are stated in each issue's `## Verification` section (`QA Required` value, and a one-line note on how it will be verified) so [`commands/verify.md`](./verify.md) has a defined target later.
11. **Mirror to a GitHub Project, only if one exists.** If the repository runs an optional GitHub Project per [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md), update its fields to match — this is the last step and is skipped entirely for repositories with no Project.

## Required Outputs

- Created/updated master Epic (if applicable), child Epic, and task issues, each with a complete `## Metadata` block.
- A recorded dependency graph (visible via "Blocked by" references and the `Blocked` field directly in each issue body).
- `docs/engineering/BACKLOG.md` (and `docs/engineering/ROADMAP.md`/`docs/engineering/CURRENT_SPRINT.md` where applicable) updated to reflect the new issues.
- Sprint assignment, if applicable.
- A GitHub Project mirror update, only if a Project exists for the repository.

## Quality Gates

- No issue enters `Ready` with any `## Metadata` field empty.
- No issue enters `Ready` while `Blocked: Yes`.
- Every issue has Given/When/Then acceptance criteria carried over from the plan — backlog does not rewrite acceptance criteria, it carries them forward.
- Every Epic has at least one child issue before it is considered actionable.
- `docs/engineering/BACKLOG.md` reflects every issue this pass created or moved to `Ready` — a GitHub-only backlog with no repository-doc counterpart does not pass this gate.

## Failure Handling

- **Repository engineering docs don't exist yet**: stop and create them from the templates in [`templates/README.md#repository-engineering-docs`](../templates/README.md#repository-engineering-docs) (or run the full [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md)) before generating any issues.
- **A required field's allowed values don't fit the work** (e.g., risk doesn't cleanly fit Low/Medium/High/Critical): default to the more conservative (higher) value and note why in the issue, rather than leaving it blank.
- **Plan input is missing acceptance criteria for a task**: do not backfill acceptance criteria yourself from assumption — send the task back to [`commands/plan.md`](./plan.md).

## Example

**Input:**
> Plan from `commands/plan.md` example: 2 tasks (server-side validation, integration tests) under an implicit "harden contact form" scope, no existing Epic.

**Output (excerpt):**
```text
Created Epic #142: "Harden tfrs-website form and content pipeline"
  Priority: P1 | Risk: Medium | Size: L | Status: Backlog

Created Issue #143 (child of #142): "Add server-side contact form validation"
  Priority: P1 | Risk: Medium | Size: S | QA Required: Yes
  Agent Persona: Implementer | Blocked: No | Status: Backlog → Ready

Created Issue #144 (child of #142): "Add integration tests for contact
form validation boundary"
  Blocked by #143 | Blocked: Yes | Status: Backlog (held until #143 lands
  since they ship in the same PR per the plan's PR breakdown)

Execution order: #143 first (unblocks #144). #144 remains in Backlog,
not Ready, until #143 is implemented in the same PR.

docs/engineering/BACKLOG.md updated with #142, #143, #144.
No GitHub Project exists for this repository — none required.
```
