<!-- Purpose: Executable procedure for converting an approved plan into GitHub Projects, Epics, Issues, and execution order. -->
# Command: Backlog

## Purpose

This is the executable version of [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) — the step-by-step procedure that closes the historical gap between planning and implementation by turning a plan into real, tracked, dependency-ordered GitHub issues on a GitHub Project.

## When to Use It

- Immediately after [`commands/plan.md`](./plan.md) produces an approved task breakdown.
- When initializing a backlog for a new repository (see [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md)).
- When a [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md) finding needs to become tracked work.

## Required Inputs

- An approved plan (task breakdown, acceptance criteria, risks, dependencies) from [`commands/plan.md`](./plan.md).
- The target repository and its GitHub Project.
- Current sprint/cadence context if issues are being assigned to a specific sprint now.

## Required Skill Consultation

Check for `skills/tfrs/backlog-initialization` or `skills/tfrs/github-project-management` in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) first — a TFRS-specific skill wins when one exists. As of this writing neither exists in the fork yet (see [`SKILLS_STANDARD.md#skill-selection`](../SKILLS_STANDARD.md#skill-selection)); until it does, follow this command and [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) directly — there is no generic upstream skill to substitute, since backlog conversion against a GitHub Project is TFRS-specific.

## Workflow

1. **Confirm project readiness.** Verify the GitHub Project exists, is attached to the repository, and has all ten required fields (`Status`, `Phase`, `Priority`, `Risk`, `Size`, `Sprint`, `Epic`, `QA Required`, `Blocked`, `Agent Persona`) and eight board views configured per [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md). Create whatever is missing before proceeding.
2. **Create or confirm the Epic.** If the plan is part of a larger initiative, create one Epic issue using [`templates/epic-template.md`](../templates/epic-template.md), or confirm the existing Epic it belongs to.
3. **Create issues for each task.** For each task in the plan, create an issue using [`templates/engineering-task-template.md`](../templates/engineering-task-template.md) (or [`templates/technical-debt-template.md`](../templates/technical-debt-template.md) for debt items). Link it as a sub-issue of the Epic where one exists.
4. **Set all required fields on every issue**: `Priority`, `Risk`, `Size`, `Epic` (parent reference), `QA Required`, `Agent Persona`, and `Phase` = `Backlog`. Leave `Status` = `Backlog` until dependency mapping (next step) confirms it can move to `Ready`.
5. **Map dependencies.** For each issue, record what blocks it and what it blocks. Use "Blocked by #NNN" in the issue body and set `Blocked` = `Yes` on anything with an open upstream dependency.
6. **Set execution order.** Order unblocked issues by: unblocks-the-most-work first, then `Priority`, then `Risk`, then `Size` (see [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md#execution-ordering)). Move unblocked, fully-fielded issues from `Backlog` to `Ready`.
7. **Assign to a sprint** if sprint planning is happening now: set the `Sprint` field and confirm the sprint's total load is within observed team throughput.
8. **Confirm verification expectations** are stated on each issue (`QA Required` value, and a one-line note on how it will be verified) so [`commands/verify.md`](./verify.md) has a defined target later.

## Required Outputs

- Created/updated Epic and task issues, fully fielded, linked to the GitHub Project.
- A recorded dependency graph (visible via "Blocked by" references and the `Blocked` field, not only in a side document).
- Issues correctly placed in `Backlog` or `Ready` board views based on whether dependencies are clear.
- Sprint assignment, if applicable.

## Quality Gates

- No issue enters `Ready` with any of the ten required fields empty.
- No issue enters `Ready` while `Blocked` = `Yes`.
- Every issue has Given/When/Then acceptance criteria carried over from the plan — backlog does not rewrite acceptance criteria, it carries them forward.
- Every Epic has at least one child issue before it is considered actionable.

## Failure Handling

- **GitHub Project doesn't exist yet**: stop and run project initialization (step 1 above, or the full [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md)) before generating any issues.
- **A required field's allowed values don't fit the work** (e.g., risk doesn't cleanly fit Low/Medium/High/Critical): default to the more conservative (higher) value and note why in the issue, rather than leaving it blank.
- **Plan input is missing acceptance criteria for a task**: do not backfill acceptance criteria yourself from assumption — send the task back to [`commands/plan.md`](./plan.md).

## Example

**Input:**
> Plan from `commands/plan.md` example: 2 tasks (server-side validation, integration tests) under an implicit "harden contact form" scope, no existing Epic.

**Output (excerpt):**
```text
Created Epic #142: "Harden tfrs-website form and content pipeline"
  Priority: P1 | Risk: Medium | Size: L | Phase: Backlog | Status: Backlog

Created Issue #143 (child of #142): "Add server-side contact form validation"
  Priority: P1 | Risk: Medium | Size: S | QA Required: Yes
  Agent Persona: Implementer | Blocked: No | Phase: Backlog → Ready

Created Issue #144 (child of #142): "Add integration tests for contact
form validation boundary"
  Blocked by #143 | Blocked: Yes | Status: Backlog (held until #143 lands
  since they ship in the same PR per the plan's PR breakdown)

Execution order: #143 first (unblocks #144). #144 remains in Backlog,
not Ready, until #143 is implemented in the same PR.
```
