<!-- Purpose: Seed docs/engineering/BACKLOG.md — the repository's own backlog index, kept in sync with GitHub Issues without depending on a GitHub Project. -->
# Engineering Backlog Template

Copy this to `docs/engineering/BACKLOG.md` at the repository root. [`commands/backlog.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/commands/backlog.md) writes to this file every time it creates or updates issues — it is not optional bookkeeping, it is where the backlog is read from first per [`AI_AGENT_OPERATING_MODEL.md#2-how-to-determine-current-work`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/AI_AGENT_OPERATING_MODEL.md#2-how-to-determine-current-work). Links below to centralized playbook content use the full GitHub URL rather than a relative path, since this file lives in `docs/engineering/` once copied — a relative `../` link would resolve against the downstream repository, not this one (see [`commands/setup-from-playbook.md#minimum-baseline`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/commands/setup-from-playbook.md#minimum-baseline) for the same convention applied to the copied baseline files).

---

# Backlog: tfrs-website

## Master Epic

#46 — Epic: Repository Stabilization & Production Hardening

## Ready

Ordered by execution priority (see [`BACKLOG_STANDARD.md#execution-ordering`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/BACKLOG_STANDARD.md#execution-ordering)):

| Issue | Epic | Priority | Risk | Size | Blocked |
| --- | --- | --- | --- | --- | --- |
| #56 | #48 Security Hardening | P0 | High | S | No |
| #54 | #47 Pricing Engine Resolution | P0 | Low | S | No |
| #57 | #49 Performance Correctness | P1 | Low | S | No |
| #58 | #48 Security Hardening | P1 | Medium | S | No |

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

> This repository's backlog is intentionally empty as of `<date>`. No Epics or Issues have been created because `<reason>`. See [`REPOSITORY_BOOTSTRAP_GUIDE.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/REPOSITORY_BOOTSTRAP_GUIDE.md) for the next step.

## Last Updated

2026-07-09, by [`commands/backlog.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/commands/backlog.md).

## Related Documents

[`commands/backlog.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/commands/backlog.md) · [`BACKLOG_STANDARD.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/BACKLOG_STANDARD.md) · `ISSUE_METADATA_STANDARD.md` in the playbook repository · sibling `docs/engineering/CURRENT_SPRINT.md`
