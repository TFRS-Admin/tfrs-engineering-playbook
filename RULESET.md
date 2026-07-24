<!-- Purpose: The short operating ruleset that replaced EXECUTION_STANDARD.md, REVIEW_STANDARD.md, and PLANNING_STANDARD.md in v4.0.0 — see VERSION.md for why. -->
# TFRS Operating Ruleset

TFRS is one non-engineer operator working through AI agents — there is no second reviewer, no sprint, no team to coordinate branch lifetimes with. This document is what's left after cutting the coordination machinery that assumed one existed. If a rule below doesn't have a reader, it doesn't belong here; say so rather than re-adding it quietly.

1. **READ FIRST.** Read `CLAUDE.md` and repo docs before proposing changes. If they contradict the request, say so — don't silently pick.
2. **PLAN, THEN ONE THING.** Short checklist plan, wait for approval, do one task, stop. No adjacent work or unrequested refactors. Most work items need nothing beyond a checklist and the acceptance criteria on the work-item file; write a fuller plan first when the work is genuinely large, requirements are ambiguous or come from conflicting priorities, or it touches an architectural decision worth an ADR (see [`templates/adr-template.md`](./templates/adr-template.md)) — don't manufacture process for a change that doesn't need it. Before changing code you don't understand, know why it's there (Chesterton's Fence) — don't tear down a fence you can't explain; check `git blame` and linked ADRs in [`docs/decision-log/`](./docs/decision-log/README.md) if it's not obvious. A hand-edited refactor over roughly 500 lines is a sign to reach for automation (a codemod or scripted transform) instead, or to split it from any feature/bugfix work entirely.
3. **EVIDENCE, NOT ASSERTION.** Never claim something works without showing how you know — the command run and its actual output. If you didn't verify it, say so. This applies the same to AI-generated code as to your own: verify it does what it claims and didn't invent an API.
4. **PRODUCTION IS ONE-WAY.** Anything touching live data, config, or a live theme is staged and approved first. Show before and after. Never apply then report.
5. **ASK WHEN AMBIGUOUS.** Conflicting requirements, unclear scope, or architecture/security changes: stop and ask.
6. **SECRETS NEVER MOVE.** Not into code, logs, or chat.
7. **RESET, DON'T PUSH THROUGH.** Commit at every point the work actually functions. If the next step breaks it, reset to that commit and retry rather than debugging forward through a broken state. Same failure twice means stop and escalate, not a third blind attempt.

## Branch and Commit Conventions

- Branch prefixes and Conventional Commits format are defined in [`AGENTS.md`](./AGENTS.md) — this document doesn't restate them.
- Reference the work item in every commit that implements it, using a trailer: `work-item: <EPIC>-<NN>-<slug>.md`. This is what recovers "which commits touched which work item" now that there's no GitHub Issue for a PR to auto-close — `git log --grep` finds it directly.

## Related Documents

- [`AGENTS.md`](./AGENTS.md) — naming, style, commit format, branch prefixes this document builds on
- [`TESTING_STANDARD.md`](./TESTING_STANDARD.md) and [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md) — the two standards that still carry their own full detail; this document doesn't restate testing or security guidance
- [`WORK_ITEM_METADATA_STANDARD.md`](./WORK_ITEM_METADATA_STANDARD.md) — how a work item is sized, blocked, and tracked
- [`commands/`](./commands/README.md) — where these rules get applied phase by phase
