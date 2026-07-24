<!-- Purpose: Production-ready template for standing up a backlog from scratch in a repository with no existing work-item files. -->
# Backlog Initialization Template

Use this when a repository has no existing backlog — a new repository (see [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md)) or first adoption of [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) in an existing one.

---

## Backlog Initialization: tfrs-website

### 1. Repository Engineering Docs Confirmed

- [x] `docs/engineering/ROADMAP.md` present (seeded from [`templates/engineering-roadmap-template.md`](./engineering-roadmap-template.md)).
- [x] `docs/engineering/backlog/` directory present.

### 2. Source Artifacts

- Review findings: `tfrs-website` contact form and content pipeline review, 2026-07-09 (see [`commands/review.md`](../commands/review.md) example).
- Roadmap: `docs/engineering/ROADMAP.md`, "Harden tfrs-website form and content pipeline" Epic (see [`commands/roadmap.md`](../commands/roadmap.md) example).
- Plans: contact form validation plan (see [`commands/plan.md`](../commands/plan.md) example).

### 3. Initial Epic and Work-Item Set

| File | Priority | Size | Blocked |
| --- | --- | --- | --- |
| Epic: "Harden tfrs-website form and content pipeline" (`ROADMAP.md` section) | P1 | L | No |
| `FORM-01-add-server-side-contact-form-validation.md` | P1 | S | No |
| `FORM-02-add-contact-form-validation-tests.md` | P1 | S | Yes (by FORM-01) |
| `META-01-introduce-shared-page-metadata-source.md` | P1 | M | No |
| `META-02-add-metadata-migration-tests.md` | P2 | S | Yes (by META-01) |

### 4. Dependency Graph

```text
Epic: Harden tfrs-website form and content pipeline
 ├─ FORM-01 (unblocked, first)
 │   └─ FORM-02 (blocked by FORM-01)
 └─ META-01 (unblocked, parallel to FORM-01)
     └─ META-02 (blocked by META-01)
```

### 5. Execution Order Confirmed

1. FORM-01 and META-01 run in parallel — neither blocks the other.
2. FORM-02 starts once FORM-01 merges.
3. META-02 starts once META-01 merges.

### 6. Repository Engineering Docs Updated

`docs/engineering/backlog/` now holds the four files listed in step 3; `docs/engineering/ROADMAP.md`'s Epic section lists them as child work items. There is no separate backlog index file to update — the directory listing is the backlog.

### 7. Sign-off

Backlog initialization reviewed and approved by the operator before any work item moves to `Ready`.

## Related Documents

[`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) · [`commands/backlog.md`](../commands/backlog.md) · [`WORK_ITEM_METADATA_STANDARD.md`](../WORK_ITEM_METADATA_STANDARD.md)
