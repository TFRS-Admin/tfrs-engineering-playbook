<!-- Purpose: Canonical entry point for the TFRS engineering playbook and adoption guidance. -->
# TFRS Engineering Playbook

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Last Updated](https://img.shields.io/badge/last%20updated-2026--07--09-brightgreen)

The **TFRS Engineering Playbook** is the canonical engineering standard for current and future TFRS projects. It centralizes AI-assisted development conventions, planning and review expectations, reusable templates, and GitHub operating standards so every repository can start from the same source of truth.

## Quick Start

Choose one adoption model for a new or existing repository:

1. **Copy the baseline files** you need first: [`AGENTS.md`](./AGENTS.md), [`CLAUDE.md`](./CLAUDE.md), [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md), and [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md).
2. **Reference this repository directly** from the target repository README and contributor docs when you want a single maintained standard.
3. Follow [`commands/setup-from-playbook.md`](./commands/setup-from-playbook.md) and [`templates/new-repo-checklist.md`](./templates/new-repo-checklist.md) to complete setup.
4. Record the adoption decision in your repository docs and project board using [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md).

## Table of Contents

- [README.md](./README.md)
- [AGENTS.md](./AGENTS.md)
- [CLAUDE.md](./CLAUDE.md)
- [AI_ENGINEERING_WORKFLOW.md](./AI_ENGINEERING_WORKFLOW.md)
- [REVIEW_STANDARD.md](./REVIEW_STANDARD.md)
- [PLANNING_STANDARD.md](./PLANNING_STANDARD.md)
- [EXECUTION_STANDARD.md](./EXECUTION_STANDARD.md)
- [GITHUB_PROJECT_STANDARD.md](./GITHUB_PROJECT_STANDARD.md)
- [VERSION.md](./VERSION.md)
- [docs/ai-prompting/README.md](./docs/ai-prompting/README.md)
- [docs/code-patterns/README.md](./docs/code-patterns/README.md)
- [docs/decision-log/README.md](./docs/decision-log/README.md)
- [templates/README.md](./templates/README.md)
- [templates/new-repo-checklist.md](./templates/new-repo-checklist.md)
- [templates/project-board-template.md](./templates/project-board-template.md)
- [templates/github-actions-template.yml](./templates/github-actions-template.yml)
- [commands/README.md](./commands/README.md)
- [commands/setup-from-playbook.md](./commands/setup-from-playbook.md)
- [.github/ISSUE_TEMPLATE/bug_report.md](./.github/ISSUE_TEMPLATE/bug_report.md)
- [.github/ISSUE_TEMPLATE/feature_request.md](./.github/ISSUE_TEMPLATE/feature_request.md)
- [.github/ISSUE_TEMPLATE/playbook_improvement.md](./.github/ISSUE_TEMPLATE/playbook_improvement.md)
- [.github/PULL_REQUEST_TEMPLATE.md](./.github/PULL_REQUEST_TEMPLATE.md)
- [.github/workflows/validate-playbook.yml](./.github/workflows/validate-playbook.yml)
- [.markdown-link-check.json](./.markdown-link-check.json)

## Currently Adopted By

| Repository | Adoption Status | Notes |
| --- | --- | --- |
| Code-Gen-AI | Pending | JavaScript project queued for first-wave adoption |
| prompt-showcase-by-team44-copy | Pending | Candidate for prompt and review standards rollout |
| QPM_Base44 | Pending | Needs baseline repo standards and workflow alignment |
| Digital-Catalogue | Pending | Needs playbook reference and board alignment |
| CPQ-Master-Inventory | Pending | Needs standardized execution and review guidance |

## How to Contribute Improvements to the Playbook

1. Open an issue using [`playbook_improvement.md`](./.github/ISSUE_TEMPLATE/playbook_improvement.md).
2. Plan the change against [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md) and, if needed, the standard board setup in [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md).
3. Make the update, revise [`VERSION.md`](./VERSION.md), and verify links with `.github/workflows/validate-playbook.yml`.
4. Request review using the expectations in [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md).
5. Merge and announce adoption guidance to downstream repositories.
