<!-- Purpose: Provide the ADR template and initial decision log for TFRS engineering standards. -->
# TFRS Decision Log

## ADR Template

The canonical, filled-example ADR template lives at [`templates/adr-template.md`](../../templates/adr-template.md) — copy it for every new decision rather than starting from a blank structure.

## ADR Index

### ADR-001 — Adopt this playbook as canonical standard

- **Status:** Accepted
- **Date:** 2026-07-09
- **Context:** TFRS maintains multiple repositories with shared JavaScript and AI-assisted delivery needs, but without a single source of truth for standards.
- **Decision:** Create and maintain `tfrs-engineering-playbook` as the canonical repository for engineering workflow, review, planning, execution, and template guidance.
- **Consequences:** Future repositories can onboard faster, AI agents can align to one standard, and process improvements can be versioned in one place.

### ADR-002 — Migrate from a GitHub-Project-centered to a repository-centered operating model

- **Status:** Accepted
- **Date:** 2026-07-09
- **Context:** Onboarding `tfrs-website` against the GitHub-Project-centered model showed that GitHub Projects (v2) could not reliably be created or relied on for that repository, and that repository-local context (issue bodies, repository docs) proved significantly more portable and reliable for AI agents than Project metadata. Requiring a GitHub Project as part of readiness meant a repository with a real, well-formed issue hierarchy could still be blocked from full adoption by tooling outside the repository's control.
- **Decision:** Make repository-local documentation (`ARCHITECTURE.md`, `docs/engineering/ROADMAP.md`, `BACKLOG.md`, `CURRENT_SPRINT.md`, `REPO_HEALTH.md`) and GitHub Issues — each carrying a structured `## Metadata` block per what was then `ISSUE_METADATA_STANDARD.md` — the operational source of truth. GitHub Projects became optional visualization only, defined in a (since-removed, see ADR-003) `GITHUB_PROJECT_STANDARD.md`.
- **Consequences:** Every command, standard, and the operating model reads and writes state through issue bodies and repository docs rather than a Project API. Superseded by ADR-003: GitHub Issues themselves were later replaced by repository-local work-item files.

### ADR-003 — Cut team-coordination ceremony and move work-item tracking off GitHub Issues onto files

- **Status:** Accepted
- **Date:** 2026-07-23
- **Context:** TFRS is one non-engineer operator working through AI agents, not an engineering team. By v3.1, the playbook had accumulated significant coordination machinery written for a team of human reviewers that never existed: PR-size caps and review-SLA language, named Agent Personas, Sprint tracking, an optional GitHub Project dashboard, and a scored, three-state repository-adoption model. None of it had a reader. GitHub Issues themselves — while workable per ADR-002 — added an API round-trip, an auth dependency, and a separate system to keep in sync with the repository's own docs, for a workflow that could just as well be version-controlled files an agent greps directly.
- **Decision:** Delete `GITHUB_PROJECT_STANDARD.md` and its supporting automation, the 400-line PR cap, Sprints, Agent Personas, the three-state Adoption Model, and the scored Repository Readiness Checklist. Collapse `EXECUTION_STANDARD.md`, `REVIEW_STANDARD.md`, and `PLANNING_STANDARD.md` into one short [`RULESET.md`](../../RULESET.md). Move work-item tracking off GitHub Issues entirely: `ISSUE_METADATA_STANDARD.md` becomes [`WORK_ITEM_METADATA_STANDARD.md`](../../WORK_ITEM_METADATA_STANDARD.md), and work items become one markdown file each under `docs/engineering/backlog/`, with `docs/engineering/ROADMAP.md` holding Epics as sections rather than issues.
- **Consequences:** Nothing in this playbook depends on the GitHub Issues/Projects API anymore — work state is fully readable and writable as plain files. The trade-off, stated explicitly rather than discovered later: GitHub's native issue-linking gave a clickable dependency graph for free, and `closes #N` gave a durable commit-to-issue link for free; both are replaced by conventions (a `Blocked by <filename>` reference, a `work-item:` commit trailer) that require the same discipline but not the same tooling. This is a breaking change, recorded as a major version bump in [`VERSION.md`](../../VERSION.md). Migration is opt-in per repository — a repository stays on v3.0/v3.1 until someone deliberately migrates it.
