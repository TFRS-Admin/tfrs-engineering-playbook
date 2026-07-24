<!-- Purpose: Define how every new or existing TFRS repository adopts this playbook end-to-end. -->
# TFRS Repository Bootstrap Guide

## Purpose

This is the canonical, ordered procedure for bringing a repository — new or existing — fully onto the TFRS engineering operating system. It ties together repository creation, playbook adoption, repository engineering documentation, and the first pass through the full engineering lifecycle.

## The Bootstrap Lifecycle

```text
Create Repository
      ↓
Copy Playbook
      ↓
Establish Repository Engineering Documentation
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

- Copy exactly the baseline files defined in [`commands/setup-from-playbook.md#minimum-baseline`](./commands/setup-from-playbook.md#minimum-baseline): [`AGENTS.md`](./AGENTS.md), [`CLAUDE.md`](./CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md), [`DECISION_ROUTER.md`](./DECISION_ROUTER.md). Reference everything else directly from this repository — don't copy it.
- Copy the `templates/` directory contents relevant to the repository's stack.
- Add a README section naming this repository (`tfrs-engineering-playbook`) as the engineering source of truth, and record the adopted playbook version from [`VERSION.md`](./VERSION.md).
- See [`commands/setup-from-playbook.md`](./commands/setup-from-playbook.md) for the step-by-step adoption procedure.

### 3. Establish Repository Engineering Documentation

This is the step that makes the repository operational. Create, from the templates in [`templates/README.md#repository-engineering-docs`](./templates/README.md#repository-engineering-docs):

- `ARCHITECTURE.md` at the repository root, seeded from [`templates/repository-architecture-template.md`](./templates/repository-architecture-template.md).
- `docs/engineering/ROADMAP.md`, seeded from [`templates/engineering-roadmap-template.md`](./templates/engineering-roadmap-template.md).
- `docs/engineering/backlog/`, an empty directory ready to hold work-item files.

### 4. Run Review

Use [`commands/review.md`](./commands/review.md) against the repository's current state (existing code for an onboarding repository; the intended domain for a greenfield repository). Produce findings — do not fix anything yet.

### 5. Run Plan

Use [`commands/plan.md`](./commands/plan.md) to turn approved findings and initial priorities into implementation strategies with acceptance criteria.

### 6. Initialize Backlog

Use [`commands/backlog.md`](./commands/backlog.md) to convert plans into Epic sections in `docs/engineering/ROADMAP.md` and work-item files in `docs/engineering/backlog/` — each carrying a complete `## Metadata` block per [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md) — with dependencies mapped and execution order set, per [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md).

### 7. Begin Execution

Use [`commands/execute.md`](./commands/execute.md), followed by [`commands/verify.md`](./commands/verify.md) and [`commands/ship.md`](./commands/ship.md), for every work item that reaches `Ready`. From here the repository runs the standing operating loop described in [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md).

## Repository Setup Checklist

A plain list, not a scored audit — check each item directly against the repository, and fix whatever's missing rather than assuming it's fine because it's a TFRS repository:

- [ ] `AGENTS.md` present and consistent with this playbook.
- [ ] `CLAUDE.md` present and consistent with this playbook.
- [ ] `AI_AGENT_OPERATING_MODEL.md` present, per the [Minimum Baseline](./commands/setup-from-playbook.md#minimum-baseline).
- [ ] `DECISION_ROUTER.md` present, per the [Minimum Baseline](./commands/setup-from-playbook.md#minimum-baseline).
- [ ] `ARCHITECTURE.md` present at the repository root and kept current.
- [ ] `docs/engineering/ROADMAP.md` present.
- [ ] `docs/engineering/backlog/` exists, either holding real, dependency-mapped work-item files or explicitly noted as empty-by-design in `ROADMAP.md`.
- [ ] `.github/PULL_REQUEST_TEMPLATE.md` present.
- [ ] The repository's README names `tfrs-engineering-playbook` as its engineering source of truth, with the adopted version recorded.
- [ ] The repository references [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) per [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md) — not a vendored copy of any skills pack.
- [ ] The repository has runnable commands (test, build, lint, typecheck) that [`commands/verify.md`](./commands/verify.md) can invoke.

Nothing here is a required score or gate for whether an agent can operate in the repository — a missing item is just a missing item to go fix. There is no separate GitHub Project, GitHub Issue template, or Sprint tracking to check for; none of those exist in this model.

## Worked Example

A short, generic walkthrough — not tied to any one real repository's actual history, so it stays accurate without needing to be kept in sync with a live issue tracker.

**"What's the next ready work item?"**
→ Informational, per [`DECISION_ROUTER.md`](./DECISION_ROUTER.md). The agent globs `docs/engineering/backlog/*.md` for `Status: Ready`, applies the ordering rule in [`AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-work-item`](./AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-work-item), and reports the highest-priority, highest-risk, unblocked item — without opening a branch or making any change.

**"Implement `SEC-01-close-unauthenticated-read.md`."**
→ Routes to [`commands/execute.md`](./commands/execute.md). The agent confirms the file has no `Blocked by` entry, reads the parent Epic's section in `ROADMAP.md`, inspects the code the file's Implementation Notes point at, implements the smallest safe fix, and writes a regression test alongside it — it does not also fix an unrelated finding from the same Epic just because both are security-flavored; that's a separate work item and a separate invocation.

**"Review the PR."**
→ Routes to a self-review against [`RULESET.md`](./RULESET.md) (not `commands/review.md` — this is PR review, not discovery; see the [Terminology Map](./DECISION_ROUTER.md#terminology-map)). Given `Risk: High` on the work item, this gets extra scrutiny before merge, per [`RULESET.md`](./RULESET.md) rule 2.

**"Ship it."**
→ Routes to [`commands/verify.md`](./commands/verify.md) → [`commands/ship.md`](./commands/ship.md), never straight to merge. "Marking it done" means editing the work-item file's `## Metadata` block directly (`Status: Done`, verification evidence pasted into `## Verification`) — the file, not a chat summary, is what's authoritative.

## Related Documents

- [`README.md`](./README.md) — adoption guidance and versioning strategy
- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) — detail on step 6
- [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md) — the Metadata block referenced throughout this guide
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — the standing loop after step 7
- [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) — how the plain-language prompts above get routed
