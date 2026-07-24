<!-- Purpose: Canonical entry point for the TFRS engineering playbook and adoption guidance. -->
# TFRS Engineering Playbook

![Version](https://img.shields.io/badge/version-4.0.0-blue)
![Last Updated](https://img.shields.io/badge/last%20updated-2026--07--23-brightgreen)

The **TFRS Engineering Playbook** is the canonical engineering operating system for current and future TFRS projects. Version 1 established the documentation foundation. Version 2.0 operationalized it — chat is temporary, and every phase of the lifecycle is an executable prompt any AI agent can run, not just a document to read. Version 2.1–2.4 deepened engineering discipline and operational detail inside that lifecycle. **Version 3.0 was an architectural migration** to a repository-centered model: repository-local documentation and GitHub Issues (carrying a structured `## Metadata` block) became the operational source of truth, with GitHub Projects as optional visualization. Version 3.1 shifted the default language baseline from JavaScript-first to TypeScript-first. **Version 4.0 is a second architectural migration, and the larger one**: TFRS is one non-engineer operator working through AI agents, not an engineering team — much of what the playbook had accumulated through 3.1 was coordination machinery for a team of human reviewers that doesn't exist. Version 4.0 cuts that machinery and moves work-item tracking off GitHub Issues entirely, onto version-controlled files inside each repository. See [`VERSION.md`](./VERSION.md) for the full changelog and exactly what was deleted, kept, and why.

**What this repository is:** the canonical source of engineering standards, the repository-centered operating model, and the executable command library every TFRS repository and AI agent should follow. It does not contain application code, and it does not contain a copy of the shared skills library — see below.

## Architecture

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

Repository-local documentation and work-item files are the operational source of truth. There is no GitHub Project and no GitHub Issue in this loop — see [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md).

## Engineering Methodology Lineage

This playbook treats [`agent-skills`](https://github.com/addyosmani/agent-skills) (a reference-quality, open-source engineering-skills pack, snapshotted at [`docs/agent-skills-main.zip`](./docs/agent-skills-main.zip)) as its engineering *methodology*, and this playbook as TFRS's *implementation* of that methodology — synthesized and adapted, not copied verbatim, and preserved where TFRS's existing workflow was already at least as strong. [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md) and [`TESTING_STANDARD.md`](./TESTING_STANDARD.md) are the two standards that came directly out of this synthesis and are still full-length today — everything else that came out of it was later trimmed in v4.0 once it turned out to have no reader. See the [Terminology Map](./DECISION_ROUTER.md#terminology-map) for where the two systems use the same word differently. The snapshot in `docs/agent-skills-main.zip` is a point-in-time reference, not a live dependency — re-sync it deliberately rather than assuming it stays current on its own.

## Skills Execution Library

Separately from that one-time methodology synthesis, TFRS maintains an ongoing, live fork of that same source — [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) — as the shared execution library agents consult while doing the work this playbook governs. The three-repository architecture:

- **This repository** defines *what TFRS requires and how work is tracked*: standards, the lifecycle, work-item Metadata conventions.
- **[`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills)** defines *how to execute a given kind of task step by step*: reusable, tool-agnostic workflows, plus TFRS-specific skills under `skills/tfrs/`.
- **Any downstream repository** adds *what's true about that specific codebase* — and its local guidance always wins if it conflicts with either of the above.

See [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md) for the full precedence rules and skill-selection guidance, and [`docs/agent-skills-integration.md`](./docs/agent-skills-integration.md) for a worked example. Nothing from the fork is vendored or duplicated into this repository — only referenced.

## Source-of-Truth Map

This repository has grown enough concepts that "which document owns this" needs to be explicit, not inferred. Each concept below has exactly one canonical home — if you find the same concept explained differently in two places, that's a bug in this repository, not two valid answers.

| Concept | Canonical document |
| --- | --- |
| Session start (what an agent does first) | [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) |
| Request routing (plain language → workflow) | [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) |
| Work Item Metadata (Status, Priority, Risk, Size, Epic, Blocked, QA Required) | [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md) — the operational source of truth for a work item's state |
| Operating rules (planning discipline, review discipline, commit/branch conventions) | [`RULESET.md`](./RULESET.md) |
| Security and testing standards | [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md), [`TESTING_STANDARD.md`](./TESTING_STANDARD.md) |
| Execution mechanics (how to actually run a workflow step by step) | [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills), consulted per [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md) |
| Onboarding and readiness (is a repository set up correctly) | [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md) |
| Minimum baseline (what to copy vs. reference vs. create) | [`commands/setup-from-playbook.md#minimum-baseline`](./commands/setup-from-playbook.md#minimum-baseline) |
| Terminology conflicts (same word, different meaning) | [`DECISION_ROUTER.md#terminology-map`](./DECISION_ROUTER.md#terminology-map) |
| Founder/operator usage (plain-language, human-facing) | [`FOUNDER_WORKFLOW.md`](./FOUNDER_WORKFLOW.md) |
| Version history and upgrade impact | [`VERSION.md`](./VERSION.md) |

## Quick Start

**Not a developer or an AI agent?** Start at [`FOUNDER_WORKFLOW.md`](./FOUNDER_WORKFLOW.md) instead of the rest of this page — it's the plain-language version of everything below.

**Starting a session against any repository?** Follow the [Session Initialization Protocol](./AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol) — it works from a plain-language request (*"implement the next ready work item in `tfrs-website`"*) and routes itself via [`DECISION_ROUTER.md`](./DECISION_ROUTER.md); you don't need to know which command to run before you start.

**Bootstrapping a new or existing repository?**

1. **Copy the minimum baseline**, per [`commands/setup-from-playbook.md#minimum-baseline`](./commands/setup-from-playbook.md#minimum-baseline): [`AGENTS.md`](./AGENTS.md), [`CLAUDE.md`](./CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md), and [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) — plus the GitHub-native `.github/PULL_REQUEST_TEMPLATE.md`. Everything else is referenced, not copied — see [What Should Stay Centralized](#what-should-stay-centralized) below.
2. **Create the repository engineering documentation** — `ARCHITECTURE.md`, `docs/engineering/ROADMAP.md`, and an empty `docs/engineering/backlog/` directory, seeded from the templates in [`templates/README.md#repository-engineering-docs`](./templates/README.md#repository-engineering-docs). This is what makes the repository operational.
3. **Reference this repository directly** from the target repository README and contributor docs when you want a single maintained standard.
4. Follow the full onboarding lifecycle in [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md) — it walks through repository creation, playbook adoption, establishing repository engineering documentation, and the first pass through Review → Plan → Backlog → Execute.
5. Record the adoption decision in your repository docs.
6. From then on, run the [`commands/`](./commands/README.md) library for every phase of ongoing work instead of improvising the workflow.

**Running one work item through the whole lifecycle?** See the [Worked Example](./REPOSITORY_BOOTSTRAP_GUIDE.md#worked-example) — a short, generic walkthrough from "what's next" through implementation, review, and ship.

**Wondering whether a repository is actually ready to use this system?** Run the [Repository Setup Checklist](./REPOSITORY_BOOTSTRAP_GUIDE.md#repository-setup-checklist) against it directly — don't assume a repository is onboarded just because it's a TFRS repository.

## The Engineering Lifecycle

```text
Review → Roadmap → Plan → Backlog → Execute → Verify → Ship
                                        ↑
                        Repo Health (on demand)
```

- **Review** produces findings ([`commands/review.md`](./commands/review.md)).
- **Roadmap** sequences findings and priorities into Epics ([`commands/roadmap.md`](./commands/roadmap.md)).
- **Plan** creates implementation strategy ([`commands/plan.md`](./commands/plan.md), [`RULESET.md`](./RULESET.md)).
- **Backlog** converts plans into work-item files (each carrying a `## Metadata` block) and roadmap sections ([`commands/backlog.md`](./commands/backlog.md), [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md)).
- **Execute** implements ready work items ([`commands/execute.md`](./commands/execute.md), [`RULESET.md`](./RULESET.md)).
- **Verify** provides evidence, not assertion ([`commands/verify.md`](./commands/verify.md)).
- **Ship** merges, releases, and communicates ([`commands/ship.md`](./commands/ship.md)).
- **Repo Health** runs on demand, not a fixed cadence ([`commands/repo-health.md`](./commands/repo-health.md)).

## Table of Contents

- [README.md](./README.md)
- [AGENTS.md](./AGENTS.md)
- [CLAUDE.md](./CLAUDE.md)
- [AI_AGENT_OPERATING_MODEL.md](./AI_AGENT_OPERATING_MODEL.md)
- [DECISION_ROUTER.md](./DECISION_ROUTER.md)
- [FOUNDER_WORKFLOW.md](./FOUNDER_WORKFLOW.md)
- [RULESET.md](./RULESET.md)
- [BACKLOG_STANDARD.md](./BACKLOG_STANDARD.md)
- [WORK_ITEM_METADATA_STANDARD.md](./WORK_ITEM_METADATA_STANDARD.md)
- [SECURITY_STANDARD.md](./SECURITY_STANDARD.md)
- [TESTING_STANDARD.md](./TESTING_STANDARD.md)
- [SKILLS_STANDARD.md](./SKILLS_STANDARD.md)
- [REPOSITORY_BOOTSTRAP_GUIDE.md](./REPOSITORY_BOOTSTRAP_GUIDE.md)
- [VERSION.md](./VERSION.md)
- [docs/ai-prompting/README.md](./docs/ai-prompting/README.md)
- [docs/code-patterns/README.md](./docs/code-patterns/README.md)
- [docs/decision-log/README.md](./docs/decision-log/README.md)
- [docs/agent-skills-integration.md](./docs/agent-skills-integration.md)
- [templates/README.md](./templates/README.md)
- [templates/new-repo-checklist.md](./templates/new-repo-checklist.md)
- [templates/github-actions-template.yml](./templates/github-actions-template.yml)
- [templates/engineering-task-template.md](./templates/engineering-task-template.md)
- [templates/adr-template.md](./templates/adr-template.md)
- [templates/repository-architecture-template.md](./templates/repository-architecture-template.md)
- [templates/engineering-roadmap-template.md](./templates/engineering-roadmap-template.md)
- [templates/verification-report-template.md](./templates/verification-report-template.md)
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
- [.github/ISSUE_TEMPLATE/bug_report.md](./.github/ISSUE_TEMPLATE/bug_report.md) (playbook-improvement contributions only — see [How to Contribute](#how-to-contribute-improvements-to-the-playbook))
- [.github/ISSUE_TEMPLATE/feature_request.md](./.github/ISSUE_TEMPLATE/feature_request.md)
- [.github/ISSUE_TEMPLATE/playbook_improvement.md](./.github/ISSUE_TEMPLATE/playbook_improvement.md)
- [.github/PULL_REQUEST_TEMPLATE.md](./.github/PULL_REQUEST_TEMPLATE.md)
- [.github/workflows/validate-playbook.yml](./.github/workflows/validate-playbook.yml)
- [.markdown-link-check.json](./.markdown-link-check.json)

## Currently Adopted By

| Repository | Adopted (v4.0) | Notes |
| --- | --- | --- |
| tfrs-website | No | Stays on v3.0 until deliberately migrated — see [`VERSION.md`](./VERSION.md)'s v4.0.0 entry for the migration path. |
| tfrsupply-frontend | No | Stays on v3.0 until deliberately migrated, same as above. |
| Code-Gen-AI | No | Onboarding not yet started. |
| prompt-showcase-by-team44-copy | No | Onboarding not yet started. |
| QPM_Base44 | No | Onboarding not yet started. |
| Digital-Catalogue | No | Onboarding not yet started. |
| CPQ-Master-Inventory | No | Onboarding not yet started. |

## Adoption Guidance

### What Repositories Should Copy or Create

The minimum baseline — see [`commands/setup-from-playbook.md#minimum-baseline`](./commands/setup-from-playbook.md#minimum-baseline) for the authoritative table and the reasoning behind each entry:

- **Copy:** [`AGENTS.md`](./AGENTS.md), [`CLAUDE.md`](./CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md), [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) — behavioral contract and routing table every agent needs on hand without a live fetch of this repository.
- **Create (GitHub-native):** `.github/PULL_REQUEST_TEMPLATE.md` — must live in the consuming repository to take effect. There is no Issue template to create — work items are files, not Issues.
- **Create (repository engineering documentation):** `ARCHITECTURE.md`, `docs/engineering/ROADMAP.md`, and an empty `docs/engineering/backlog/` directory, seeded from [`templates/README.md#repository-engineering-docs`](./templates/README.md#repository-engineering-docs).

Beyond the baseline, also copy (these are repository-specific from the moment they're created, so centralizing them would be meaningless):

- The [`templates/`](./templates/README.md) files relevant to that repository's stack and current work (e.g. copy `engineering-task-template.md` as soon as the repository starts using [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md)).
- A `docs/decision-log/` seeded from [`templates/adr-template.md`](./templates/adr-template.md).

### What Should Stay Centralized

Reference these directly from this repository rather than copying, since they change independently of any one downstream repository and copies would drift:

- [`RULESET.md`](./RULESET.md), [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md), [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md), [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md), [`TESTING_STANDARD.md`](./TESTING_STANDARD.md), [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md) — the standards themselves. (`DECISION_ROUTER.md` is the one exception among the all-caps root documents — it's part of the copy baseline, not this list.)
- [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) — the shared skills execution library; reference it live per [`SKILLS_STANDARD.md`](./SKILLS_STANDARD.md), never vendor a copy of it into a downstream repository.
- The [`commands/`](./commands/README.md) library — executable prompts should be run against the canonical version so improvements to a command reach every repository immediately.
- [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md) and [`FOUNDER_WORKFLOW.md`](./FOUNDER_WORKFLOW.md) — a founder reads this last one here, in the playbook; it isn't something a downstream repository copies.

### Versioning Strategy

Versioning rules and the full changelog live in [`VERSION.md`](./VERSION.md) — that is the single authoritative source; this section only states how the strategy affects adoption. In short: `major` changes require downstream repositories to adjust (e.g. adding new required work-item Metadata fields or repository engineering documents); `minor` changes add capability without breaking anything already adopted; `patch` changes are safe to ignore until convenient.

### Upgrade Strategy

1. Watch this repository (or the `playbook_improvement` issue label) for new entries in [`VERSION.md`](./VERSION.md).
2. On a `major` bump, treat the upgrade as its own piece of work: re-copy the baseline files and re-run [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md)'s checklist rather than assuming the old configuration still satisfies the standard. A major bump is opt-in, not automatic — a repository on an older version keeps working under that version until someone deliberately migrates it (see the v4.0.0 entry in [`VERSION.md`](./VERSION.md)).
3. On a `minor` bump, adopt the new capability (new template, new command) when it's next relevant — no repository-wide migration is required.
4. On a `patch` bump, no action is required; the change is already reflected wherever the repository references this playbook directly.
5. Record the adopted version in the downstream repository's README, and update it on every `major` upgrade so drift between "what we think we're running" and "what's actually adopted" stays visible.

## How to Contribute Improvements to the Playbook

1. Open an issue using [`playbook_improvement.md`](./.github/ISSUE_TEMPLATE/playbook_improvement.md) — this is the one place this repository still uses a GitHub Issue, since a suggestion *about* the playbook isn't a downstream work item.
2. Plan the change against [`RULESET.md`](./RULESET.md) and, if it touches work-item state, [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md).
3. Make the update, revise [`VERSION.md`](./VERSION.md), and verify links with `.github/workflows/validate-playbook.yml`.
4. Self-review against [`RULESET.md`](./RULESET.md).
5. Merge and announce adoption guidance to downstream repositories, including whether the change requires the upgrade steps above.
