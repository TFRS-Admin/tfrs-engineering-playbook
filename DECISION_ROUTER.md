<!-- Purpose: Map plain-language user requests to the correct playbook workflow, so an agent never has to guess which command to run. -->
# TFRS Decision Router

## Purpose

An agent should be able to take a plain-language request — *"implement the next ready work item in `tfrs-website`"*, *"the app is slow"*, *"ship this PR"* — and know exactly which [`commands/`](./commands/README.md) prompt to run, without relying on chat history or unstated assumptions. This document is that routing table. It is consulted at step 6–7 of the [Session Initialization Protocol](./AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol); it does not restate that protocol or any command's own workflow.

## Routing Table

| User Request Type | Default Workflow |
| --- | --- |
| "Review this PR" | [`RULESET.md`](./RULESET.md) (self-review against the ruleset; not `commands/review.md` — see the Terminology Map below) |
| "Review this repo" | [`commands/repo-health.md`](./commands/repo-health.md) if it's a general on-demand check; [`commands/review.md`](./commands/review.md) if it's scoped to a specific area or triggered by upcoming work |
| "Plan this feature" | [`commands/plan.md`](./commands/plan.md) |
| "Build this feature" | [`commands/plan.md`](./commands/plan.md) → [`commands/backlog.md`](./commands/backlog.md) → [`commands/execute.md`](./commands/execute.md) — the full chain, not a shortcut to Execute |
| "Implement work item `<EPIC>-<NN>-<slug>.md`" | [`commands/execute.md`](./commands/execute.md) directly — **only if the file is `Ready` and unblocked**; see [Forbidden Until Planned/Backlogged](#forbidden-until-plannedbacklogged) below |
| "Fix this bug" | If a `Ready`, unblocked work-item file already exists for this bug, route straight to [`commands/execute.md`](./commands/execute.md). **Otherwise there is no shortcut**, regardless of how small the fix looks: [`commands/review.md`](./commands/review.md) to establish root cause → [`commands/plan.md`](./commands/plan.md) (even a one-task plan for an obvious fix) → [`commands/backlog.md`](./commands/backlog.md) to create the actual work-item file with acceptance criteria → then [`commands/execute.md`](./commands/execute.md). "Small and obvious" shortens how long Plan and Backlog take — it never skips them. |
| "The app is slow" | [`commands/review.md`](./commands/review.md) *before* any implementation — performance claims need evidence (reproduce and measure) before a fix is planned, not after |
| "Make the code cleaner" | [`commands/repo-health.md`](./commands/repo-health.md) → file as backlog via [`commands/backlog.md`](./commands/backlog.md), **not** an immediate refactor — see [`AI_AGENT_OPERATING_MODEL.md#7-how-to-avoid-scope-expansion`](./AI_AGENT_OPERATING_MODEL.md#7-how-to-avoid-scope-expansion) |
| "Ship this PR" | [`commands/verify.md`](./commands/verify.md) → [`commands/ship.md`](./commands/ship.md), in that order — never skip straight to merge |
| "What's next?" | Evaluate, in order: (1) [`AGENTS.md`](./AGENTS.md), (2) [`CLAUDE.md`](./CLAUDE.md), (3) work-item files under `docs/engineering/backlog/` (each carrying its own `## Metadata` block per [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md) — glob for `Status: Ready`), (4) `docs/engineering/ROADMAP.md` — this is the same order defined in [`AI_AGENT_OPERATING_MODEL.md#2-how-to-determine-current-work`](./AI_AGENT_OPERATING_MODEL.md#2-how-to-determine-current-work). Recommend the next `Ready`, unblocked item per [`AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-work-item`](./AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-work-item) — this is informational; don't start implementing without a separate explicit go-ahead |
| "Turn this review/plan into tracked work" | [`commands/backlog.md`](./commands/backlog.md) |
| "Update the playbook" | [`commands/plan.md`](./commands/plan.md) → [`commands/execute.md`](./commands/execute.md) → [`commands/verify.md`](./commands/verify.md), same as any other repository — this repository is not exempt from its own lifecycle |

## Terminology Map

"Review" means two different things depending on whether it's the command or the ruleset:

| Word | TFRS meaning here | Where it lives | Note |
| --- | --- | --- | --- |
| **Review** (discovery) | Assess current state and produce findings *before* planning new work | [`commands/review.md`](./commands/review.md) | Runs at the *start* of the lifecycle |
| **Review** (PR/code) | Self-check a diff against [`RULESET.md`](./RULESET.md) before shipping | [`RULESET.md`](./RULESET.md) | Runs near the *end* of the lifecycle — same word, opposite end |
| **Plan** | Turn an approved finding/Epic into a sized implementation strategy | [`commands/plan.md`](./commands/plan.md) | |
| **Verify** | Produce evidence that an implementation satisfies its acceptance criteria, as a discrete gate before Ship | [`commands/verify.md`](./commands/verify.md) | Its own explicit command rather than folded into build-time testing, because `QA Required` needs a discrete artifact to point to |
| **Backlog** | Convert a plan into work-item files, each carrying a `## Metadata` block, and `docs/engineering/ROADMAP.md` sections | [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) | |

## Ambiguity Handling

- If a request could map to more than one row (e.g., "review this" without saying PR or repo), ask which is meant rather than guessing — the two rows have materially different scope and one runs against a diff, the other against the whole repository.
- If a request names a work-item file that doesn't exist, is already `Done`, or is `Blocked`, say so and stop rather than silently picking the nearest match.
- If a request implies urgency ("just ship it," "quickly fix") that would skip a required gate (verification, planning for non-trivial work), name the gate being asked to skip explicitly and ask for confirmation — don't skip it silently, and don't refuse silently either.

## Approval Checkpoints

State-changing actions always get an explicit checkpoint before or immediately as they happen — reading, searching, and reasoning never require one:

- **Before opening a branch or PR** — confirm the target work item is `Ready` and unblocked (or explain why it isn't, per [`commands/execute.md`](./commands/execute.md)).
- **Before merging** — per [`commands/ship.md`](./commands/ship.md), never implicit in "ship this."
- **Before any action affecting a shared resource** outside the specific repository (playbook-wide standard changes, changes to a repository's `docs/engineering/` structure or work-item Metadata conventions) — always a human checkpoint, never routed to Execute unilaterally.

## When to Ask vs. Proceed vs. Refuse

- **Proceed** without asking when the request maps cleanly to one row above, the target work item (if any) is `Ready` and unblocked, and the action matches its acceptance criteria — per [`CLAUDE.md`](./CLAUDE.md#when-to-ask-vs-when-to-proceed).
- **Ask** when the request is ambiguous between rows, names a work item that isn't actually `Ready`, or would require skipping a gate (see Ambiguity Handling above).
- For anything execution-shaped ("fix this bug," "implement `<file>`," "build this feature"), whether to proceed or ask is downstream of one prior question: is there already a `Ready`, unblocked, acceptance-criteria-bearing work-item file for this work? If not, see below — this isn't an ask/proceed judgment call, it's a hard stop.

## Forbidden Until Planned/Backlogged

**Implementation is forbidden** — not just "ask first," but flatly not-yet-possible — until planning and backlog exist for the work in question. This applies uniformly regardless of how the request was phrased:

- No [`commands/execute.md`](./commands/execute.md) run against a work item with no acceptance criteria.
- No [`commands/execute.md`](./commands/execute.md) run against work that only exists as a chat request, a bug report with no tracked work-item file, or a "Build this feature" ask that hasn't passed through [`commands/plan.md`](./commands/plan.md) and [`commands/backlog.md`](./commands/backlog.md) yet — see [`commands/backlog.md`](./commands/backlog.md) for what "passed through Backlog" actually requires (every field in the `## Metadata` block set per [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md), and `Blocked` = `No`).
- No [`commands/ship.md`](./commands/ship.md) run without a passing [`commands/verify.md`](./commands/verify.md) report attached.

This is the same rule [`commands/execute.md`](./commands/execute.md#issue-execution-protocol) enforces from the execution side (step 4: "confirm the work item is `Ready` and unblocked, or stop and explain why it isn't") — this section and that one are two views of one rule, not two rules.

## Related Documents

- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — the Session Initialization Protocol this router is consulted from
- [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md) — the work-item Metadata block this router's "What's next?" row reads
- [`commands/README.md`](./commands/README.md) — the full command library this table routes into
- [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md) — how to pick a skill once a workflow is selected
