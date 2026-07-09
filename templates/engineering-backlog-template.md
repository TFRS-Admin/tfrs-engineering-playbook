<!-- Purpose: Seed docs/engineering/BACKLOG.md — the repository's own backlog index, kept in sync with GitHub Issues without depending on a GitHub Project. -->
# Engineering Backlog Template

Copy this to `docs/engineering/BACKLOG.md` at the repository root. [`commands/backlog.md`](../commands/backlog.md) writes to this file every time it creates or updates issues — it is not optional bookkeeping, it is where the backlog is read from first per [`AI_AGENT_OPERATING_MODEL.md#2-how-to-determine-current-work`](../AI_AGENT_OPERATING_MODEL.md#2-how-to-determine-current-work).

---

# Backlog: tfrs-website

## Master Epic

#46 — Epic: Repository Stabilization & Production Hardening

## Ready

Ordered by execution priority (see [`BACKLOG_STANDARD.md#execution-ordering`](../BACKLOG_STANDARD.md#execution-ordering)):

| Issue | Epic | Priority | Risk | Size | Blocked |
| --- | --- | --- | --- | --- | --- |
| #56 | #48 Security Hardening | P0 | High | S | No |
| #54 | #47 Pricing Engine Resolution | P0 | Low | XS | No |
| #57 | #49 Performance Correctness | P1 | Low | XS | No |
| #58 | #48 Security Hardening | P1 | Medium | XS | No |

## Backlog (Not Yet Ready)

| Issue | Epic | Reason not Ready |
| --- | --- | --- |
| #72 | #47 Pricing Engine Resolution | Blocked by #54 |
| #71 | #50 Test Suite Health & CI | Blocked by #62 |

## Deferred

| Issue | Epic | Reason |
| --- | --- | --- |
| #70 | #53 Backlog / Future Platform | Explicitly not scheduled |

## Empty-Backlog Declaration

If this repository has no backlog yet, replace the sections above with:

> This repository's backlog is intentionally empty as of `<date>`. No Epics or Issues have been created because `<reason>`. See [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md) for the next step.

## Last Updated

2026-07-09, by [`commands/backlog.md`](../commands/backlog.md).

## Related Documents

[`commands/backlog.md`](../commands/backlog.md) · [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) · [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md) · sibling `docs/engineering/CURRENT_SPRINT.md`
