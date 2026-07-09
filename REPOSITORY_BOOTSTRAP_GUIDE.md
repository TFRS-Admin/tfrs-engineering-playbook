<!-- Purpose: Define how every new or existing TFRS repository adopts this playbook end-to-end, worked through a real repository. -->
# TFRS Repository Bootstrap Guide

## Purpose

This is the canonical, ordered procedure for bringing a repository — new or existing — fully onto the TFRS engineering operating system. It is the single document that ties together repository creation, playbook adoption, GitHub Project setup, and the first pass through the full engineering lifecycle.

## The Bootstrap Lifecycle

```text
Create Repository
      ↓
Copy Playbook
      ↓
Create GitHub Project
      ↓
Run Review
      ↓
Run Plan
      ↓
Initialize Backlog
      ↓
Begin Execution
```

Each step below states what to do and which standard governs it. Do not skip a step because the repository "already has code" — an existing repository being onboarded still needs the Review step, since Review is how the playbook discovers what's already there.

### 1. Create Repository

Use [`templates/new-repo-checklist.md`](./templates/new-repo-checklist.md):

- Create the repository with a clear name, description, and visibility.
- Protect `main` with required pull requests and status checks.
- Add repository topics matching the product domain.

### 2. Copy Playbook

- Copy or reference the baseline files: [`AGENTS.md`](./AGENTS.md), [`CLAUDE.md`](./CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md), [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md), [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md), [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md), and [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md).
- Copy the `.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md`, and `templates/` directory contents relevant to the repository's stack.
- Add a README section naming this repository (`tfrs-engineering-playbook`) as the engineering source of truth, and record the adopted playbook version from [`VERSION.md`](./VERSION.md).
- See [`commands/setup-from-playbook.md`](./commands/setup-from-playbook.md) for the step-by-step adoption procedure.

### 3. Create GitHub Project

Follow [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md):

- Create the project and attach the repository.
- Create all ten required custom fields (`Status`, `Phase`, `Priority`, `Risk`, `Size`, `Sprint`, `Epic`, `QA Required`, `Blocked`, `Agent Persona`).
- Create the eight required board views (Roadmap, Backlog, Ready, In Progress, Review, QA, Release, Completed).

### 4. Run Review

Use [`commands/review.md`](./commands/review.md) against the repository's current state (existing code for an onboarding repository; the intended domain for a greenfield repository). Produce findings — do not fix anything yet.

### 5. Run Plan

Use [`commands/plan.md`](./commands/plan.md) to turn approved findings and initial priorities into implementation strategies with acceptance criteria, per [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md).

### 6. Initialize Backlog

Use [`commands/backlog.md`](./commands/backlog.md) and [`templates/backlog-initialization-template.md`](./templates/backlog-initialization-template.md) to convert plans into Epics and Issues on the GitHub Project, with dependencies mapped and execution order set, per [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md).

### 7. Begin Execution

Use [`commands/execute.md`](./commands/execute.md), followed by [`commands/verify.md`](./commands/verify.md) and [`commands/ship.md`](./commands/ship.md), for every issue that reaches `Ready`. From here the repository runs the standing operating loop described in [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md).

## Worked Example: `tfrs-website`

`tfrs-website` is the repository whose implementation surfaced the original gap this playbook closes — the team had Review and Plan artifacts for the site but no defined path from those artifacts into GitHub execution. Here is how the bootstrap lifecycle applies to it end-to-end.

**1. Create Repository** — `tfrs-website` already existed as an active repository, so this step was a confirmation pass: branch protection on `main` was already in place; repository topics (`website`, `marketing`, `javascript`) were added where missing.

**2. Copy Playbook** — `AGENTS.md`, `CLAUDE.md`, `AI_AGENT_OPERATING_MODEL.md`, and the execution/review/planning standards were added to `tfrs-website` under a short README section: *"This repository follows the TFRS Engineering Playbook (v2.0.0). See `tfrs-engineering-playbook` for the canonical standards."*

**3. Create GitHub Project** — A project named `tfrs-website Delivery` was created and attached to the repository, with all ten required fields and eight board views configured per [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md).

**4. Run Review** — [`commands/review.md`](./commands/review.md) was run against the marketing site's page templates, contact form handling, and deployment pipeline. Findings included: no automated accessibility checks in CI, contact form validation only enforced client-side, and page metadata was hand-maintained per page with no shared source.

**5. Run Plan** — Each finding was planned individually. Example: the contact form finding became a plan to add server-side validation matching the client-side rules, with acceptance criteria written in Given/When/Then form.

**6. Initialize Backlog** — An Epic, *"Harden `tfrs-website` form and content pipeline,"* was created using [`templates/epic-template.md`](./templates/epic-template.md), decomposed into three Engineering Task issues (server-side validation, shared page-metadata source, CI accessibility check) using [`templates/engineering-task-template.md`](./templates/engineering-task-template.md). The CI accessibility check was marked `Blocked` on the server-side validation issue landing first, since both touched the same build step.

**7. Begin Execution** — The unblocked issue (server-side validation) was picked up first per [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-issue), executed via [`commands/execute.md`](./commands/execute.md), verified via [`commands/verify.md`](./commands/verify.md) with a completed verification report attached, and shipped via [`commands/ship.md`](./commands/ship.md). Its merge cleared the `Blocked` flag on the accessibility-check issue, which entered `Ready` next.

This is the pattern every future TFRS repository — new or existing — should follow.

## Related Documents

- [`README.md`](./README.md) — adoption guidance and versioning strategy
- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) — detail on step 6
- [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) — detail on step 3
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — the standing loop after step 7
