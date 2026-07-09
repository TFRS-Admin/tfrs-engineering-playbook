<!-- Purpose: Index the executable command library and adoption procedures for TFRS repositories. -->
# TFRS Commands Index

## Purpose

These are executable prompts, not general documentation. Each one is written so an AI agent (or a human) can run it directly against a repository and produce a defined output. Not sure which one applies to a plain-language request? Start with [`../DECISION_ROUTER.md`](../DECISION_ROUTER.md) instead of guessing. Together, these commands operationalize the full engineering lifecycle:

```text
review → roadmap → plan → backlog → execute → verify → ship
                                                  ↑
                                          repo-health (recurring, cross-cutting)
```

## Lifecycle Commands

- [`review.md`](./review.md): assess current state and produce findings, before planning begins.
- [`roadmap.md`](./roadmap.md): sequence findings and business priorities into Epics.
- [`plan.md`](./plan.md): turn an approved finding/Epic into a sized implementation strategy.
- [`backlog.md`](./backlog.md): convert a plan into Epics, Issues, and repository engineering documentation, with execution order set — the executable version of [`../BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md). No GitHub Project is required.
- [`execute.md`](./execute.md): implement a single `Ready` issue.
- [`verify.md`](./verify.md): produce evidence that an implementation satisfies its acceptance criteria.
- [`ship.md`](./ship.md): merge, release, and communicate a verified change.
- [`repo-health.md`](./repo-health.md): run the recurring repository health assessment — the executable version of [`../REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md).

## Adoption Guides

- [`setup-from-playbook.md`](./setup-from-playbook.md): use when aligning an existing repository to this playbook. For the full end-to-end bootstrap procedure, including establishing repository engineering documentation and the first pass through the lifecycle, see [`../REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md).

## Related Documents

- [`../DECISION_ROUTER.md`](../DECISION_ROUTER.md) — maps a plain-language request to one of the commands above.
- [`../AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md) — how an agent decides which command to run next.
- [`../SKILLS_STANDARD.md`](../SKILLS_STANDARD.md) — for the step-by-step mechanics inside a command, consult the matching skill in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills); these commands define what's required, the skills fork defines how to execute it.
