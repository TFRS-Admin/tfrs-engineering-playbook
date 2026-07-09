<!-- Purpose: Define the code review standard and approval bar for all TFRS pull requests. -->
# TFRS Review Standard

## Purpose

The review standard ensures that every TFRS pull request is functionally correct, safe, documented, and appropriately scoped before merge.

## Review Checklist

Five things every review checks. **Approve when a change definitely improves overall code health, even if it isn't perfect** — don't block a mergeable change over a personal style preference; raise that as a `Nit` instead (see severity labels below).

### Functionality (Correctness)

- The change satisfies the stated acceptance criteria.
- Edge cases and failure paths are handled deliberately.
- The implementation matches existing repository architecture.

### Tests

- Existing relevant tests pass.
- New or updated behavior has focused validation when infrastructure exists, following [`TESTING_STANDARD.md`](./TESTING_STANDARD.md).
- Manual verification notes are included when automation is unavailable.

### Security

- No secrets or sensitive data are introduced.
- The change follows [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md) — this document does not restate that guidance.
- Tooling output and generated code have been sanity checked before merge.

### Complexity & Simplification

- **Chesterton's Fence**: before removing, renaming, or simplifying existing code, the author (and reviewer) should be able to state why it was written that way in the first place — check `git blame` and linked ADRs in [`docs/decision-log/`](./docs/decision-log/README.md) if it's not obvious. Don't tear down a fence you don't understand.
- **Rule of 500**: a refactor touching more than ~500 lines by hand is a sign to reach for automation (a codemod or scripted transform) instead, or to split the refactor from any feature/bugfix work entirely.
- Prefer clarity over cleverness; a simpler diff that does slightly less is usually better than a clever one that does everything at once.
- If working in Claude Code and this environment has the built-in `simplify` skill available, it implements this section's discipline directly.

### Style

- Repository naming, module, and formatting conventions are preserved.
- The change is appropriately sized for review (see Change Sizing below).
- Unrelated refactors are excluded.

### Documentation

- User-facing or contributor-facing behavior changes are documented.
- Architectural decisions are recorded as an ADR when applicable (see [`templates/adr-template.md`](./templates/adr-template.md)).
- Cross-references, examples, and templates stay accurate.

## Change Sizing

[`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md#pr-size-guidelines) sets the hard cap for a TFRS pull request at 400 lines changed. Within that cap, treat size as a review-quality signal, not just a limit:

| Size | Reviewability |
| --- | --- |
| ~100–300 lines | The size that actually gets a careful, same-day review. Target this. |
| Up to 400 lines | The hard ceiling from `EXECUTION_STANDARD.md` — acceptable, not the goal. |
| 1000+ lines | Too large regardless of the 400-line guideline being a soft target elsewhere; always split (see splitting strategies in `EXECUTION_STANDARD.md`). |

## Approval Requirements

- At least one reviewer should confirm correctness and maintainability.
- Higher-risk changes (`Risk: High` or `Risk: Critical` in the issue's `## Metadata` block — see [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md)) should receive review from the repository owner or area owner.
- No pull request should merge with unresolved `Critical` review comments (see severity labels below).

## AI-Assisted PR Guidelines

When Copilot or another AI wrote part of the change, reviewers should verify:

- The code actually does what the summary claims.
- Generated code did not invent APIs, ignore edge cases, or bypass validation.
- Tests and docs were updated to match the real implementation.
- The PR description clearly notes what was AI-assisted.

## Time SLA

TFRS aims to review pull requests within **24 hours** of being marked ready for review. If a review will be delayed, leave a status comment so work does not stall silently.

## How to Give Constructive Feedback

- Start with the user or system impact.
- Be specific about the file, behavior, or risk you want changed.
- Suggest the expected direction when possible.
- Label every comment so the author knows how to respond:

| Label | Meaning | Author action |
| --- | --- | --- |
| *(no prefix)* | A required change | Must address before merge |
| `Critical:` | Blocks merge | Security vulnerability, data loss, or broken functionality — must fix |
| `Nit:` | Minor, optional | Author may address or ignore at their discretion |
| `Optional:` / `Consider:` | A suggestion worth thinking about | Not required, worth a look |
| `FYI` | Informational only | No action needed |

A review with every comment unlabeled reads as "everything here blocks merge," which is rarely true and slows reviews down — label deliberately.

## Related Documents

This document is the approval bar for a specific pull request's diff. For assessing the *current state* of a system or feature area before planning new work — not a diff — see [`commands/review.md`](./commands/review.md), which produces findings rather than approve/reject decisions; both documents are named "Review" but govern opposite ends of the lifecycle — see the terminology map in [`AI_ENGINEERING_WORKFLOW.md`](./AI_ENGINEERING_WORKFLOW.md#terminology-map) if that's ambiguous. See also [`commands/verify.md`](./commands/verify.md) for the evidence a PR must carry before it reaches this review bar, [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md) and [`TESTING_STANDARD.md`](./TESTING_STANDARD.md) for the full standards behind the Security and Tests axes above, and [`REPO_HEALTH_STANDARD.md`](./REPO_HEALTH_STANDARD.md) for recurring, cadence-driven assessment.
