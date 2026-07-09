<!-- Purpose: Provide the ADR template and initial decision log for TFRS engineering standards. -->
# TFRS Decision Log

## ADR Template

The canonical, filled-example ADR template lives at [`templates/adr-template.md`](../../templates/adr-template.md) — copy it for every new decision rather than starting from a blank structure.

## ADR Index

### ADR-001 — Adopt this playbook as canonical standard

- **Status:** Accepted
- **Date:** 2026-07-09
- **Context:** TFRS maintains multiple repositories with shared JavaScript and AI-assisted delivery needs, but without a single source of truth for standards.
- **Decision:** Create and maintain `tfrs-engineering-playbook` as the canonical repository for engineering workflow, review, planning, execution, GitHub project, and template guidance.
- **Consequences:** Future repositories can onboard faster, AI agents can align to one standard, and process improvements can be versioned in one place.
