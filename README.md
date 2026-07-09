<!-- Purpose: Canonical entry point for the TFRS engineering playbook and adoption guidance. -->
# TFRS Engineering Playbook

![Version](https://img.shields.io/badge/version-2.4.0-blue)
![Last Updated](https://img.shields.io/badge/last%20updated-2026--07--09-brightgreen)

The **TFRS Engineering Playbook** is the canonical engineering operating system for current and future TFRS projects. Version 1 established the documentation foundation: AI-assisted development conventions, planning and review expectations, reusable templates, and GitHub operating standards. Version 2.0 operationalized it — GitHub is the operational source of truth, chat is temporary, and every phase of the lifecycle (review, roadmap, plan, backlog, execute, verify, ship) is an executable prompt any AI agent can run, not just a document to read. Version 2.1 deepened the engineering discipline inside that lifecycle — security, testing, debugging, and code-quality practice that were previously thin or missing. Version 2.2 connected this playbook to [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills), a live, shared execution library agents consult for step-by-step task mechanics that this playbook intentionally doesn't restate. Version 2.3 made the system operational end to end: a [Session Initialization Protocol](./AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol), a [Decision Router](./DECISION_ROUTER.md) that maps plain-language requests to the right workflow, a full [Issue Execution Protocol](./commands/execute.md#issue-execution-protocol), and a [Repository Readiness Checklist](./REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist) — run for real against `tfrs-website`, with the honest result reported rather than assumed. Version 2.4 is a final cleanup sprint: it closes a routing gap that let small bug fixes reach execution without planning, defines one explicit Minimum Baseline, adds a three-state [Adoption Model](./REPOSITORY_BOOTSTRAP_GUIDE.md#adoption-states), and adds [`FOUNDER_WORKFLOW.md`](./FOUNDER_WORKFLOW.md) and this page's [Source-of-Truth Map](#source-of-truth-map) for anyone who isn't an AI agent.

**What this repository is:** the canonical source of engineering standards, the GitHub-Project-centered operating model, and the executable command library every TFRS repository and AI agent should follow. It does not contain application code, and it does not contain a copy of the shared skills library — see below.

## Engineering Methodology Lineage

This playbook treats [`agent-skills`](https://github.com/addyosmani/agent-skills) (a reference-quality, open-source engineering-skills pack, snapshotted at [`docs/agent-skills-main.zip`](./docs/agent-skills-main.zip)) as its engineering *methodology*, and this playbook as TFRS's *implementation* of that methodology — synthesized and adapted, not copied verbatim, and preserved where TFRS's existing workflow was already at least as strong. [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md) and [`TESTING_STANDARD.md`](./TESTING_STANDARD.md) are the two new standards that came directly out of this synthesis; nearly every other standard in this repository received smaller additions from it. See the pull request that introduced this synthesis for the full list of what was adopted, adapted, and intentionally left out, and the [Terminology Map](./AI_ENGINEERING_WORKFLOW.md#terminology-map) for where the two systems use the same word differently. The snapshot in `docs/agent-skills-main.zip` is a point-in-time reference, not a live dependency — re-sync it deliberately (a new snapshot plus a fresh comparison pass) rather than assuming it stays current on its own.

## Skills Execution Library

Separately from that one-time methodology synthesis, TFRS maintains an ongoing, live fork of that same source — [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) — as the shared execution library agents consult while doing the work this playbook governs. The three-repository architecture:

- **This repository** defines *what TFRS requires and how work is tracked*: standards, the lifecycle, GitHub Project conventions.
- **[`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills)** defines *how to execute a given kind of task step by step*: reusable, tool-agnostic workflows, plus TFRS-specific skills under `skills/tfrs/`.
- **Any downstream repository** adds *what's true about that specific codebase* — and its local guidance always wins if it conflicts with either of the above.

See [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md) for the full precedence rules and skill-selection guidance, and [`docs/agent-skills-integration.md`](./docs/agent-skills-integration.md) for a worked example. Nothing from the fork is vendored or duplicated into this repository — only referenced.

## Source-of-Truth Map

This repository has grown enough concepts that "which document owns this" needs to be explicit, not inferred. Each concept below has exactly one canonical home — if you find the same concept explained differently in two places, that's a bug in this repository, not two valid answers.

| Concept | Canonical document |
| --- | --- |
| Session start (what an agent does first) | [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) |
| Request routing (plain language → workflow) | [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) |
| Standards and thresholds (PR size, review bar, security, testing, sizing) | The relevant `*_STANDARD.md` — [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md), [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md), [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md), [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md), [`TESTING_STANDARD.md`](./TESTING_STANDARD.md), [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md), [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md), [`REPO_HEALTH_STANDARD.md`](./REPO_HEALTH_STANDARD.md) |
| Execution mechanics (how to actually run a workflow step by step) | [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills), consulted per [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md) |
| Onboarding and readiness (is a repository set up correctly, and what state is it in) | [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md) |
| Minimum baseline (what to copy vs. reference) | [`commands/setup-from-playbook.md#minimum-baseline`](./commands/setup-from-playbook.md#minimum-baseline) |
| Terminology conflicts (same word, different meaning) | [`AI_ENGINEERING_WORKFLOW.md`](./AI_ENGINEERING_WORKFLOW.md#terminology-map) |
| Founder/operator usage (plain-language, human-facing) | [`FOUNDER_WORKFLOW.md`](./FOUNDER_WORKFLOW.md) |
| Version history and upgrade impact | [`VERSION.md`](./VERSION.md) |

## Quick Start

**Not a developer or an AI agent?** Start at [`FOUNDER_WORKFLOW.md`](./FOUNDER_WORKFLOW.md) instead of the rest of this page — it's the plain-language version of everything below.

**Starting a session against any repository?** Follow the [Session Initialization Protocol](./AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol) — it works from a plain-language request (*"implement the next ready issue in `tfrs-website`"*) and routes itself via [`DECISION_ROUTER.md`](./DECISION_ROUTER.md); you don't need to know which command to run before you start.

**Bootstrapping a new or existing repository?**

1. **Copy the minimum baseline** — exactly four files, per [`commands/setup-from-playbook.md#minimum-baseline`](./commands/setup-from-playbook.md#minimum-baseline): [`AGENTS.md`](./AGENTS.md), [`CLAUDE.md`](./CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md), and [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) — plus the GitHub-native `.github/ISSUE_TEMPLATE/` and `.github/PULL_REQUEST_TEMPLATE.md`. Everything else (including `REVIEW_STANDARD.md` and `EXECUTION_STANDARD.md`) is referenced, not copied — see [What Should Stay Centralized](#what-should-stay-centralized) below.
2. **Reference this repository directly** from the target repository README and contributor docs when you want a single maintained standard.
3. Follow the full onboarding lifecycle in [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md) — it walks through repository creation, playbook adoption, GitHub Project setup, and the first pass through Review → Plan → Backlog → Execute, using `tfrs-website`'s real, current issue hierarchy as a worked example — including where that repository's own adoption is still incomplete, per its [Repository Readiness Checklist](./REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist) result.
4. Record the adoption decision in your repository docs and project board using [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md).
5. From then on, run the [`commands/`](./commands/README.md) library for every phase of ongoing work instead of improvising the workflow.

**Running one issue through the whole lifecycle?** See the [Sample Plain-Language Prompts](./REPOSITORY_BOOTSTRAP_GUIDE.md#sample-plain-language-prompts-and-expected-agent-behavior) walkthrough — it traces a single real issue (`tfrs-website` #56) from "what's next" through implementation, review, and ship.

**Wondering whether a repository is actually ready to use this system?** Run the [Repository Readiness Checklist](./REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist) against it directly — don't assume a repository is onboarded just because it's a TFRS repository.

## The Engineering Lifecycle

```text
Review → Roadmap → Plan → Backlog → Execute → Verify → Ship
                                        ↑
                        Repo Health (recurring, cross-cutting)
```

- **Review** produces findings ([`commands/review.md`](./commands/review.md)).
- **Roadmap** sequences findings and priorities into Epics ([`commands/roadmap.md`](./commands/roadmap.md)).
- **Plan** creates implementation strategy ([`commands/plan.md`](./commands/plan.md), [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md)).
- **Backlog** converts plans into GitHub Projects, Epics, and Issues — the phase this version of the playbook adds ([`commands/backlog.md`](./commands/backlog.md), [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md)).
- **Execute** implements ready issues ([`commands/execute.md`](./commands/execute.md), [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md)).
- **Verify** provides evidence, not assertion ([`commands/verify.md`](./commands/verify.md)).
- **Ship** merges, releases, and communicates ([`commands/ship.md`](./commands/ship.md)).
- **Repo Health** runs on a fixed cadence regardless of planned work ([`commands/repo-health.md`](./commands/repo-health.md), [`REPO_HEALTH_STANDARD.md`](./REPO_HEALTH_STANDARD.md)).

## Table of Contents

- [README.md](./README.md)
- [AGENTS.md](./AGENTS.md)
- [CLAUDE.md](./CLAUDE.md)
- [AI_ENGINEERING_WORKFLOW.md](./AI_ENGINEERING_WORKFLOW.md)
- [AI_AGENT_OPERATING_MODEL.md](./AI_AGENT_OPERATING_MODEL.md)
- [DECISION_ROUTER.md](./DECISION_ROUTER.md)
- [FOUNDER_WORKFLOW.md](./FOUNDER_WORKFLOW.md)
- [REVIEW_STANDARD.md](./REVIEW_STANDARD.md)
- [PLANNING_STANDARD.md](./PLANNING_STANDARD.md)
- [EXECUTION_STANDARD.md](./EXECUTION_STANDARD.md)
- [BACKLOG_STANDARD.md](./BACKLOG_STANDARD.md)
- [GITHUB_PROJECT_STANDARD.md](./GITHUB_PROJECT_STANDARD.md)
- [SECURITY_STANDARD.md](./SECURITY_STANDARD.md)
- [TESTING_STANDARD.md](./TESTING_STANDARD.md)
- [SKILLS_STANDARD.md](./SKILLS_STANDARD.md)
- [REPOSITORY_BOOTSTRAP_GUIDE.md](./REPOSITORY_BOOTSTRAP_GUIDE.md)
- [REPO_HEALTH_STANDARD.md](./REPO_HEALTH_STANDARD.md)
- [VERSION.md](./VERSION.md)
- [docs/ai-prompting/README.md](./docs/ai-prompting/README.md)
- [docs/code-patterns/README.md](./docs/code-patterns/README.md)
- [docs/decision-log/README.md](./docs/decision-log/README.md)
- [docs/agent-skills-integration.md](./docs/agent-skills-integration.md)
- [templates/README.md](./templates/README.md)
- [templates/new-repo-checklist.md](./templates/new-repo-checklist.md)
- [templates/project-board-template.md](./templates/project-board-template.md)
- [templates/github-actions-template.yml](./templates/github-actions-template.yml)
- [templates/epic-template.md](./templates/epic-template.md)
- [templates/technical-debt-template.md](./templates/technical-debt-template.md)
- [templates/engineering-task-template.md](./templates/engineering-task-template.md)
- [templates/adr-template.md](./templates/adr-template.md)
- [templates/repository-architecture-template.md](./templates/repository-architecture-template.md)
- [templates/verification-report-template.md](./templates/verification-report-template.md)
- [templates/sprint-review-template.md](./templates/sprint-review-template.md)
- [templates/backlog-initialization-template.md](./templates/backlog-initialization-template.md)
- [commands/README.md](./commands/README.md)
- [commands/setup-from-playbook.md](./commands/setup-from-playbook.md)
- [commands/review.md](./commands/review.md)
- [commands/roadmap.md](./commands/roadmap.md)
- [commands/plan.md](./commands/plan.md)
- [commands/backlog.md](./commands/backlog.md)
- [commands/execute.md](./commands/execute.md)
- [commands/verify.md](./commands/verify.md)
- [commands/ship.md](./commands/ship.md)
- [commands/repo-health.md](./commands/repo-health.md)
- [.github/ISSUE_TEMPLATE/bug_report.md](./.github/ISSUE_TEMPLATE/bug_report.md)
- [.github/ISSUE_TEMPLATE/feature_request.md](./.github/ISSUE_TEMPLATE/feature_request.md)
- [.github/ISSUE_TEMPLATE/playbook_improvement.md](./.github/ISSUE_TEMPLATE/playbook_improvement.md)
- [.github/PULL_REQUEST_TEMPLATE.md](./.github/PULL_REQUEST_TEMPLATE.md)
- [.github/workflows/validate-playbook.yml](./.github/workflows/validate-playbook.yml)
- [.markdown-link-check.json](./.markdown-link-check.json)

## Currently Adopted By

Adoption Status uses the three-state model from [`REPOSITORY_BOOTSTRAP_GUIDE.md#adoption-states`](./REPOSITORY_BOOTSTRAP_GUIDE.md#adoption-states): **Fully Onboarded**, **Degraded but Usable** (only GitHub-native conveniences missing, everything else in place), or **Not Onboarded** (a non-degradable item — `AGENTS.md`, `CLAUDE.md`, `DECISION_ROUTER.md`, playbook/skills-repo reference, verification commands, or backlog — fails).

| Repository | Adoption Status | Notes |
| --- | --- | --- |
| tfrs-website | Not Onboarded (2 of 13 on the [Repository Readiness Checklist](./REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist); 5 non-degradable failures) | Has a real, dependency-mapped issue hierarchy and runnable verification commands, used as this playbook's worked example — but its own `AGENTS.md` still points at a vendored skills copy instead of this playbook, and it's missing `CLAUDE.md`, `DECISION_ROUTER.md`, and any playbook/skills-repo reference. See the checklist result for the full breakdown before treating it as onboarded at all. |
| Code-Gen-AI | Not Onboarded | JavaScript project queued for first-wave adoption; onboarding not yet started |
| prompt-showcase-by-team44-copy | Not Onboarded | Candidate for prompt and review standards rollout; onboarding not yet started |
| QPM_Base44 | Not Onboarded | Needs baseline repo standards and workflow alignment; onboarding not yet started |
| Digital-Catalogue | Not Onboarded | Needs playbook reference and board alignment; onboarding not yet started |
| CPQ-Master-Inventory | Not Onboarded | Needs standardized execution and review guidance; onboarding not yet started |

## Adoption Guidance

### What Repositories Should Copy

The minimum baseline — see [`commands/setup-from-playbook.md#minimum-baseline`](./commands/setup-from-playbook.md#minimum-baseline) for the authoritative table and the reasoning behind each entry:

- [`AGENTS.md`](./AGENTS.md), [`CLAUDE.md`](./CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md), [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) — behavioral contract and routing table every agent needs on hand without a live fetch of this repository.
- `.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md` — GitHub-native, must live in the consuming repository to take effect.

Beyond the baseline, also copy (these are repository-specific from the moment they're created, so centralizing them would be meaningless):

- The [`templates/`](./templates/README.md) files relevant to that repository's stack and current work (e.g. copy `epic-template.md` and `engineering-task-template.md` as soon as the repository starts using [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md)).
- A repository-specific `ARCHITECTURE.md` seeded from [`templates/repository-architecture-template.md`](./templates/repository-architecture-template.md) and a `docs/decision-log/` seeded from [`templates/adr-template.md`](./templates/adr-template.md).

`REVIEW_STANDARD.md` and `EXECUTION_STANDARD.md` are **not** part of the baseline, despite being described that way in earlier guidance — they belong in [What Should Stay Centralized](#what-should-stay-centralized) below, alongside every other `*_STANDARD.md` document.

### What Should Stay Centralized

Reference these directly from this repository rather than copying, since they change independently of any one downstream repository and copies would drift:

- [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md), [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md), [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md), [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md), [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md), [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md), [`TESTING_STANDARD.md`](./TESTING_STANDARD.md), [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md), [`REPO_HEALTH_STANDARD.md`](./REPO_HEALTH_STANDARD.md) — the standards themselves. (`DECISION_ROUTER.md` is the one exception among the all-caps root documents — it's part of the copy baseline, not this list, per [`commands/setup-from-playbook.md#minimum-baseline`](./commands/setup-from-playbook.md#minimum-baseline).)
- [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) — the shared skills execution library; reference it live per [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md), never vendor a copy of it into a downstream repository.
- The [`commands/`](./commands/README.md) library — executable prompts should be run against the canonical version so improvements to a command reach every repository immediately.
- [`AI_ENGINEERING_WORKFLOW.md`](./AI_ENGINEERING_WORKFLOW.md), [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md), and [`FOUNDER_WORKFLOW.md`](./FOUNDER_WORKFLOW.md) — a founder reads this last one here, in the playbook; it isn't something a downstream repository copies.

### Versioning Strategy

Versioning rules and the full changelog live in [`VERSION.md`](./VERSION.md) — that is the single authoritative source; this section only states how the strategy affects adoption. In short: `major` changes require downstream repositories to adjust (e.g. adding new GitHub Project fields); `minor` changes add capability without breaking anything already adopted; `patch` changes are safe to ignore until convenient.

### Upgrade Strategy

1. Watch this repository (or the `playbook_improvement` issue label) for new entries in [`VERSION.md`](./VERSION.md).
2. On a `major` bump, treat the upgrade as its own piece of work: run the relevant step of [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md) again (e.g. re-run GitHub Project setup to add new required fields) rather than assuming the old configuration still satisfies the standard.
3. On a `minor` bump, adopt the new capability (new template, new command) when it's next relevant — no repository-wide migration is required.
4. On a `patch` bump, no action is required; the change is already reflected wherever the repository references this playbook directly.
5. Record the adopted version in the downstream repository's README, and update it on every `major` upgrade so drift between "what we think we're running" and "what's actually adopted" stays visible.

## How to Contribute Improvements to the Playbook

1. Open an issue using [`playbook_improvement.md`](./.github/ISSUE_TEMPLATE/playbook_improvement.md).
2. Plan the change against [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md) and, if needed, the standard board setup in [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md).
3. Make the update, revise [`VERSION.md`](./VERSION.md), and verify links with `.github/workflows/validate-playbook.yml`.
4. Request review using the expectations in [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md).
5. Merge and announce adoption guidance to downstream repositories, including whether the change requires the upgrade steps above.
