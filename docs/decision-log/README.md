<!-- Purpose: Provide the ADR template and initial decision log for TFRS engineering standards. -->
# TFRS Decision Log

## ADR Template

Use this template for each Architecture Decision Record:

```text
# ADR-XXX: <Title>
Status: Proposed | Accepted | Superseded

## Context
<What problem or pressure exists?>

## Decision
<What was chosen?>

## Consequences
<What becomes easier, harder, or required next?>
```

## ADR Index

### ADR-001 — Adopt this playbook as canonical standard

- **Status:** Accepted
- **Context:** TFRS maintains multiple repositories with shared JavaScript and AI-assisted delivery needs, but without a single source of truth for standards.
- **Decision:** Create and maintain `tfrs-engineering-playbook` as the canonical repository for engineering workflow, review, planning, execution, GitHub project, and template guidance.
- **Consequences:** Future repositories can onboard faster, AI agents can align to one standard, and process improvements can be versioned in one place.
