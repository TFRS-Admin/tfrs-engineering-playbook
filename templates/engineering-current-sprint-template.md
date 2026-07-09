<!-- Purpose: Seed docs/engineering/CURRENT_SPRINT.md — what's actively in flight, read before GitHub Issues themselves in the "what's next" order. -->
# Engineering Current Sprint Template

Copy this to `docs/engineering/CURRENT_SPRINT.md` at the repository root. This is the third document an agent reads (after `AGENTS.md` and `CLAUDE.md`) when determining current work, per [`AI_AGENT_OPERATING_MODEL.md#2-how-to-determine-current-work`](../AI_AGENT_OPERATING_MODEL.md#2-how-to-determine-current-work) — it exists so "what's in flight right now" never requires scanning every open issue.

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

> No sprint is currently active as of `<date>`. See [`docs/engineering/BACKLOG.md`](../templates/engineering-backlog-template.md) for `Ready` work awaiting sprint assignment.

## Last Updated

2026-07-09, by [`commands/backlog.md`](../commands/backlog.md) (sprint planning step) — cleared at sprint close per [`BACKLOG_STANDARD.md#sprint-planning`](../BACKLOG_STANDARD.md#sprint-planning).

## Related Documents

[`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md) · [`templates/sprint-review-template.md`](./sprint-review-template.md) · sibling `docs/engineering/BACKLOG.md`
