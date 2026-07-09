<!-- Purpose: Define the end-to-end AI-assisted delivery workflow used by TFRS projects. -->
# TFRS AI Engineering Workflow

## Purpose

This workflow describes how TFRS moves from idea to shipped software using a human-led, AI-assisted model. It aligns repository planning, GitHub tracking, implementation, review, and retrospective learning. To route a specific plain-language request to a phase below, use [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) rather than guessing from this table alone.

## Workflow Overview

| Phase | Human Responsibilities | AI Responsibilities | Inputs | Outputs | Definition of Done |
| --- | --- | --- | --- | --- | --- |
| Idea | Clarify the problem, business value, and constraints | Help shape options and capture assumptions | Customer need, issue request, context | Draft problem statement | Problem is clear enough to estimate |
| Plan | Break work into issues, define acceptance criteria, assign priority | Propose scope, risks, and implementation checklist | Problem statement, existing standards | Approved issue or plan | Issue has acceptance criteria and owner |
| Backlog | Approve GitHub Project structure, priority, and sequencing | Convert the plan into Epics/Issues, map dependencies, set execution order | Approved plan, [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) fields | Fully-fielded, dependency-ordered GitHub issues | Every issue is `Ready` with no empty required field |
| Build | Approve direction, answer blockers, review progress | Implement focused changes, update docs, run checks | Approved issue, repo code, playbook | Branch commits and PR draft | Change matches acceptance criteria |
| Review | Review logic, UX, security, and maintainability | Self-review, summarize diffs, surface trade-offs | PR diff, test results | Review comments and approvals | Required approvals complete |
| Ship | Merge, release, communicate downstream impact | Verify release notes and follow-up checklist | Approved PR, release decision | Merged code and rollout note | Default branch updated cleanly |
| Reflect | Capture lessons and update standards | Summarize what should be standardized next | Delivered work, incidents, review notes | ADRs, playbook updates, backlog items | Improvement action is recorded |

Historically this repository had no defined phase between `Plan` and `Build` — plans existed as documents or chat output with no required path into tracked, executable GitHub work. `Backlog` closes that gap; see [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) for the full standard and [`commands/backlog.md`](./commands/backlog.md) for the executable procedure.

## GitHub Integration Flow

The standard TFRS path is:

1. **Issue** created using the repository template in [`.github/ISSUE_TEMPLATE`](./.github/ISSUE_TEMPLATE/), or generated during the Backlog phase from an approved plan (see [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md)).
2. **Project Board** entry created and prioritized using [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md), with all required fields set and dependencies mapped before the item reaches `Ready`.
3. **Branch** created according to [`AGENTS.md`](./AGENTS.md) and [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md).
4. **Pull Request** opened with [`.github/PULL_REQUEST_TEMPLATE.md`](./.github/PULL_REQUEST_TEMPLATE.md) and a verification report from [`commands/verify.md`](./commands/verify.md) attached.
5. **Merge** after review against [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md), via [`commands/ship.md`](./commands/ship.md).

Every phase above has a corresponding executable prompt in the [`commands/`](./commands/README.md) library — use those prompts to run the phase rather than improvising it from this table alone. For the step-by-step execution mechanics inside any given phase, consult the matching skill in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) per [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md) — this table and the `commands/` library define *what phase* work is in and *what's required*; the skills fork defines *how* to execute within it.

## Terminology Map

TFRS's engineering methodology synthesizes practices from the `agent-skills` reference methodology (see [`README.md`](./README.md#engineering-methodology-lineage)). The two use several of the same words for different lifecycle points — this table exists so that never causes real confusion:

| Word | TFRS meaning here | Where it lives | Note |
| --- | --- | --- | --- |
| **Review** (discovery) | Assess current state and produce findings *before* planning new work | [`commands/review.md`](./commands/review.md) | Runs at the *start* of the lifecycle |
| **Review** (PR/code) | The approval bar for merging a specific diff, right before Ship | [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md) | Runs near the *end* of the lifecycle — same word, opposite end |
| **Plan** | Turn an approved finding/Epic into a sized implementation strategy | [`commands/plan.md`](./commands/plan.md), [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md) | Consistent with the reference methodology's "Plan" |
| **Verify** | Produce evidence that an implementation satisfies its acceptance criteria, as a discrete gate before Ship | [`commands/verify.md`](./commands/verify.md) | TFRS keeps this as its own explicit command producing an attachable evidence artifact, rather than folding it entirely into build-time testing, because [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md)'s `QA Required` field needs a discrete artifact to point to |
| **Backlog** | Convert a plan into GitHub Projects, Epics, and Issues | [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) | Net-new phase this playbook added in v2.0.0; has no direct equivalent since the reference methodology isn't built around a project-management system |

If you only remember one row: **"Review" means two different things depending on whether it's the command or the standard** — `commands/review.md` looks backward at existing state before anything is planned, `REVIEW_STANDARD.md` looks at a finished diff before it merges.

## Phase Guidance

### Idea

- Humans own problem framing and business priority.
- AI can suggest missing requirements, edge cases, and similar prior work — and should surface its assumptions explicitly (an `Assumptions:` block) rather than silently guessing at scope; ask a targeted clarifying question when genuinely unsure rather than proceeding on a guess, per [`CLAUDE.md`](./CLAUDE.md#when-to-ask-vs-when-to-proceed).
- Definition of done: a clear statement of what success looks like.

### Plan

- Humans choose scope and trade-offs.
- AI drafts tasks, acceptance criteria, and implementation sequencing.
- Definition of done: linked issue, clear labels, and board placement.

### Build

- Humans stay available for scope questions.
- AI writes code, tests, docs, and incremental summaries.
- Definition of done: targeted verification is complete and documented.

### Review

- Humans validate correctness, safety, and maintainability.
- AI highlights risky files, missing tests, and unresolved assumptions.
- Definition of done: review checklist passed and approvals recorded.

### Ship

- Humans own merge timing, release timing, and stakeholder communication.
- AI prepares release notes, migration notes, and follow-up tickets.
- Definition of done: merged PR with no unresolved blockers.

### Reflect

- Humans decide what becomes a standard.
- AI converts repeatable lessons into playbook updates, prompts, or ADRs.
- Definition of done: learning is captured in a reusable artifact.

## AI Prompt Templates

### Planning Prompt

**When to use:** turning an issue into an execution plan.

```text
You are planning work for a TFRS repository.
Goal: {{goal}}
Constraints: {{constraints}}
Acceptance criteria: {{acceptance_criteria}}
Please produce a checklist plan, risks, unknowns, and a suggested PR breakdown.
```

### Coding Prompt

**When to use:** implementing a scoped issue.

```text
Implement the smallest safe change for this TFRS repository.
Issue: {{issue_summary}}
Files likely involved: {{files}}
Standards to follow: AGENTS.md, CLAUDE.md, EXECUTION_STANDARD.md, REVIEW_STANDARD.md
Validation required: {{validation_steps}}
```

### Review Prompt

**When to use:** self-reviewing or peer-reviewing an AI-assisted PR.

```text
Review this pull request against TFRS standards.
Focus on functionality, tests, security, docs, and scope control.
Diff summary: {{diff_summary}}
Known risks: {{known_risks}}
Return only actionable findings.
```

These three prompts are quick-reference starting points. For the full executable procedure — required inputs, workflow, outputs, quality gates, and failure handling — for every phase of the lifecycle, use the [`commands/`](./commands/README.md) library instead.
