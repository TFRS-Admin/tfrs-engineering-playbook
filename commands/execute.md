<!-- Purpose: Executable procedure for implementing a single Ready issue. -->
# Command: Execute

## Purpose

Implement a single `Ready` issue: the smallest safe change that satisfies its acceptance criteria, tracked correctly in GitHub the whole way through. This is the executable counterpart to [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md).

## When to Use It

- You (an AI agent or human) have picked up a `Ready` issue per [`AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-issue).
- Never use this command on an issue whose `Blocked` field is `Yes`, or that lacks acceptance criteria — send it back to [`commands/backlog.md`](./backlog.md) or [`commands/plan.md`](./plan.md) instead.

## Required Inputs

- Issue number/link with acceptance criteria and all required project fields set.
- Any linked plan document for broader context.
- Repository-specific `AGENTS.md`/`CLAUDE.md` conventions.

## Workflow

1. Read the issue and its acceptance criteria in full. Read the linked plan if one exists.
2. Set the project item `Status` to `In Progress` immediately — before writing code, not after.
3. Create a branch using the prefix conventions in [`AGENTS.md`](../AGENTS.md) (`feature/`, `fix/`, `docs/`, `chore/`), named after the issue.
4. Implement the smallest safe change that satisfies the acceptance criteria — nothing more (see [`AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md#7-how-to-avoid-scope-expansion)).
5. Run existing lint/tests locally as you go, not only at the end.
6. Commit using Conventional Commits, referencing the issue number, in a reviewable sequence (scaffold → implementation → validation/docs, per [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md)).
7. Run [`commands/verify.md`](./verify.md) before opening the PR.
8. Open the PR using [`.github/PULL_REQUEST_TEMPLATE.md`](../.github/PULL_REQUEST_TEMPLATE.md), link the issue, and attach the verification report.
9. Set the project item `Status` to `In Review` (or `QA` if `QA Required` = `Yes` and QA happens before code review in this repository's process).

## Required Outputs

- A branch with a reviewable commit sequence.
- An open PR referencing the issue, filled out per the PR template, with verification evidence attached.
- Correct project field updates (`Status` moved twice: to `In Progress` at start, to `In Review`/`QA` at PR open).

## Quality Gates

- The diff matches the acceptance criteria — no unrelated files, no drive-by refactors.
- PR is under the size guideline in [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md) (400 lines) or explicitly justified as tightly coupled.
- No secrets introduced.
- Verification evidence exists before the PR is marked ready for review.

## Failure Handling

- **Blocked mid-implementation** (undocumented dependency surfaces): set `Blocked` = `Yes` immediately, comment on the issue explaining what's needed, and stop — do not work around an undocumented dependency silently.
- **Acceptance criteria turn out to be wrong or untestable once you're in the code**: stop, comment on the issue, and send it back to [`commands/plan.md`](./plan.md) rather than reinterpreting criteria yourself.
- **Same failure recurs after a second fix attempt**: stop and escalate per [`AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md#4-when-to-stop) rather than attempting a third blind fix.

## Example

**Input:**
> Issue #143: "Add server-side contact form validation" — Ready, Blocked: No, acceptance criteria per the `commands/plan.md` example.

**Output (excerpt):**
```text
Status: Ready → In Progress
Branch: feature/143-contact-form-server-validation

Commits:
  1. chore(143): scaffold validation module
  2. feat(143): add server-side contact form validation matching client rules
  3. test(143): add integration tests for validation boundary

PR #201 opened: "Add server-side contact form validation (#143)"
  Verification report attached (see commands/verify.md example)
Status: In Progress → In Review
```
