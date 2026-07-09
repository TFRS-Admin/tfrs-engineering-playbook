<!-- Purpose: Define TFRS's relationship to the shared skills execution library and how agents use both repositories together without duplicating content between them. -->
# TFRS Skills Standard

## Purpose

TFRS maintains a fork of the `agent-skills` engineering-skills pack — [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) — as the shared, reusable execution library for AI agents. This document defines how that fork relates to this playbook, so the two never drift into duplicated or conflicting guidance. It is the canonical source for that relationship; the walked-through, example-driven version of this same guidance lives at [`docs/agent-skills-integration.md`](./docs/agent-skills-integration.md).

This is a distinct relationship from the one described in [`README.md`](./README.md#engineering-methodology-lineage): that section describes how this playbook's *standards* (thresholds, TFRS-specific fields, the lifecycle) were synthesized from the `agent-skills` *methodology* as a one-time reference. This document describes an ongoing, three-repository *operating* relationship — the fork stays a live thing agents consult, not a one-time source that got absorbed and can be forgotten.

## The Three-Repository Architecture

| Repository | Answers | Owns |
| --- | --- | --- |
| `tfrs-engineering-playbook` (this repo) | *What does TFRS require, and how is work tracked?* | Engineering standards, the lifecycle operating model, GitHub Project conventions, TFRS-specific thresholds (PR size, required fields, versioning) |
| [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) | *How do I actually execute this kind of task, step by step?* | Reusable, tool-agnostic execution workflows (the skills), quality gates and anti-rationalization tables within a skill, agent personas |
| Any downstream repository | *What's true about this specific codebase?* | Local architecture, stack-specific conventions, repository-local `CLAUDE.md`/`AGENTS.md` overrides |

None of these three repositories restates another's content. This playbook does not re-document a skill's step-by-step workflow (that's duplication the source material itself warns against — `docs/skill-anatomy.md` in the reference snapshot at [`docs/agent-skills-main.zip`](./docs/agent-skills-main.zip) states it directly: "Don't duplicate content between skills — reference and link instead," which applies equally here). The skills fork does not restate TFRS's specific thresholds (400-line PR cap, the ten required GitHub Project fields, `S`/`M`/`L`/`XL` sizing) — those are TFRS-specific decisions that belong here, not in a repository meant to be reusable outside TFRS. A downstream repository does not restate either — it only adds what's true about itself.

## Precedence on Conflict

**Repository-local guidance always wins.** When guidance conflicts, resolve in this order:

1. **The downstream repository's own local instructions** (its `CLAUDE.md`, `AGENTS.md`, or explicit maintainer direction) — always wins. A repository that documents a stricter or different local rule is exercising a decision this playbook already defers to (see [`AGENTS.md`](./AGENTS.md#agent-identity--scope): "treat this playbook as the default operating contract *unless a repository documents a stricter local rule*").
2. **This playbook's standards** — win over the skills fork's generic guidance. If a skill in `TFRS-Admin/agent-skills` suggests a 100-line PR target and `EXECUTION_STANDARD.md` says the hard cap is 400, TFRS's cap governs; if a skill's generic quality bar conflicts with a TFRS-specific field or threshold, the TFRS-specific one wins because it accounts for context the generic skill can't know.
3. **`TFRS-Admin/agent-skills`** — fills in execution detail this playbook doesn't (and shouldn't) specify, wherever the above two don't already say something more specific.

An agent that notices a real conflict (not just a difference in detail level) should surface it rather than silently picking a side — per [`CLAUDE.md`](./CLAUDE.md#when-to-ask-vs-when-to-proceed), ambiguity that would change scope or standards is an "ask," not a "proceed."

## The Skill-Consultation Workflow

This is the step-by-step procedure an agent follows when using both repositories together. It runs *inside* the broader operating loop already defined in [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#summary-loop) — specifically, it's the detail behind that loop's "Implement within acceptance criteria → Verify with evidence" steps. The operating model doesn't restate this; this document doesn't restate the operating model's board/issue-selection logic.

1. **Read local repository instructions first** — the downstream repo's own `CLAUDE.md`/`AGENTS.md` and any README context. Per the precedence rule above, this can override everything below.
2. **Read the TFRS Engineering Playbook** — this repository's standards for the task at hand (e.g. `EXECUTION_STANDARD.md` for implementation, `SECURITY_STANDARD.md` for anything touching external input).
3. **Identify the task type** — review, planning, specification, implementation, verification, repository health, or backlog/project creation (see the Skill Selection table below).
4. **Consult the matching skill in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills)** — read the relevant `SKILL.md` for the step-by-step execution workflow, its quality gates, and its anti-rationalization table.
5. **Execute the skill-defined workflow** — follow it as written; don't partially apply a skill and call it done.
6. **Apply repository-specific constraints** — reconcile the skill's generic workflow with this playbook's TFRS-specific thresholds and the downstream repo's local rules, per the precedence order above.
7. **Verify work** — per [`commands/verify.md`](./commands/verify.md) and [`TESTING_STANDARD.md`](./TESTING_STANDARD.md); a skill's own verification checklist is evidence, not a substitute for TFRS's evidence-artifact requirement.
8. **Update GitHub issues/projects** — per [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) and [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#5-how-to-update-github). This is never optional and never happens only in the skills fork's own terms — GitHub, per this playbook, is still the source of truth.
9. **Stop** — per [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#4-when-to-stop). Finishing a skill's workflow is not, by itself, a reason to keep going past the issue's acceptance criteria.

## Skill Selection

Use this table to go from "what kind of task is this" to "which skill do I consult." Every entry links to the skill by name — none of their content is reproduced here.

| Task type | Consult this skill in `TFRS-Admin/agent-skills` | TFRS standard that still governs |
| --- | --- | --- |
| Code review | [`skills/code-review-and-quality`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/code-review-and-quality) | [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md) |
| Planning | [`skills/planning-and-task-breakdown`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/planning-and-task-breakdown) | [`PLANNING_STANDARD.md`](./PLANNING_STANDARD.md), [`commands/plan.md`](./commands/plan.md) |
| Specification | [`skills/spec-driven-development`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/spec-driven-development) | [`PLANNING_STANDARD.md#when-a-full-spec-is-required`](./PLANNING_STANDARD.md#when-a-full-spec-is-required) |
| Implementation | [`skills/incremental-implementation`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/incremental-implementation) and [`skills/test-driven-development`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/test-driven-development) | [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md), [`commands/execute.md`](./commands/execute.md) |
| Verification | [`skills/test-driven-development`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/test-driven-development) and [`skills/debugging-and-error-recovery`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/debugging-and-error-recovery) | [`TESTING_STANDARD.md`](./TESTING_STANDARD.md), [`commands/verify.md`](./commands/verify.md) |
| Repository health | `skills/tfrs/repo-health` *(not yet added to the fork — see Fork Management below)* | Follow [`REPO_HEALTH_STANDARD.md`](./REPO_HEALTH_STANDARD.md) and [`commands/repo-health.md`](./commands/repo-health.md) directly until that skill exists |
| GitHub backlog/project creation | `skills/tfrs/backlog-initialization` or `skills/tfrs/github-project-management` *(not yet added to the fork)* | Follow [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) and [`commands/backlog.md`](./commands/backlog.md) directly until a TFRS-specific skill exists |

The last two rows are the concrete case of a general rule: **a TFRS-specific skill in the fork wins when one exists; otherwise, fall back to this playbook's own standard and command directly.** Never invent a generic-skill substitute for TFRS-specific process (backlog conversion, GitHub Project field conventions) that has no upstream equivalent — those concepts don't exist in the reference methodology because it isn't built around a GitHub Project execution model the way TFRS is (see the [Terminology Map](./AI_ENGINEERING_WORKFLOW.md#terminology-map)).

## Fork Management

### Recommended Structure

```text
skills/
├── <upstream-skill-name>/      # unmodified skills inherited from addyosmani/agent-skills
└── tfrs/
    ├── github-project-management/
    ├── repository-adoption/
    ├── backlog-initialization/
    ├── repo-health/
    └── engineering-playbook/
```

TFRS-specific skills live under `skills/tfrs/` — never mixed into the upstream skill directories, and never named to shadow an upstream skill. This keeps a clean sync boundary: pulling upstream `agent-skills` updates should only ever touch files outside `skills/tfrs/`.

### Rules for the Fork

1. **Don't modify upstream skills unnecessarily.** If an upstream skill (e.g. `skills/code-review-and-quality`) has a real gap or bug for TFRS's use, prefer contributing that fix upstream (to `addyosmani/agent-skills`) over silently diverging in the fork — a silent fork divergence is exactly the kind of undocumented deviation this playbook's constraints exist to prevent. Only patch an upstream skill directly in the fork when the fix is TFRS-specific enough that it wouldn't make sense upstream, and document why in the commit.
2. **New TFRS-specific skills go under `skills/tfrs/`**, following the same `SKILL.md` format the upstream skills already use (frontmatter with `name`/`description`, Overview/When to Use/Process/Rationalizations/Red Flags/Verification) — the format spec is `docs/skill-anatomy.md` in the fork, or `docs/skill-anatomy.md` inside the reference snapshot at [`docs/agent-skills-main.zip`](./docs/agent-skills-main.zip); don't invent a different shape for TFRS-only skills.
3. **This playbook does not create those `skills/tfrs/` skills** — that work happens in the fork itself, as its own scoped effort (see Remaining Gaps in the pull request that introduced this document). This document only defines where they belong once they exist and how the playbook's own commands (`commands/backlog.md`, `commands/repo-health.md`) relate to them in the meantime.
4. **Known current gap**: as of this writing, the fork's own `.claude-plugin/marketplace.json` and `.claude-plugin/plugin.json` still list `addyosmani/agent-skills` as the plugin source and owner — they haven't been re-pointed at the TFRS fork yet. Until that's fixed in the fork, installing via Claude Code's marketplace mechanism (`/plugin marketplace add https://github.com/TFRS-Admin/agent-skills.git`) will still resolve the plugin's *source* to the upstream repository rather than the TFRS fork, silently missing any `skills/tfrs/` additions. See [`docs/agent-skills-integration.md`](./docs/agent-skills-integration.md) for the current safe way to reference the fork until that's corrected.

## Related Documents

- [`docs/agent-skills-integration.md`](./docs/agent-skills-integration.md) — the walked-through version of this standard with a worked example
- [`README.md`](./README.md#engineering-methodology-lineage) — the one-time methodology synthesis, a distinct relationship from the ongoing one this document defines
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — the broader operating loop this document's workflow nests inside
- [`AI_ENGINEERING_WORKFLOW.md`](./AI_ENGINEERING_WORKFLOW.md#terminology-map) — where TFRS and the reference methodology use the same words differently
