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
- **Context:** Onboarding `tfrs-website` against the GitHub-Project-centered model showed that GitHub Projects (v2) could not reliably be created or relied on for that repository, and that repository-local context (issue bodies, repository docs) proved significantly more portable and reliable for AI agents than Project metadata. Requiring a GitHub Project as part of readiness meant a repository with a real, well-formed issue hierarchy could still be blocked from `Fully Onboarded` status by tooling outside the repository's control.
- **Decision:** Make repository-local documentation (`ARCHITECTURE.md`, `docs/engineering/ROADMAP.md`, `BACKLOG.md`, `CURRENT_SPRINT.md`, `REPO_HEALTH.md`) and GitHub Issues — each carrying a structured `## Metadata` block per [`ISSUE_METADATA_STANDARD.md`](../../ISSUE_METADATA_STANDARD.md) — the operational source of truth. GitHub Projects become optional visualization only, defined in the rewritten [`GITHUB_PROJECT_STANDARD.md`](../../GITHUB_PROJECT_STANDARD.md), and are removed entirely from the [Repository Readiness Checklist](../../REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist).
- **Consequences:** Every command, standard, and the operating model itself now reads and writes state through issue bodies and repository docs rather than a Project API. Downstream repositories that already run a GitHub Project may keep it as a dashboard mirror; repositories that can't or don't want one lose no capability. This is a breaking change to what "Fully Onboarded" requires (new required files), recorded as a major version bump in [`VERSION.md`](../../VERSION.md).
