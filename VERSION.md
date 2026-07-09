<!-- Purpose: Track the current playbook version and explain how change levels are versioned. -->
# TFRS Engineering Playbook Version

## Current Version

**2.3.0**

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

## 2.3.0 - 2026-07-09
- Type: minor
- Summary: Operational hardening pass — makes the system usable from a plain-language request rather than only an explicit command invocation. Expanded `AI_AGENT_OPERATING_MODEL.md` section 1 into a full Session Initialization Protocol (read local guidance, `AGENTS.md`, `CLAUDE.md`; identify repo and GitHub Project/issue; classify the task; select workflow and skill; state assumptions; get approval before state-changing actions). Added `DECISION_ROUTER.md` mapping plain-language request types to workflows, with ambiguity handling and approval checkpoints. Expanded `SKILLS_STANDARD.md` with an explicit mandatory-vs-optional consultation rule. Rewrote `commands/execute.md`'s workflow into a full twelve-step Issue Execution Protocol with an explicit Forbidden section (no multi-issue passes, no opportunistic refactors, no closing without verification, no chat-as-source-of-truth), and added a "Required Skill Consultation" section to every command file, including a full structural hardening of `commands/setup-from-playbook.md`. Added a Repository Readiness Checklist to `REPOSITORY_BOOTSTRAP_GUIDE.md` and ran it for real against `tfrs-website` — replacing the previously illustrative worked example with `tfrs-website`'s actual, verified issue hierarchy (epic #46, sub-epics #47–53, task issues #54–75) and an honest, mixed readiness result (2 of 12 checklist items pass). Corrected `README.md`'s prior claim that `tfrs-website` was "Active" — it is not yet onboarded; its own `AGENTS.md` currently points agents at a vendored skills copy instead of this playbook, which is now recorded as the top blocking gap.
- Impact: Additive and backward-compatible — no GitHub Project field or lifecycle-phase changes. This release also corrects a documentation-accuracy issue in `README.md`'s adoption table (no functional impact, but downstream readers should not have treated `tfrs-website` as a reference implementation of full playbook adoption prior to this correction). Any repository being onboarded should run the new Repository Readiness Checklist and treat a "fail" honestly rather than assuming adoption is complete.

## 2.2.0 - 2026-07-09
- Type: minor
- Summary: Integrated [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) — a live fork of the reference skills pack — as the shared, ongoing execution library for AI agents, distinct from the one-time methodology synthesis in `README.md#engineering-methodology-lineage`. Added `SKILLS_STANDARD.md` (the three-repository architecture, conflict precedence, the nine-step skill-consultation workflow, skill-selection table, and fork-management guidance) and `docs/agent-skills-integration.md` (a worked walkthrough). Updated `README.md`, `AGENTS.md`, `CLAUDE.md`, `AI_ENGINEERING_WORKFLOW.md`, `AI_AGENT_OPERATING_MODEL.md`, and `commands/README.md` to cross-reference the new standard. No skill content was copied into this repository.
- Impact: Additive and backward-compatible — no GitHub Project field or lifecycle changes. Downstream repositories should note the precedence rule (local guidance > this playbook > the skills fork) and start consulting `TFRS-Admin/agent-skills` per the skill-selection table for execution-level detail. Two TFRS-specific skills referenced in that table (`skills/tfrs/repo-health`, `skills/tfrs/backlog-initialization` or `skills/tfrs/github-project-management`) do not exist in the fork yet — see `SKILLS_STANDARD.md#skill-selection` for the fallback in the meantime — and the fork's own plugin manifest still needs a follow-up fix to point at itself instead of upstream (see `SKILLS_STANDARD.md#fork-management`).

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
