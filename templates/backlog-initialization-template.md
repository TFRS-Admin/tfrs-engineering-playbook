<!-- Purpose: Production-ready template for standing up a backlog from scratch in a repository with no existing GitHub Project execution. -->
# Backlog Initialization Template

Use this when a repository has no existing backlog — a new repository (see [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md)) or first adoption of [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) in an existing one.

---

## Backlog Initialization: tfrs-website

### 1. Project Confirmed

- [x] GitHub Project `tfrs-website Delivery` created and attached to the repository.
- [x] All ten required fields present: `Status`, `Phase`, `Priority`, `Risk`, `Size`, `Sprint`, `Epic`, `QA Required`, `Blocked`, `Agent Persona`.
- [x] All eight board views present: Roadmap, Backlog, Ready, In Progress, Review, QA, Release, Completed.

### 2. Source Artifacts

- Review findings: `tfrs-website` contact form and content pipeline review, 2026-07-09 (see [`commands/review.md`](../commands/review.md) example).
- Roadmap: Q3 roadmap, item 1 (see [`commands/roadmap.md`](../commands/roadmap.md) example).
- Plans: contact form validation plan (see [`commands/plan.md`](../commands/plan.md) example).

### 3. Initial Epic and Issue Set

| Issue | Type | Priority | Size | Blocked | Sprint |
| --- | --- | --- | --- | --- | --- |
| #142 | Epic | P1 | L | No | Q3 Sprint 1-2 |
| #143 | Task | P1 | S | No | Q3 Sprint 1 |
| #144 | Task | P1 | S | Yes (by #143) | — |
| #145 | Task | P1 | M | No | Q3 Sprint 2 |
| #146 | Task | P2 | S | Yes (by #145) | — |

### 4. Dependency Graph

```text
#142 (Epic)
 ├─ #143 (unblocked, first)
 │   └─ #144 (blocked by #143)
 └─ #145 (unblocked, parallel to #143)
     └─ #146 (blocked by #145)
```

### 5. Execution Order Confirmed

1. #143 and #145 run in parallel — neither blocks the other.
2. #144 starts once #143 merges.
3. #146 starts once #145 merges.

### 6. Sign-off

Backlog initialization reviewed and approved by a human maintainer before any issue moves to `Ready`.

## Related Documents

[`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) · [`commands/backlog.md`](../commands/backlog.md) · [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md)
