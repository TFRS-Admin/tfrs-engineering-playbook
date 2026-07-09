<!-- Purpose: Track the current playbook version and explain how change levels are versioned. -->
# TFRS Engineering Playbook Version

## Current Version

**2.1.0**

## Versioning Rules

- **Major**: breaking standard change that requires downstream repositories to adjust how they work
- **Minor**: new section, template, or standard capability that is backwards compatible
- **Patch**: clarification, typo fix, or low-risk improvement to existing guidance

## Changelog Format

Record changes using this format:

```text
## <version> - <YYYY-MM-DD>
- Type: major | minor | patch
- Summary: short description of the playbook change
- Impact: what downstream repositories should do next
```

## Changelog

## 2.1.0 - 2026-07-09
- Type: minor
- Summary: Synthesized the `agent-skills` reference engineering methodology (see `docs/agent-skills-main.zip`) into the existing playbook — see [`README.md`](./README.md#engineering-methodology-lineage) for the lineage statement. Added `SECURITY_STANDARD.md` (three-tier boundary system, OWASP-mapped vulnerability categories, dependency-audit triage, secrets rotation rule) and `TESTING_STANDARD.md` (Red-Green-Refactor, test coverage shape, DAMP over DRY, the Beyoncé Rule). Expanded `REVIEW_STANDARD.md` (five-axis framing, severity labels, change-sizing guidance, Chesterton's Fence / Rule of 500), `EXECUTION_STANDARD.md` (trunk-based development, commit-as-save-point, incremental vertical slicing, stop-the-line debugging triage, observability and deprecation sections, an enriched Definition of Done), and `PLANNING_STANDARD.md` (spec-gating triggers, sharper task-splitting triggers). Added a Terminology Map to `AI_ENGINEERING_WORKFLOW.md` resolving the "Review" naming collision between the discovery phase and the PR-approval standard. Added Agent Persona behavioral definitions and the "personas don't invoke personas" orchestration rule to `AI_AGENT_OPERATING_MODEL.md`. Enriched `templates/adr-template.md` with a Date field and Alternatives Considered section.
- Impact: Additive and backward-compatible — no GitHub Project field or board-view changes, so no downstream Project restructuring is required. Downstream repositories should pull in `SECURITY_STANDARD.md` and `TESTING_STANDARD.md` as centrally-referenced standards (see `README.md`) at their next convenient sync, and note the `Assumptions:` block convention now expected from `commands/plan.md` output.

## 2.0.0 - 2026-07-09
- Type: major
- Summary: Operationalized the playbook. Closed the gap between Plan and Execute by adding `BACKLOG_STANDARD.md` and the full `commands/` executable library (review, roadmap, plan, backlog, execute, verify, ship, repo-health). Added `AI_AGENT_OPERATING_MODEL.md`, `REPOSITORY_BOOTSTRAP_GUIDE.md`, and `REPO_HEALTH_STANDARD.md`. Expanded `GITHUB_PROJECT_STANDARD.md` to ten required fields (`Status`, `Phase`, `Priority`, `Risk`, `Size`, `Sprint`, `Epic`, `QA Required`, `Blocked`, `Agent Persona`) and eight board views. Added eight new work-item, decision, and evidence templates.
- Impact: This is a breaking change for downstream repositories — existing GitHub Projects must add the new required fields and board views before any issue can reach `Ready` (see `GITHUB_PROJECT_STANDARD.md`), and any in-flight planning work should be routed through the new Backlog phase (see `BACKLOG_STANDARD.md`) before further execution. Repositories should re-run `REPOSITORY_BOOTSTRAP_GUIDE.md` step 3 (Create GitHub Project) as an upgrade pass rather than a fresh setup.

## 1.0.0 - 2026-07-09
- Type: major
- Summary: Initial canonical scaffold for the TFRS engineering playbook repository.
- Impact: Downstream repositories can now adopt a shared set of AI, planning, review, execution, and GitHub standards.
