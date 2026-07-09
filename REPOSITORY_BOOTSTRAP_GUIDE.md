<!-- Purpose: Define how every new or existing TFRS repository adopts this playbook end-to-end, worked through a real repository. -->
# TFRS Repository Bootstrap Guide

## Purpose

This is the canonical, ordered procedure for bringing a repository — new or existing — fully onto the TFRS engineering operating system. It is the single document that ties together repository creation, playbook adoption, repository engineering documentation, and the first pass through the full engineering lifecycle. **This system is repository-centered, not GitHub-Project-centered:** a GitHub Project is optional visualization (see [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md)) and is never part of what makes a repository operational.

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

- Copy exactly the baseline files and the two GitHub-native items defined in [`commands/setup-from-playbook.md#minimum-baseline`](./commands/setup-from-playbook.md#minimum-baseline): [`AGENTS.md`](./AGENTS.md), [`CLAUDE.md`](./CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md), [`DECISION_ROUTER.md`](./DECISION_ROUTER.md), `.github/ISSUE_TEMPLATE/`, and `.github/PULL_REQUEST_TEMPLATE.md`. Reference everything else (`REVIEW_STANDARD.md`, `PLANNING_STANDARD.md`, `EXECUTION_STANDARD.md`, `BACKLOG_STANDARD.md`, `ISSUE_METADATA_STANDARD.md`, and the rest of the `*_STANDARD.md` family) directly from this repository — don't copy them.
- Copy the `templates/` directory contents relevant to the repository's stack.
- Add a README section naming this repository (`tfrs-engineering-playbook`) as the engineering source of truth, and record the adopted playbook version from [`VERSION.md`](./VERSION.md).
- See [`commands/setup-from-playbook.md`](./commands/setup-from-playbook.md) for the step-by-step adoption procedure.

### 3. Establish Repository Engineering Documentation

This is the step that replaces GitHub Project setup as the operational foundation. Create, from the templates in [`templates/README.md#repository-engineering-docs`](./templates/README.md#repository-engineering-docs):

- `ARCHITECTURE.md` at the repository root, seeded from [`templates/repository-architecture-template.md`](./templates/repository-architecture-template.md).
- `docs/engineering/ROADMAP.md`, seeded from [`templates/engineering-roadmap-template.md`](./templates/engineering-roadmap-template.md).
- `docs/engineering/BACKLOG.md`, seeded from [`templates/engineering-backlog-template.md`](./templates/engineering-backlog-template.md).
- `docs/engineering/CURRENT_SPRINT.md`, seeded from [`templates/engineering-current-sprint-template.md`](./templates/engineering-current-sprint-template.md).
- `docs/engineering/REPO_HEALTH.md`, seeded from [`templates/engineering-repo-health-template.md`](./templates/engineering-repo-health-template.md).

A GitHub Project is optional at this point (or ever) — see [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md). Stand one up only if the repository's humans want a visual board; it changes nothing about whether the repository is operational.

### 4. Run Review

Use [`commands/review.md`](./commands/review.md) against the repository's current state (existing code for an onboarding repository; the intended domain for a greenfield repository). Produce findings — do not fix anything yet.

### 5. Run Plan

Use [`commands/plan.md`](./commands/plan.md) to turn approved findings and initial priorities into implementation strategies with acceptance criteria, per [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md).

### 6. Initialize Backlog

Use [`commands/backlog.md`](./commands/backlog.md) and [`templates/backlog-initialization-template.md`](./templates/backlog-initialization-template.md) to convert plans into a master Epic, child Epics, and task Issues — each carrying a complete `## Metadata` block per [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md) — with dependencies mapped, execution order set, and `docs/engineering/BACKLOG.md`/`docs/engineering/ROADMAP.md` updated to match, per [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md). A GitHub Project may optionally mirror the result.

### 7. Begin Execution

Use [`commands/execute.md`](./commands/execute.md), followed by [`commands/verify.md`](./commands/verify.md) and [`commands/ship.md`](./commands/ship.md), for every issue that reaches `Ready`. From here the repository runs the standing operating loop described in [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md).

## Repository Readiness Checklist

Before treating a repository as ready for the full "plain-language request → agent executes" flow described in [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md), verify each of these directly — don't assume any of them are true because the repository is a TFRS repository. Each item is pass/fail; there is no partial credit, though a documented, explicit gap is materially better than an undocumented one. **A GitHub Project is not on this list at all** — it is optional visualization per [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) and its presence or absence has no bearing on a repository's readiness state.

| Item | Pass criteria | Degradable? |
| --- | --- | --- |
| `AGENTS.md` | Present, and does not instruct agents to treat anything other than this playbook and [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) as authoritative for workflow. | No |
| `CLAUDE.md` | Present, consistent with this playbook's `CLAUDE.md`. | No |
| `AI_AGENT_OPERATING_MODEL.md` | Present per the [Minimum Baseline](./commands/setup-from-playbook.md#minimum-baseline). | No |
| `DECISION_ROUTER.md` | Present per the [Minimum Baseline](./commands/setup-from-playbook.md#minimum-baseline). | No |
| `ARCHITECTURE.md` | Present at the repository root, seeded from [`templates/repository-architecture-template.md`](./templates/repository-architecture-template.md) and kept current. | No |
| Repository engineering docs | `docs/engineering/ROADMAP.md`, `docs/engineering/BACKLOG.md`, `docs/engineering/CURRENT_SPRINT.md`, and `docs/engineering/REPO_HEALTH.md` all present, seeded from the templates in [`templates/README.md#repository-engineering-docs`](./templates/README.md#repository-engineering-docs). | No |
| `.github/ISSUE_TEMPLATE/` | Present, and its templates carry the `## Metadata` block from [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md). | No |
| `.github/PULL_REQUEST_TEMPLATE.md` | Present. | No |
| Playbook reference | The repository's README names `tfrs-engineering-playbook` as its engineering source of truth, with the adopted version recorded. | No |
| Skills repo reference | The repository references [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) per [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md) — not a vendored copy of any skills pack. | No |
| Verification commands | The repository has runnable commands (test, build, lint, and any domain-specific checks) that [`commands/verify.md`](./commands/verify.md) can invoke to produce evidence. | No |
| Backlog initialized or explicitly empty | Either real, dependency-mapped issues exist per [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md), each carrying an [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md) `## Metadata` block, or the repository explicitly records in `docs/engineering/BACKLOG.md` that its backlog is empty by design — never silently absent. | No |
| CI workflow | A CI pipeline runs lint/typecheck/test/build on every PR. | Yes — fall back to running the same checks manually via [`commands/verify.md`](./commands/verify.md) until CI exists. |
| Repository health cadence | The repository has a recorded cadence for [`commands/repo-health.md`](./commands/repo-health.md) in `docs/engineering/REPO_HEALTH.md`, even if "not yet started, first pass scheduled for X." | Yes — fall back to running [`commands/repo-health.md`](./commands/repo-health.md) on demand until a cadence is recorded. |

## Adoption States

A single pass/fail checklist score doesn't tell you whether a repository is safe to operate against — a repository failing only degradable items is meaningfully different from one failing a non-degradable item, even if the raw pass count looks similar. Every repository is in exactly one of three states:

1. **Fully Onboarded** — every checklist item passes, degradable or not.
2. **Degraded but Usable** — every *non-degradable* item passes; only degradable items fail, each with its documented fallback actively in use and explicitly recorded (not silently assumed). An agent can operate here, in the specific degraded mode each failing item's fallback describes.
3. **Not Onboarded** — any *non-degradable* item fails. This is not a matter of degree: a single non-degradable failure (most importantly, an `AGENTS.md` that actively conflicts with this playbook) means an agent cannot safely be assumed to be following this system at all, regardless of how good the rest of the repository's setup looks.

Only the twelve non-degradable items gate the Fully-Onboarded-or-better states; the two degradable items determine, among repositories that clear the non-degradable bar, whether the result is "Fully Onboarded" or "Degraded but Usable." Never describe a repository failing a non-degradable item as "degraded" — that word is reserved for the state where the core system is confirmed working and only CI/health-cadence conveniences are missing. A repository with no GitHub Project at all can still be **Fully Onboarded** — that item was removed from this checklist entirely, not just marked degradable, per this playbook's repository-centered architecture.

## Worked Example: `tfrs-website`

This example is built from `tfrs-website`'s actual, current repository state and its real issue hierarchy — not an illustrative scenario. Running the Repository Readiness Checklist above against it directly produces a mixed, honest result, which is itself the point of a worked example: showing what partial adoption actually looks like, not a clean success story.

### Readiness Checklist Result (as of this writing)

| Item | Degradable? | Result |
| --- | --- | --- |
| `AGENTS.md` | No | **Fail.** Present, but instructs agents to treat a vendored `agent-skills-main/` copy (an extracted zip committed directly into the repository) as the authoritative production knowledge base — not this playbook, and not the `TFRS-Admin/agent-skills` fork. Per [`SKILLS_STANDARD.md#precedence-on-conflict`](./SKILLS_STANDARD.md#precedence-on-conflict), repository-local guidance wins — which means, as written today, an agent in this repository would follow the vendored copy instead of this playbook. This is the single highest-priority fix before full dogfooding (see Remaining Gaps in the pull request that introduced this checklist). |
| `CLAUDE.md` | No | **Fail.** Not present. |
| `AI_AGENT_OPERATING_MODEL.md` | No | **Fail.** Not present. |
| `DECISION_ROUTER.md` | No | **Fail.** Not present. |
| `ARCHITECTURE.md` | No | **Fail.** `docs/` contains operational notes (`lighthouse-runtime.md`, `image-requirements.md`, `launch-readiness-2026-06-22.md`) but no architecture document at the repository root. |
| Repository engineering docs | No | **Fail.** No `docs/engineering/` directory exists — none of `ROADMAP.md`, `BACKLOG.md`, `CURRENT_SPRINT.md`, or `REPO_HEALTH.md` are present. |
| `.github/ISSUE_TEMPLATE/` | No | **Fail.** No `.github/` directory exists at all. |
| `.github/PULL_REQUEST_TEMPLATE.md` | No | **Fail.** Same as above. |
| Playbook reference | No | **Fail.** No file in the repository mentions `tfrs-engineering-playbook`. |
| Skills repo reference | No | **Fail.** References a vendored `agent-skills-main/` extraction, not `TFRS-Admin/agent-skills`. |
| Verification commands | No | **Pass.** `package.json` defines `check` (typecheck), `test` (vitest), `build`, `lint`, and `perf:test`/`perf:verify` (performance-budget checks) — real, runnable commands `commands/verify.md` can invoke. |
| Backlog initialized or explicitly empty | No | **Pass.** Issue #46 ("Epic: Repository Stabilization & Production Hardening") is a real master epic with 7 sub-epics (#47–#53) and 22 dependency-mapped task issues (#54–#75), each with Summary/Acceptance Criteria/Verification/Dependencies text — produced by an actual `code-review-and-quality` + `planning-and-task-breakdown` skill pass. This is the exact shape [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md) formalizes; the remaining gap is that the issue bodies predate that standard's exact `## Metadata` heading format, not that anything about the underlying approach was wrong — dependency-mapping this way, directly in issue bodies, is now the primary path, not a fallback. |
| CI workflow | Yes | **Fail.** No CI runs on pull requests today. |
| Repository health cadence | Yes | **Fail.** No recorded cadence (and no `docs/engineering/REPO_HEALTH.md` to record it in yet). |

**Net result: 2 of 14 pass — and, critically, 10 non-degradable items fail** (`AGENTS.md` conflicts; `CLAUDE.md`, `AI_AGENT_OPERATING_MODEL.md`, `DECISION_ROUTER.md`, `ARCHITECTURE.md`, repository engineering docs, `.github/ISSUE_TEMPLATE/`, and `.github/PULL_REQUEST_TEMPLATE.md` are all missing; playbook reference and skills repo reference are missing or wrong). Per the [Adoption States](#adoption-states) model, that is decisive on its own: **this repository is classified `Not Onboarded`**, not "degraded" — degraded status is reserved for repositories that clear every non-degradable item and are only missing CI/health-cadence conveniences, which is not the case here. Note that **no GitHub Project check appears in this result at all** — it was never part of the readiness model to begin with; `tfrs-website` having no Project is simply not a finding, positive or negative. This repository is a strong worked example for the *backlog-and-execution* half of this playbook — the issue hierarchy is real, well-formed, and immediately usable — but it is not yet onboarded for the *session-initialization and repository-documentation* half. Treat the sections below as accurate for what they describe (the issue hierarchy) and explicit about what they don't yet claim (full playbook adoption).

### The Issue Hierarchy

```text
#46 Epic: Repository Stabilization & Production Hardening (master epic)
 ├─ #47 Epic: Pricing Engine Resolution
 │   ├─ #54 Discover intended consumer of the dealer pricing engine   [Ready]
 │   ├─ #55 Convert pricing engine money math to integer cents        [Ready]
 │   ├─ #72 Wire or gate shared/pricing per discovery outcome         [Blocked by #54]
 │   └─ #73 [Optional] Expand pricing-engine test edge-case coverage  [loosely follows #55]
 ├─ #48 Epic: Security Hardening
 │   ├─ #56 Close unauthenticated /manus-storage/* arbitrary-key read [Ready]
 │   ├─ #58 Upgrade drizzle-orm to close SQL-injection advisory       [Ready]
 │   ├─ #59 Audit and upgrade axios and other flagged dependencies    [Ready]
 │   ├─ #62 HTML-escape lead-form fields in confirmation emails       [Ready]
 │   ├─ #65 Fix cookie sameSite/secure mismatch                      [Ready]
 │   ├─ #66 Bound the in-memory rate-limit map                       [Ready]
 │   └─ #69 [Backlog] Confirm Maps API key restriction (verify-only)  [Ready]
 ├─ #49 Epic: Performance Correctness
 │   └─ #57 Fix duplicate/unscoped homepage hero-image preload        [Ready]
 ├─ #50 Epic: Test Suite Health & CI
 │   ├─ #63 Make critical-fallback-assets.test.ts tolerant            [Ready]
 │   ├─ #64 Make security-headers.test.ts verify real runtime headers [Ready]
 │   ├─ #68 Add missing server test coverage                         [Ready]
 │   ├─ #71 Make email.test.ts credential-independent                 [Blocked by #62]
 │   └─ #74 Add CI workflow gating check/lint/test/build              [Blocked by #60, #71, #63, #64]
 ├─ #51 Epic: Code Health & Dead Code
 │   ├─ #61 Remove dead HubSpot constants                             [Ready]
 │   └─ #67 Remove dead server/index.ts entry point                  [Ready]
 ├─ #52 Epic: Tooling (Lint & Dependency Hygiene)
 │   └─ #60 Add ESLint and widen lint script coverage                 [Ready]
 └─ #53 Epic: Backlog / Future Platform (explicitly not scheduled)
     ├─ #70 [Backlog] Durable persistence for leads/quotes             [Deferred]
     └─ #75 [Optional] Split VehicleConfigurator.tsx into subcomponents [do after #72]
```

### First Recommended Ready Issues

Per [`AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-issue`](./AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-issue) (unblocked first, then Priority, then Risk, then Size), these four are unblocked and ready right now:

| Issue | Priority | Risk | Size | Why it's near the front |
| --- | --- | --- | --- | --- |
| **#56** — Close unauthenticated `/manus-storage/*` arbitrary-key read | P0 | High (security) | S | Highest priority, highest risk, unblocked — resolve while there's runway, per [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md). |
| **#54** — Discover intended consumer of the dealer pricing engine | P0 | Low | XS | Also P0, but low risk and a discovery task, not an implementation — unblocks #72. |
| **#57** — Fix duplicate/unscoped homepage hero-image preload | P1 | Low | XS | Small, unblocked, real (failing) test already exists (`server/route-preload.test.ts`) to prove the fix. |
| **#58** — Upgrade drizzle-orm to close SQL-injection advisory | P1 | Medium (DB) | XS | A dependency-audit finding per [`SECURITY_STANDARD.md#dependency-auditing`](./SECURITY_STANDARD.md#dependency-auditing) — small, unblocked, real CVE (GHSA-gpj5-g38j-94v9). |

Note #57's own verification section names `agent-skills-main/skills/tfrs-performance-guardrails/SKILL.md` — a TFRS-specific performance skill that exists in the *vendored copy* inside `tfrs-website` but not yet in the `TFRS-Admin/agent-skills` fork under `skills/tfrs/` per [`SKILLS_STANDARD.md#fork-management`](./SKILLS_STANDARD.md#fork-management). This is concrete evidence of exactly the drift that standard warns about: a real, useful TFRS-specific skill was written and vendored directly into a downstream repository instead of contributed to the shared fork, so it isn't available to any other TFRS repository.

### Sample Plain-Language Prompts and Expected Agent Behavior

**"What's the next ready issue?"**
→ Informational, per [`DECISION_ROUTER.md`](./DECISION_ROUTER.md). The agent reads open issues' body text directly (Session Initialization Protocol step 5) — this is the primary path regardless of whether a Project exists — applies the ordering rule, and reports **#56** first (highest priority + risk, unblocked) — without opening a branch or making any change.

**"Implement issue #56."**
→ Routes to [`commands/execute.md`](./commands/execute.md). The agent confirms #56 has no `Blocked by` text (it doesn't), reads the parent epic (#48), inspects `server/_core/storageProxy.ts:184-208` and `server/storage.ts:24-29` as the issue's body directs, implements the auth/allowlist fix as the smallest safe change, and writes the new unauthenticated-rejection test alongside it — it does **not** also fix #59 (the axios advisory) just because both are security findings in the same epic; that's a separate issue and a separate invocation.

**"Review the PR for #56."**
→ Routes to [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md) (not `commands/review.md` — this is PR review, not discovery; see the [Terminology Map](./AI_ENGINEERING_WORKFLOW.md#terminology-map)). Given `Risk: High`, the reviewer gives this extra scrutiny per [`REVIEW_STANDARD.md#approval-requirements`](./REVIEW_STANDARD.md#approval-requirements) and confirms the existing legitimate `/manus-storage/` callers still work, per the issue's own acceptance criteria.

**"Ship #56."**
→ Routes to [`commands/verify.md`](./commands/verify.md) → `REVIEW_STANDARD.md` approval → [`commands/ship.md`](./commands/ship.md), never straight to merge. "Moving `Status` to `Done`" means updating the issue's `## Metadata` block directly (closing it with `state_reason: completed` and pasting the verification evidence into `## Verification`) — this is the primary path per [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md), not a fallback for a missing Project. `tfrs-website` having no GitHub Project doesn't change this step at all, and doesn't factor into its `Not Onboarded` classification either.

## Related Documents

- [`README.md`](./README.md) — adoption guidance and versioning strategy
- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) — detail on step 6
- [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md) — the Metadata block referenced throughout this worked example
- [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) — the optional dashboard layer `tfrs-website` doesn't use, by design, without penalty
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — the standing loop after step 7
- [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) — how the plain-language prompts above were routed
