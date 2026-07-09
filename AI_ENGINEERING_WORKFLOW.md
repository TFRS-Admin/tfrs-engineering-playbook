<!-- Purpose: Define the end-to-end AI-assisted delivery workflow used by TFRS projects. -->
# TFRS AI Engineering Workflow

## Purpose

This workflow describes how TFRS moves from idea to shipped software using a human-led, AI-assisted model. It aligns repository planning, GitHub tracking, implementation, review, and retrospective learning.

## Workflow Overview

| Phase | Human Responsibilities | AI Responsibilities | Inputs | Outputs | Definition of Done |
| --- | --- | --- | --- | --- | --- |
| Idea | Clarify the problem, business value, and constraints | Help shape options and capture assumptions | Customer need, issue request, context | Draft problem statement | Problem is clear enough to estimate |
| Plan | Break work into issues, define acceptance criteria, assign priority | Propose scope, risks, and implementation checklist | Problem statement, existing standards | Approved issue or plan | Issue has acceptance criteria and owner |
| Build | Approve direction, answer blockers, review progress | Implement focused changes, update docs, run checks | Approved issue, repo code, playbook | Branch commits and PR draft | Change matches acceptance criteria |
| Review | Review logic, UX, security, and maintainability | Self-review, summarize diffs, surface trade-offs | PR diff, test results | Review comments and approvals | Required approvals complete |
| Ship | Merge, release, communicate downstream impact | Verify release notes and follow-up checklist | Approved PR, release decision | Merged code and rollout note | Default branch updated cleanly |
| Reflect | Capture lessons and update standards | Summarize what should be standardized next | Delivered work, incidents, review notes | ADRs, playbook updates, backlog items | Improvement action is recorded |

## GitHub Integration Flow

The standard TFRS path is:

1. **Issue** created using the repository template in [`.github/ISSUE_TEMPLATE`](./.github/ISSUE_TEMPLATE/).
2. **Project Board** entry created and prioritized using [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md).
3. **Branch** created according to [`AGENTS.md`](./AGENTS.md) and [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md).
4. **Pull Request** opened with [`.github/PULL_REQUEST_TEMPLATE.md`](./.github/PULL_REQUEST_TEMPLATE.md).
5. **Merge** after review against [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md).

## Phase Guidance

### Idea

- Humans own problem framing and business priority.
- AI can suggest missing requirements, edge cases, and similar prior work.
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
