<!-- Purpose: Walked-through guide to using tfrs-engineering-playbook and TFRS-Admin/agent-skills together, with a worked example. -->
# Using the Playbook and the Skills Fork Together

This is the example-driven companion to [`SKILLS_STANDARD.md`](../SKILLS_STANDARD.md), which is the canonical, authoritative version of everything stated here. If the two ever seem to disagree, `SKILLS_STANDARD.md` wins — this document exists to make that standard concrete, not to add new rules of its own.

## Why Two Repositories

```text
┌─────────────────────────────┐      ┌──────────────────────────────┐
│  tfrs-engineering-playbook  │      │  TFRS-Admin/agent-skills      │
│  (this repo)                │      │  (fork of addyosmani/         │
│                              │      │   agent-skills)               │
│  "What does TFRS require,   │      │  "How do I execute this kind  │
│   and how is work tracked?" │◀────▶│   of task, step by step?"     │
│                              │      │                                │
│  Standards, lifecycle,      │      │  Reusable skill workflows,    │
│  issue Metadata fields,     │      │  quality gates, agent          │
│  TFRS-specific thresholds   │      │  personas, TFRS-only skills    │
└──────────────────────────────┘      │  under skills/tfrs/           │
              ▲                       └──────────────────────────────┘
              │
              │ overrides both, on conflict
              │
   ┌──────────────────────┐
   │ any downstream repo   │
   │ (e.g. tfrs-website)   │
   │ local conventions      │
   └──────────────────────┘
```

Before this integration, an agent working in a TFRS repository had TFRS's standards (this playbook) but no single, reusable place to go for the actual step-by-step mechanics of, say, running a red-green-refactor loop or structuring a five-axis code review — those either got re-derived every time or partially synthesized inline into this playbook's own standards (see [`README.md`](../README.md#engineering-methodology-lineage) for that earlier synthesis work). `TFRS-Admin/agent-skills` is now the live, ongoing answer to "where do I go for that" — a fork TFRS can extend with its own skills without losing the ability to pull in upstream improvements.

## The Workflow, Step by Step

This is the same nine-step sequence defined in [`SKILLS_STANDARD.md#the-skill-consultation-workflow`](../SKILLS_STANDARD.md#the-skill-consultation-workflow), walked through with a concrete example: an agent picking up the `tfrs-website` contact-form-validation task used as the worked example throughout this playbook (see [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md#worked-example-tfrs-website)).

1. **Read local repository instructions first.** The agent reads `tfrs-website`'s own `CLAUDE.md` and finds nothing that overrides the playbook default for this task — proceed to the playbook.
2. **Read the TFRS Engineering Playbook.** The task is implementation work on a `Ready` issue, so the agent reads [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md) and the issue's acceptance criteria.
3. **Identify the task type.** This is "Implementation."
4. **Consult the matching skill in `TFRS-Admin/agent-skills`.** Per the [Skill Selection table](../SKILLS_STANDARD.md#skill-selection), that's `skills/incremental-implementation` and `skills/test-driven-development` — the agent reads both `SKILL.md` files for the actual vertical-slice and red-green-refactor mechanics.
5. **Execute the skill-defined workflow.** The agent implements the server-side validation as a thin vertical slice, writing the test with the implementation per the skill's Red-Green-Refactor cycle.
6. **Apply repository-specific constraints.** The skill's generic guidance doesn't know about TFRS's 400-line PR cap or its Conventional Commits format — the agent applies [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md)'s specifics on top of the skill's generic mechanics, per the precedence order in `SKILLS_STANDARD.md`.
7. **Verify work.** The agent runs [`commands/verify.md`](../commands/verify.md), producing the evidence artifact per [`TESTING_STANDARD.md`](../TESTING_STANDARD.md) — the skill's own verification checklist informed *how* the tests were written, but the playbook's evidence-artifact requirement is what actually gates the PR.
8. **Update the issue's `## Metadata` block.** `Status` moves through `In Progress` → `In Review` per [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md); this happens regardless of what either repository's generic guidance says, because the repository and its issues are TFRS's source of truth, not a skill's own bookkeeping.
9. **Stop.** The agent opens the PR and stops — per [`AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md#4-when-to-stop) — rather than continuing past the acceptance criteria because the skill's workflow "felt" incomplete.

## Referencing the Fork Today

Claude Code can install `agent-skills` as a plugin for automatic skill discovery — but as documented in [`SKILLS_STANDARD.md#fork-management`](../SKILLS_STANDARD.md#fork-management), the fork's own plugin manifest still points at the upstream `addyosmani/agent-skills` repository as of this writing, so the marketplace install path (`/plugin marketplace add https://github.com/TFRS-Admin/agent-skills.git`) will silently resolve to upstream rather than the TFRS fork. Until that's fixed in the fork itself, use one of these instead:

- **Direct local reference (recommended until the manifest is fixed):** `claude --plugin-dir /path/to/local/clone/of/TFRS-Admin/agent-skills` against a clone of the TFRS fork specifically.
- **Read-only consultation (works for any agent, not just Claude Code):** fetch the specific `SKILL.md` file from `https://github.com/TFRS-Admin/agent-skills/tree/main/skills/<skill-name>` when the Skill Selection table points to it — this is sufficient for the "consult the matching skill" step and requires no installation at all.

Either way, never vendor a copy of the fork's `skills/` directory into a downstream repository or into this playbook — that reintroduces the duplication this integration exists to remove.

## Related Documents

- [`SKILLS_STANDARD.md`](../SKILLS_STANDARD.md) — the canonical standard this document walks through
- [`AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md) — the broader per-issue operating loop this workflow nests inside
- [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md) — the `tfrs-website` worked example referenced above, in full
