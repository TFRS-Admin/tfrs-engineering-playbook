<!-- Purpose: Define the canonical operating model every AI agent follows when it enters a TFRS repository. -->
# TFRS AI Agent Operating Model

## Purpose

[`AGENTS.md`](./AGENTS.md) defines baseline conventions (naming, style, commits, branch prefixes). This document defines the **operating loop**: what an agent does from the moment it starts a session in a repository that has adopted this playbook, to the moment it stops. Every future TFRS repository should be usable by an AI agent that has read only this file plus the repository's own README.

## Architecture

This playbook is repository-centered:

```text
Repository-local guidance
        ↓
Repository engineering documentation
        ↓
Work-item files (docs/engineering/backlog/*.md)
        ↓
TFRS Engineering Playbook
        ↓
TFRS-Admin/agent-skills
```

**Repository-local documentation and work-item files are the operational source of truth.** There is no GitHub Project, no GitHub Issue tracking work state, and no separate "current sprint" or "backlog index" file — each work item's own `## Metadata` block, defined in [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md), is authoritative for that item. Everywhere this document previously said "read the GitHub Project" or "read the issue," it now means "read the repository's `docs/engineering/` files and the relevant work-item file's `## Metadata` block."

## 1. Session Initialization Protocol

This is how every AI engineering session begins, whether it's triggered by an explicit work-item filename or by a plain-language request like *"implement the next ready work item in `tfrs-website`"*. **Plain-language requests are expected, not an edge case** — the agent is responsible for routing them, not the user. Do this in order, and don't skip a step because a request "seems" execution-only:

1. **Read local repository guidance first.** The target repository's own `README.md` and any repository-specific instructions — these can override this playbook per the precedence rule in [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md#precedence-on-conflict). If the repository's own guidance conflicts with what follows, the repository wins; note the conflict rather than silently picking a side.
2. **Read `AGENTS.md`.** Baseline conventions: naming, style, commit format, what agents must never do.
3. **Read `CLAUDE.md`.** Response style, planning-before-execution, PR conventions, and the Ask-vs-Proceed rule you'll need in step 9.
4. **Identify the current repository.** Confirm which repository the request is about and that it has actually adopted this playbook (see [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md)) — don't assume a repository is onboarded just because it's a TFRS repository; check.
5. **Read the repository's engineering documentation, then the relevant work-item file(s).** Read `docs/engineering/ROADMAP.md` for sequencing context, then glob `docs/engineering/backlog/*.md` for the relevant work items (each carries its own `## Metadata` block per [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md)). This is the full source of truth — no GitHub Project or Issue tracker to check.
6. **Determine the task category.** Every request is one of: *informational* (a question, no state change), *planning* (turning an idea into a strategy), *review* (assessing a diff or existing state), *execution* (implementing a specific work item), *verification* (proving a change works), or *release* (shipping). Use [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) to map a plain-language request to one of these categories. If the request sounds execution-shaped (e.g., "fix this bug") but no `Ready`, unblocked, acceptance-criteria-bearing work item exists yet, the category is actually *planning* first — see [`DECISION_ROUTER.md#forbidden-until-plannedbacklogged`](./DECISION_ROUTER.md#forbidden-until-plannedbacklogged).
7. **Select the correct workflow.** Once the category is known, `DECISION_ROUTER.md` names the [`commands/`](./commands/README.md) prompt(s) to run.
8. **Select the correct skill, if applicable.** Per [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md#skill-selection), most non-informational categories have a matching skill in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) to consult before executing.
9. **State assumptions; ask for approval before any state-changing action.** If routing or scope is ambiguous, say what you assumed rather than silently picking one. Reading code, work-item files, and this playbook is never state-changing and needs no approval; opening a branch, PR, or editing a work item's `## Metadata` block does — per [`CLAUDE.md`](./CLAUDE.md#when-to-ask-vs-when-to-proceed), proceed only when the task is clear, scoped, and consistent with these standards.

Do not re-derive information already recorded in these documents by re-reading the entire codebase. Trust the standards; verify only the specific work item you are working. Steps 6–8 above are the entry point into the per-item execution work — see [`commands/execute.md`](./commands/execute.md#issue-execution-protocol) for the detailed protocol once a specific `Ready` work item has been selected.

## 2. How to Determine Current Work

Current work is whatever the repository — its engineering docs and its work-item files — says it is, not what a prior chat message implied. To determine current state, in this order:

1. **`AGENTS.md`** — confirm baseline conventions haven't changed.
2. **`CLAUDE.md`** — confirm response/execution conventions haven't changed.
3. **`docs/engineering/backlog/*.md`** — glob for `Status: In Progress` or `Status: In Review` first — an agent should finish or hand off in-flight work before starting new work. If nothing is in flight, glob for `Status: Ready`.
4. **`docs/engineering/ROADMAP.md`** — broader sequencing context if the request is about what's coming, not what's ready now.
5. **This playbook's standards** — for anything the repository's own docs don't resolve (e.g., how `Priority` and `Risk` should order two competing `Ready` items).
6. **The relevant skill in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills)** — once the task type is known, per [`SKILLS_STANDARD.md#skill-selection`](./SKILLS_STANDARD.md#skill-selection).

If you were invoked with an explicit work-item filename, that takes precedence over scanning — but still read that file's `## Metadata` block to confirm its `Status` and `Blocked` values before acting, in case it's stale relative to reality.

## 3. How to Choose the Next Work Item

When multiple work items are `Ready`, choose using this order:

1. **`Blocked` = `No`** — never start work that is flagged blocked, even if it looks unblocked from the code.
2. **Highest `Priority`**, then highest `Risk` (resolve risk while there is runway), then smallest `Size` when priority and risk tie (see [`BACKLOG_STANDARD.md#execution-ordering`](./BACKLOG_STANDARD.md#execution-ordering)).

Both fields are read directly from the work item's `## Metadata` block per [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md). If no `Ready` item satisfies these constraints, stop and report that the backlog needs attention rather than inventing work.

## 4. When to Stop

Stop and hand control back to the operator when any of the following is true:

- The acceptance criteria are ambiguous or contradictory.
- Completing the work item would require changing architecture, security posture, or a cross-repository convention not already documented.
- A dependency you did not know about surfaces mid-implementation (undocumented `Blocked` state).
- You have completed the acceptance criteria and produced verification evidence — stop and open the PR; do not keep "improving" beyond scope.
- You have hit the same failure twice after attempting a fix — a third blind attempt is not more likely to work; escalate instead (see [`RULESET.md`](./RULESET.md) rule 7).

Stopping is not failure. An agent that stops with a clear, documented reason is more valuable than one that guesses past a real blocker.

## 5. How to Update State

The repository — work-item files and `docs/engineering/` files — is the source of truth; update it as state changes, not only at the end:

1. Move the work item's `## Metadata` `Status` line when you start (`Ready` → `In Progress`), when you open a PR (`In Progress` → `In Review`), and when QA is required (`In Review` → `QA`).
2. Set `Blocked` to `Yes` immediately when you hit a blocker, with a note in the file explaining what is needed — do not silently pause.
3. Reference the work item's filename in every commit, via the `work-item:` trailer defined in [`RULESET.md`](./RULESET.md), and in the PR description.
4. Move `Status` to `Done` only after merge — never mark an item `Done` without a merged PR behind it.
5. Update `docs/engineering/ROADMAP.md` when an Epic's scope or sequencing changes.
6. Never let a chat-only status update substitute for a repository update. If it did not happen in the work-item file or the repository's engineering docs, it did not happen.

## 6. How to Document Evidence

Every claim of "this works" must be backed by evidence attached to the PR or work-item file, not asserted in prose:

1. Use [`commands/verify.md`](./commands/verify.md) and [`templates/verification-report-template.md`](./templates/verification-report-template.md) to produce the evidence artifact.
2. Evidence is command output, test results, or a description of the exact manual steps taken and observed — never "should work" or "looks correct."
3. Attach the verification report to the PR before requesting review, and paste its result into the work item's `## Verification` section before moving `Status` to `Done`.
4. If a criterion could not be verified (no test infrastructure, no way to reproduce), say so explicitly in the report rather than omitting it.

## 7. How to Avoid Scope Expansion

1. Treat the work item's acceptance criteria as the complete definition of "done" — not a starting point for adjacent improvements.
2. If you notice an unrelated bug or improvement while working, do not fix it inline. File it as a new work item using [`templates/engineering-task-template.md`](./templates/engineering-task-template.md) and link it from your PR description as a follow-up.
3. When in doubt whether something is in scope, it is out of scope. Ask (per [`CLAUDE.md`](./CLAUDE.md#when-to-ask-vs-when-to-proceed)) rather than deciding unilaterally.

## 8. Command Sequencing

Commands don't invoke each other automatically — a human, or the command/phase an agent is currently running, drives the sequence. An agent running [`commands/execute.md`](./commands/execute.md) does not spawn a verification pass mid-task to check its own work — it finishes execution, updates state, and hands off; a separate invocation of [`commands/verify.md`](./commands/verify.md) picks it up next. This mirrors a hard platform constraint on Claude Code specifically (subagents cannot spawn other subagents), but the rule applies regardless of which agent is operating.

## Summary Loop

```text
Read standards → Read repo docs & work items → Pick next item → Update state (start)
  → Implement within acceptance criteria → Verify with evidence
  → Update state (PR opened) → Stop or hand off → Update state (merged)
```

This loop applies identically whether the acting agent is Claude Code, GitHub Copilot, or a future agent — the model is agent-agnostic by design. The "Implement within acceptance criteria → Verify with evidence" steps have their own detailed sub-procedure — the skill-consultation workflow in [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md#the-skill-consultation-workflow) — for exactly how to bring [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) into a given task; this loop doesn't restate that detail.

## Related Documents

- [`AGENTS.md`](./AGENTS.md) — baseline conventions
- [`CLAUDE.md`](./CLAUDE.md) — Claude-specific response and PR conventions
- [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md) — the field vocabulary this document reads and updates on every work item
- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) — how work enters the state this model operates on
- [`commands/execute.md`](./commands/execute.md), [`commands/verify.md`](./commands/verify.md), and [`commands/ship.md`](./commands/ship.md) — the executable procedures this model governs
- [`RULESET.md`](./RULESET.md) — the operating rules this model's loop runs inside
- [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md) — the skill-consultation workflow nested inside this model's Summary Loop
