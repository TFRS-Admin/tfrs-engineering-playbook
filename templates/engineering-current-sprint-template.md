<!-- Purpose: Seed docs/engineering/CURRENT_SPRINT.md — what's actively in flight, read before GitHub Issues themselves in the "what's next" order. -->
# Engineering Current Sprint Template

Copy this to `docs/engineering/CURRENT_SPRINT.md` at the repository root. This is the third document an agent reads (after `AGENTS.md` and `CLAUDE.md`) when determining current work, per [`AI_AGENT_OPERATING_MODEL.md#2-how-to-determine-current-work`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/AI_AGENT_OPERATING_MODEL.md#2-how-to-determine-current-work) — it exists so "what's in flight right now" never requires scanning every open issue. Links below use the full GitHub URL, not a relative path, since this file lives in `docs/engineering/` once copied into a downstream repository — see [`commands/setup-from-playbook.md#minimum-baseline`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/commands/setup-from-playbook.md#minimum-baseline) for the same convention applied to the copied baseline files.

---

# Current Sprint: Q3 Sprint 1 (2026-07-01 to 2026-07-14)

## Committed This Sprint

| Issue | Status | Owner | Notes |
| --- | --- | --- | --- |
| #143 Add server-side contact form validation | In Progress | Implementer agent | On track |
| #144 Add integration tests for contact form validation boundary | Backlog | — | Blocked by #143, same PR |

## Blocked

None currently.

## At Risk

None currently.

## Empty-Sprint Declaration

If nothing is currently committed to a sprint, replace the sections above with:

> No sprint is currently active as of `<date>`. See sibling `docs/engineering/BACKLOG.md` for `Ready` work awaiting sprint assignment.

## Last Updated

2026-07-09, by [`commands/backlog.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/commands/backlog.md) (sprint planning step) — cleared at sprint close per [`BACKLOG_STANDARD.md#sprint-planning`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/BACKLOG_STANDARD.md#sprint-planning).

## Related Documents

[`BACKLOG_STANDARD.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/BACKLOG_STANDARD.md) · [`templates/sprint-review-template.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/templates/sprint-review-template.md) · sibling `docs/engineering/BACKLOG.md`
