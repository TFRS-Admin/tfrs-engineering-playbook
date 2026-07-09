<!-- Purpose: Executable procedure for implementing a single Ready issue. -->
# Command: Execute

## Purpose

Implement a single `Ready` issue: the smallest safe change that satisfies its acceptance criteria, tracked correctly in GitHub the whole way through. This is the executable counterpart to [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md).

## When to Use It

- You (an AI agent or human) have picked up a `Ready` issue per [`AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-issue).
- Never use this command on an issue whose `Blocked` field is `Yes`, or that lacks acceptance criteria — send it back to [`commands/backlog.md`](./backlog.md) or [`commands/plan.md`](./plan.md) instead.

## Required Inputs

- Issue number/link with acceptance criteria and all required project fields set (or, absent a real GitHub Project, the equivalent structured text in the issue body — see [`AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol`](../AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol)).
- Any linked plan document for broader context.
- Repository-specific `AGENTS.md`/`CLAUDE.md` conventions.

## Required Skill Consultation

Mandatory per [`SKILLS_STANDARD.md#when-consultation-is-mandatory`](../SKILLS_STANDARD.md#when-consultation-is-mandatory): consult [`skills/incremental-implementation`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/incremental-implementation) and [`skills/test-driven-development`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/test-driven-development) in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) before implementing — this playbook's [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md) sets TFRS's thresholds (branch prefixes, commit format, PR size cap); the skills define the vertical-slicing and red-green-refactor mechanics this playbook doesn't restate.

## Issue Execution Protocol

1. **Read the issue** and its acceptance criteria in full.
2. **Read the parent epic**, if one exists, for the broader context and scope boundary the issue was cut from.
3. **Read linked dependencies** — anything the issue states it's blocked by or blocks.
4. **Confirm the issue is `Ready` and unblocked, or stop and explain why it isn't.** Never proceed on an issue that is `Blocked`, lacks acceptance criteria, or hasn't passed through [`commands/plan.md`](./plan.md) and [`commands/backlog.md`](./backlog.md) — per [`DECISION_ROUTER.md#forbidden-until-plannedbacklogged`](../DECISION_ROUTER.md#forbidden-until-plannedbacklogged), this is forbidden, not just discouraged. This applies identically whether the request was phrased as "implement issue #N" or "fix this bug" — a bug report with no `Ready` tracking issue is not yet executable, full stop.
5. **Inspect the related code** the issue actually touches before writing anything — confirm the issue's description still matches current reality; if it doesn't, stop and send it back to [`commands/plan.md`](./plan.md) rather than reinterpreting scope yourself.
6. **Identify the acceptance criteria** as a checklist you will verify against — restate them if the issue's phrasing is ambiguous, and ask rather than guess if restating doesn't resolve the ambiguity.
7. **Identify the verification commands** you'll run before this is done (test command, build command, manual steps) — know this before writing code, not after.
8. **Set the project item `Status` to `In Progress`** immediately — before writing code, not after — and create a branch using the prefix conventions in [`AGENTS.md`](../AGENTS.md) (`feature/`, `fix/`, `docs/`, `chore/`), named after the issue.
9. **Implement the smallest safe change** that satisfies the acceptance criteria — nothing more (see [`AI_AGENT_OPERATING_MODEL.md#7-how-to-avoid-scope-expansion`](../AI_AGENT_OPERATING_MODEL.md#7-how-to-avoid-scope-expansion)) — as a thin vertical slice per [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md#incremental-implementation), writing the test with the implementation per [`TESTING_STANDARD.md`](../TESTING_STANDARD.md). If anything breaks unexpectedly, follow the stop-the-line sequence in [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md#debugging-error-recovery-and-blockers) before continuing. Commit using Conventional Commits, referencing the issue number, in a reviewable sequence (scaffold → implementation → validation/docs, per [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md)).
10. **Run verification** using the commands identified in step 7 — this is [`commands/verify.md`](./verify.md), run before opening the PR, never skipped because "it's a small change."
11. **Capture evidence** per [`commands/verify.md`](./verify.md) and attach it — open the PR using [`.github/PULL_REQUEST_TEMPLATE.md`](../.github/PULL_REQUEST_TEMPLATE.md), link the issue, attach the verification report, and set the project item `Status` to `In Review` (or `QA` if `QA Required` = `Yes`).
12. **Update the issue/project one final time to reflect reality, then stop.** Do not keep working past this point on the same invocation — per [`AI_AGENT_OPERATING_MODEL.md#4-when-to-stop`](../AI_AGENT_OPERATING_MODEL.md#4-when-to-stop).

## Forbidden

- **Implementing multiple unrelated issues in one pass.** One invocation of this command executes exactly one issue. A second issue — even a trivial one noticed along the way — gets its own issue and its own invocation.
- **Opportunistic refactors.** Anything not required by the acceptance criteria is out of scope, full stop — file it per [`AI_AGENT_OPERATING_MODEL.md#7-how-to-avoid-scope-expansion`](../AI_AGENT_OPERATING_MODEL.md#7-how-to-avoid-scope-expansion) instead of folding it in.
- **Closing an issue without verification.** No exceptions, including for changes that "obviously work."
- **Treating chat as the source of truth.** If it isn't reflected on the GitHub issue/Project, it didn't happen — a chat summary of what was done is not a substitute for step 12.

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
