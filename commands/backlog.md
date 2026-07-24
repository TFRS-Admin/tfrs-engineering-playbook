<!-- Purpose: Executable procedure for converting an approved plan into work-item files and roadmap sections. -->
# Command: Backlog

## Purpose

This is the executable version of [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) — the step-by-step procedure that closes the gap between planning and implementation by turning a plan into real, tracked work-item files, each carrying a `## Metadata` block, with the result reflected in `docs/engineering/ROADMAP.md`.

## When to Use It

- Immediately after [`commands/plan.md`](./plan.md) produces an approved task breakdown.
- When initializing a backlog for a new repository (see [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md)).
- When a [`commands/repo-health.md`](./repo-health.md) finding needs to become tracked work.
- When a bug fix has no existing `Ready` work-item file — per [`DECISION_ROUTER.md#forbidden-until-plannedbacklogged`](../DECISION_ROUTER.md#forbidden-until-plannedbacklogged), even a small, obvious fix passes through this command before [`commands/execute.md`](./execute.md) can run against it.

## Required Inputs

- An approved plan (task breakdown, acceptance criteria, risks, dependencies) from [`commands/plan.md`](./plan.md).
- The target repository and its `docs/engineering/` files.

## Required Skill Consultation

Check for `skills/tfrs/backlog-initialization` in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) first — a TFRS-specific skill wins when one exists. As of this writing it does not exist in the fork yet (see [`SKILLS_STANDARD.md#skill-selection`](../SKILLS_STANDARD.md#skill-selection)); until it does, follow this command and [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) directly.

## Workflow

1. **Confirm repository readiness.** Verify `docs/engineering/ROADMAP.md` and `docs/engineering/backlog/` exist (create from the templates in [`templates/README.md#repository-engineering-docs`](../templates/README.md#repository-engineering-docs) if missing).
2. **Confirm or create the Epic.** An Epic is a `## Epic:` section in `docs/engineering/ROADMAP.md`, per [`templates/engineering-roadmap-template.md`](../templates/engineering-roadmap-template.md) — never a file of its own. For a single-item plan with no larger initiative, use `Epic: None`.
3. **Create a work-item file for each task** in the plan, using [`templates/engineering-task-template.md`](../templates/engineering-task-template.md), at `docs/engineering/backlog/<EPIC>-<NN>-<kebab-slug>.md`. This one template covers features, bugs, and technical debt alike.
4. **Set the complete `## Metadata` block on every file** per [`WORK_ITEM_METADATA_STANDARD.md`](../WORK_ITEM_METADATA_STANDARD.md): `Status`, `Priority`, `Risk`, `Size`, `Epic`, `Blocked`, `QA Required`. Leave `Status: Backlog` until dependency mapping (next step) confirms it can move to `Ready`.
5. **Map dependencies.** For each work item, record what blocks it and what it blocks in the `## Dependencies` section, using the blocking/blocked item's filename. Set `Blocked: Yes` in the `## Metadata` block on anything with an open upstream dependency.
6. **Set execution order.** Order unblocked items by: unblocks-the-most-work first, then `Priority`, then `Risk`, then `Size` (see [`BACKLOG_STANDARD.md#execution-ordering`](../BACKLOG_STANDARD.md#execution-ordering)). Move unblocked, fully-fielded items from `Status: Backlog` to `Status: Ready`. There's no separate index to write this order into — it's read directly off the files.
7. **Update `docs/engineering/ROADMAP.md`** if a new Epic or initiative was introduced — this step is required, not optional.
8. **Confirm verification expectations** are stated in each file's `## Verification` section (`QA Required` value, and a one-line note on how it will be verified) so [`commands/verify.md`](./verify.md) has a defined target later.

## Required Outputs

- Created/updated work-item files, each with a complete `## Metadata` block, at `docs/engineering/backlog/`.
- A recorded dependency graph (via `Blocked by <filename>` references and the `Blocked` field in each file).
- `docs/engineering/ROADMAP.md` updated if a new Epic was introduced.

## Quality Gates

- No work item enters `Ready` with any `## Metadata` field empty.
- No work item enters `Ready` while `Blocked: Yes`.
- Every work item has Given/When/Then acceptance criteria carried over from the plan — backlog does not rewrite acceptance criteria, it carries them forward.

## Failure Handling

- **Repository engineering docs don't exist yet**: stop and create them from the templates in [`templates/README.md#repository-engineering-docs`](../templates/README.md#repository-engineering-docs) (or run the full [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md)) before generating any work items.
- **A required field's allowed values don't fit the work** (e.g., risk doesn't cleanly fit Low/Medium/High/Critical): default to the more conservative (higher) value and note why in the file, rather than leaving it blank.
- **Plan input is missing acceptance criteria for a task**: do not backfill acceptance criteria yourself from assumption — send the task back to [`commands/plan.md`](./plan.md).

## Example

**Input:**
> Plan from `commands/plan.md` example: 2 tasks (server-side validation, integration tests) under an implicit "harden contact form" scope, no existing Epic.

**Output (excerpt):**
```text
Added Epic section "Harden tfrs-website form and content pipeline" to
docs/engineering/ROADMAP.md.

Created docs/engineering/backlog/FORM-01-add-server-side-contact-form-validation.md
  Priority: P1 | Risk: Medium | Size: S | QA Required: Yes
  Blocked: No | Status: Backlog → Ready

Created docs/engineering/backlog/FORM-02-add-contact-form-validation-tests.md
  Blocked by FORM-01-add-server-side-contact-form-validation.md
  Blocked: Yes | Status: Backlog (held until FORM-01 lands, since they
  ship in the same PR per the plan's PR breakdown)

Execution order: FORM-01 first (unblocks FORM-02).
```
