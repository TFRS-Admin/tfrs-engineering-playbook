<!-- Purpose: Index reusable setup templates for bootstrapping or aligning TFRS repositories. -->
# TFRS Template Index

## Repository Setup Templates

- [`new-repo-checklist.md`](./new-repo-checklist.md): use when creating a brand-new TFRS repository.
- [`repository-architecture-template.md`](./repository-architecture-template.md): use to seed the required root `ARCHITECTURE.md`; keep it current against [`../REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md).
- [`github-actions-template.yml`](./github-actions-template.yml): use when scaffolding a TypeScript repository workflow with typecheck, lint, test, and build jobs.
- [`project-board-template.md`](./project-board-template.md): **optional.** Use only if a repository's humans want a visual GitHub Project dashboard — see [`../GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md). Never required for a repository to be operational.

## Repository Engineering Docs

These four files, plus `ARCHITECTURE.md` above, are the required repository-local documentation every adopted repository must have per [`../REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist`](../REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist) — they replace any dependency on GitHub Project fields or views:

- [`engineering-roadmap-template.md`](./engineering-roadmap-template.md): seeds `docs/engineering/ROADMAP.md` — the sequenced Epic list produced by [`../commands/roadmap.md`](../commands/roadmap.md).
- [`engineering-backlog-template.md`](./engineering-backlog-template.md): seeds `docs/engineering/BACKLOG.md` — the repository's backlog index, kept in sync with GitHub Issues by [`../commands/backlog.md`](../commands/backlog.md).
- [`engineering-current-sprint-template.md`](./engineering-current-sprint-template.md): seeds `docs/engineering/CURRENT_SPRINT.md` — what's actively committed this sprint, read before GitHub Issues themselves in the "what's next" order.
- [`engineering-repo-health-template.md`](./engineering-repo-health-template.md): seeds `docs/engineering/REPO_HEALTH.md` — the running Repository Health Report history per [`../REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md).

## Backlog and Work-Item Templates

- [`epic-template.md`](./epic-template.md): use when creating an Epic that groups related stories/tasks.
- [`engineering-task-template.md`](./engineering-task-template.md): use for the standard Story/Task unit of executable work.
- [`technical-debt-template.md`](./technical-debt-template.md): use to file technical debt found during review, execution, or health checks.
- [`backlog-initialization-template.md`](./backlog-initialization-template.md): use when standing up a backlog from scratch in a repository with no existing issue hierarchy. No GitHub Project is required.

## Evidence and Decision Templates

- [`adr-template.md`](./adr-template.md): the canonical Architecture Decision Record template.
- [`verification-report-template.md`](./verification-report-template.md): the evidence artifact produced by [`../commands/verify.md`](../commands/verify.md).
- [`sprint-review-template.md`](./sprint-review-template.md): use at the close of every sprint to capture what shipped, slipped, and should feed back upstream.
