<!-- Purpose: Index reusable setup templates for bootstrapping or aligning TFRS repositories. -->
# TFRS Template Index

## Repository Setup Templates

- [`new-repo-checklist.md`](./new-repo-checklist.md): use when creating a brand-new TFRS repository.
- [`repository-architecture-template.md`](./repository-architecture-template.md): use to seed the required root `ARCHITECTURE.md`; keep it current.
- [`github-actions-template.yml`](./github-actions-template.yml): use when scaffolding a TypeScript repository workflow with typecheck, lint, test, and build jobs.

## Repository Engineering Docs

These two, plus `ARCHITECTURE.md` above, are the required repository-local documentation every adopted repository must have per [`../REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md):

- [`engineering-roadmap-template.md`](./engineering-roadmap-template.md): seeds `docs/engineering/ROADMAP.md` — sequenced Epics, each as its own section, produced by [`../commands/roadmap.md`](../commands/roadmap.md) and [`../commands/backlog.md`](../commands/backlog.md).
- `docs/engineering/backlog/`: an empty directory, not a template — this is where [`../commands/backlog.md`](../commands/backlog.md) writes one file per work item, using [`engineering-task-template.md`](#backlog-and-work-item-templates) below. There is no separate index file for it.

## Backlog and Work-Item Templates

- [`engineering-task-template.md`](./engineering-task-template.md): the one work-item template — covers features, bugs, and technical debt alike. Use for every entry in `docs/engineering/backlog/`.
- [`backlog-initialization-template.md`](./backlog-initialization-template.md): use when standing up a backlog from scratch in a repository with no existing work-item files.

## Evidence and Decision Templates

- [`adr-template.md`](./adr-template.md): the canonical Architecture Decision Record template.
- [`verification-report-template.md`](./verification-report-template.md): the evidence artifact produced by [`../commands/verify.md`](../commands/verify.md).
