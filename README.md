<!-- Purpose: Canonical entry point for the TFRS engineering playbook and adoption guidance. -->
# TFRS Engineering Playbook

![Version](https://img.shields.io/badge/version-2.1.0-blue)
![Last Updated](https://img.shields.io/badge/last%20updated-2026--07--09-brightgreen)

The **TFRS Engineering Playbook** is the canonical engineering operating system for current and future TFRS projects. Version 1 established the documentation foundation: AI-assisted development conventions, planning and review expectations, reusable templates, and GitHub operating standards. Version 2.0 operationalized it — GitHub is the operational source of truth, chat is temporary, and every phase of the lifecycle (review, roadmap, plan, backlog, execute, verify, ship) is an executable prompt any AI agent can run, not just a document to read. Version 2.1 deepens the engineering discipline inside that lifecycle — security, testing, debugging, and code-quality practice that were previously thin or missing.

## Engineering Methodology Lineage

This playbook treats [`agent-skills`](https://github.com/addyosmani/agent-skills) (a reference-quality, open-source engineering-skills pack, snapshotted at [`docs/agent-skills-main.zip`](./docs/agent-skills-main.zip)) as its engineering *methodology*, and this playbook as TFRS's *implementation* of that methodology — synthesized and adapted, not copied verbatim, and preserved where TFRS's existing workflow was already at least as strong. [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md) and [`TESTING_STANDARD.md`](./TESTING_STANDARD.md) are the two new standards that came directly out of this synthesis; nearly every other standard in this repository received smaller additions from it. See the pull request that introduced this synthesis for the full list of what was adopted, adapted, and intentionally left out, and the [Terminology Map](./AI_ENGINEERING_WORKFLOW.md#terminology-map) for where the two systems use the same word differently. The snapshot in `docs/agent-skills-main.zip` is a point-in-time reference, not a live dependency — re-sync it deliberately (a new snapshot plus a fresh comparison pass) rather than assuming it stays current on its own.

## Quick Start

Choose one adoption model for a new or existing repository:

1. **Copy the baseline files** you need first: [`AGENTS.md`](./AGENTS.md), [`CLAUDE.md`](./CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md), [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md), and [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md).
2. **Reference this repository directly** from the target repository README and contributor docs when you want a single maintained standard.
3. Follow the full onboarding lifecycle in [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md) — it walks through repository creation, playbook adoption, GitHub Project setup, and the first pass through Review → Plan → Backlog → Execute, using `tfrs-website` as a complete worked example.
4. Record the adoption decision in your repository docs and project board using [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md).
5. From then on, run the [`commands/`](./commands/README.md) library for every phase of ongoing work instead of improvising the workflow.

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
- [REVIEW_STANDARD.md](./REVIEW_STANDARD.md)
- [PLANNING_STANDARD.md](./PLANNING_STANDARD.md)
- [EXECUTION_STANDARD.md](./EXECUTION_STANDARD.md)
- [BACKLOG_STANDARD.md](./BACKLOG_STANDARD.md)
- [GITHUB_PROJECT_STANDARD.md](./GITHUB_PROJECT_STANDARD.md)
- [SECURITY_STANDARD.md](./SECURITY_STANDARD.md)
- [TESTING_STANDARD.md](./TESTING_STANDARD.md)
- [REPOSITORY_BOOTSTRAP_GUIDE.md](./REPOSITORY_BOOTSTRAP_GUIDE.md)
- [REPO_HEALTH_STANDARD.md](./REPO_HEALTH_STANDARD.md)
- [VERSION.md](./VERSION.md)
- [docs/ai-prompting/README.md](./docs/ai-prompting/README.md)
- [docs/code-patterns/README.md](./docs/code-patterns/README.md)
- [docs/decision-log/README.md](./docs/decision-log/README.md)
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

| Repository | Adoption Status | Notes |
| --- | --- | --- |
| tfrs-website | Active | Onboarded via [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md); its implementation surfaced the Plan → Execute gap that Version 2 closes |
| Code-Gen-AI | Pending | JavaScript project queued for first-wave adoption |
| prompt-showcase-by-team44-copy | Pending | Candidate for prompt and review standards rollout |
| QPM_Base44 | Pending | Needs baseline repo standards and workflow alignment |
| Digital-Catalogue | Pending | Needs playbook reference and board alignment |
| CPQ-Master-Inventory | Pending | Needs standardized execution and review guidance |

## Adoption Guidance

### What Repositories Should Copy

Copy these into the downstream repository so they work without a live dependency on this repository being reachable:

- [`AGENTS.md`](./AGENTS.md), [`CLAUDE.md`](./CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — behavioral contract every agent needs on hand.
- `.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md` — GitHub-native, must live in the consuming repository to take effect.
- The [`templates/`](./templates/README.md) files relevant to that repository's stack and current work (e.g. copy `epic-template.md` and `engineering-task-template.md` as soon as the repository starts using [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md)).
- A repository-specific `ARCHITECTURE.md` seeded from [`templates/repository-architecture-template.md`](./templates/repository-architecture-template.md) and a `docs/decision-log/` seeded from [`templates/adr-template.md`](./templates/adr-template.md) — these are repository-specific from the moment they're created and should never be centralized.

### What Should Stay Centralized

Reference these directly from this repository rather than copying, since they change independently of any one downstream repository and copies would drift:

- [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md), [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md), [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md), [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md), [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md), [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md), [`TESTING_STANDARD.md`](./TESTING_STANDARD.md), [`REPO_HEALTH_STANDARD.md`](./REPO_HEALTH_STANDARD.md) — the standards themselves.
- The [`commands/`](./commands/README.md) library — executable prompts should be run against the canonical version so improvements to a command reach every repository immediately.
- [`AI_ENGINEERING_WORKFLOW.md`](./AI_ENGINEERING_WORKFLOW.md) and [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md).

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
