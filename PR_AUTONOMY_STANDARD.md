<!-- Purpose: Define when an AI agent may merge a pull request automatically and when it must stop for human approval. -->
# TFRS PR Autonomy Standard

## Purpose

[`commands/ship.md`](./commands/ship.md) merges a verified, approved change — but "approved" has always meant "a human approved it," with no distinction between a one-line dependency bump and a change to authentication. That is unnecessary friction for the former and correctly cautious for the latter, but treating both identically wastes human attention on the low-risk case without buying any extra safety on the high-risk one. This document closes that gap: it defines exactly which changes an agent may merge on its own once verification passes, and which always require a human in the loop — and for the highest-risk category, which a human must physically merge themselves.

## Guiding Principle

> Minimize unnecessary human interaction. Preserve human oversight for anything that could meaningfully hurt the business, its customers, or its security posture if it goes wrong. When a change's classification is genuinely ambiguous, resolve the ambiguity toward more oversight, not less — an unnecessary approval request costs a human a few minutes; an unwarranted autonomous merge of a high-risk change can cost much more, and that asymmetry should drive every default in this document.

## Where This Fits

- [`commands/verify.md`](./commands/verify.md) is the evidence gate this standard consumes — nothing in this document runs before verification has produced a passing report.
- [`commands/ship.md`](./commands/ship.md) is the executable workflow this standard now governs: ship.md's merge step reads this document to decide whether it can proceed unattended or must stop and wait.
- [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md) remains the approval bar a PR's diff must clear; this document decides *who* clears the final merge action once that bar is met, not what the bar itself is.
- [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md)'s `Risk` field is a *planning-time estimate* set before implementation begins; the merge-level classification in this document is a *merge-time decision* made from the actual diff. They usually agree — a `Risk: Critical` issue is very unlikely to resolve to Level 1 — but the diff is authoritative at merge time, since real implementation sometimes touches more (or less) than the issue anticipated.
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) and [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) reference this document for exactly when a finished task ends in a merge versus a wait.

## The Three Merge Levels

### Level 1 — Autonomous

**The agent merges automatically once verification and the requirements below all pass — no human approval step is inserted.**

Applies to changes whose worst-case failure mode is cheap and fast to detect and revert, and which do not touch a trust boundary, business-critical logic, or a shared contract. Representative categories (not exhaustive — classify by the criteria in [How to Classify a Change](#how-to-classify-a-change), not by pattern-matching a title):

- Documentation-only changes (including this playbook's own non-behavioral docs).
- Dependency updates that are patch/minor version bumps with a green build and no reported breaking change (a major-version bump is never Level 1 by default — see [`SECURITY_STANDARD.md#dependency-auditing`](./SECURITY_STANDARD.md#dependency-auditing)).
- Test additions or improvements that do not change production code.
- CI/workflow configuration improvements that do not weaken a required check or a branch protection.
- Styling/formatting changes with no logic change (auto-formatter output, lint-fix output).
- Repository adoption work (Minimum Baseline files, `docs/engineering/` scaffolding) per [`REPOSITORY_BOOTSTRAP_GUIDE.md`](./REPOSITORY_BOOTSTRAP_GUIDE.md).
- Engineering documentation updates (`ARCHITECTURE.md`, `docs/engineering/*.md`) that record already-true state.
- Issue `## Metadata` block updates and other structured-text bookkeeping per [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md).

### Level 2 — Approval Required

**The agent prepares the PR, runs verification, and stops — it does not merge until a human explicitly approves in this instance.** Once approval is given, the agent may perform the merge action itself.

Applies to changes with a real, non-trivial blast radius if wrong, but where a knowledgeable human reviewing the diff and evidence can reasonably judge safety before merge. Representative categories:

- Authentication and authorization logic.
- Pricing, billing, or margin-affecting logic.
- Permissions, roles, and access-control changes.
- Business logic changes to a revenue-critical or customer-facing flow.
- API contract changes (request/response shape, versioning, backward compatibility).
- Database schema changes that are additive/reversible (see Level 3 for destructive ones).
- Infrastructure and deployment configuration.
- Architectural changes (new service/adapter boundary, dependency-direction changes).
- Large UI changes (see [`REVIEW_STANDARD.md#change-sizing`](./REVIEW_STANDARD.md#change-sizing) for what counts as large).

### Level 3 — Manual Only

**The agent never performs the merge action, under any circumstance, including after a human says "go ahead."** The agent prepares the change, runs verification, and hands off — a human merges it directly, not the agent on the human's behalf. This is a stricter guarantee than Level 2: Level 2's approval is a chat instruction the agent then acts on; Level 3 exists precisely for changes where the category itself often requires verification outside the chat context (a security team sign-off, a compliance review, a coordinated rollback window) that a chat approval cannot substitute for or prove happened.

Representative categories:

- Anything touching production secrets, credentials, or key material.
- Security incident response of any kind.
- Emergency rollback of a production incident.
- Destructive or irreversible data migrations.
- Legal or compliance-driven changes (terms of service, privacy policy, regulated-data handling).

## How to Classify a Change

Classify the **whole PR** at the level of its highest-risk file or hunk — a PR is never "mostly Level 1 with one Level 2 line"; one Level 2 change makes the entire PR Level 2 (and likewise for Level 3). This is exactly why [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md) and [`REVIEW_STANDARD.md#change-sizing`](./REVIEW_STANDARD.md#change-sizing) push toward small, single-purpose PRs: a PR that mixes a documentation fix with a permissions change should be split, not merged at the lower level by omission.

1. **Check Level 3 first.** If any part of the diff touches a Level 3 category, stop — the whole PR is Level 3, regardless of how small the rest of it is.
2. **Check Level 2 next.** If any part of the diff touches a Level 2 category, or the issue's `## Metadata` `Risk` is `High` or `Critical`, the whole PR is Level 2.
3. **Otherwise, Level 1** — but only if every requirement in [Level 1 Requirements](#level-1-requirements) below is also satisfied; a change that matches a Level 1 category but fails one of those requirements (e.g., an unresolved review comment) is not autonomous-eligible until it's resolved, even though its risk category hasn't changed.
4. **When genuinely ambiguous** — the change doesn't clearly match a listed category, or reasonable people could disagree — classify as Level 2, per the Guiding Principle. Do not invent a justification to reach Level 1.
5. **A repository may narrow this further**, never widen it: per [`SKILLS_STANDARD.md#precedence-on-conflict`](./SKILLS_STANDARD.md#precedence-on-conflict), a repository's own `AGENTS.md` may declare additional categories Level 2 or Level 3 that this document lists as Level 1 (for example, a repository handling regulated data might elevate all dependency updates to Level 2). A repository's local guidance may never *loosen* a Level 2 or Level 3 classification down to Level 1 — that would require a change to this canonical standard, not a local override.

## Level 1 Requirements

All of the following must hold, in addition to the change matching a Level 1 category, before an agent merges autonomously:

- **Verification passed** — a passing [`commands/verify.md`](./commands/verify.md) report is attached; no verification step was skipped or marked "assumed."
- **Scope limited to one issue** — the PR closes exactly one issue (or is explicitly scoped to one bounded piece of bookkeeping, e.g. a `## Metadata` migration batch); no opportunistic scope creep per [`AI_AGENT_OPERATING_MODEL.md#7-how-to-avoid-scope-expansion`](./AI_AGENT_OPERATING_MODEL.md#7-how-to-avoid-scope-expansion) (note: numbering may shift as that document evolves — the referenced section is "How to Avoid Scope Expansion").
- **No unresolved review comments** — including automated review-bot comments, not only human ones; a `Nit:`-labeled comment does not block, per [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md#how-to-give-constructive-feedback), but anything unlabeled or `Critical:` does.
- **No merge conflicts** — the branch merges cleanly against its target; the agent does not force-resolve a conflict as part of an autonomous merge.
- **Required status checks are green** — every required CI check per branch protection, not a subset.
- **No branch-protection bypass** — no `--no-verify`, no admin override, no force-push to the target branch, ever, autonomous or not (this is already forbidden generally per [`AGENTS.md#what-agents-must-not-do`](./AGENTS.md#what-agents-must-not-do); restated here because it is the one rule this document cannot loosen under any interpretation of "minimize friction").
- **The repository has not opted out** — if a repository's own `AGENTS.md` restricts or disables Level 1 autonomous merging per the override mechanism above, that restriction wins.

If any requirement fails, the change is handled as Level 2 for this merge even if its risk category alone would have qualified for Level 1 — fix the blocking condition (resolve the comment, rebase, wait for CI) and re-evaluate, or get explicit human approval to proceed anyway.

## Session Behavior

This is the procedure [`commands/ship.md`](./commands/ship.md) follows once [`commands/verify.md`](./commands/verify.md) has produced a passing report for a task:

1. **Classify the merge level** per [How to Classify a Change](#how-to-classify-a-change).
2. **If Level 1:**
   - Merge the PR (respecting branch protections, per [`commands/ship.md`](./commands/ship.md)).
   - Close the linked issue with `state_reason: completed` and move its `## Metadata` `Status` to `Done`.
   - Update `docs/engineering/CURRENT_SPRINT.md` (remove the shipped item) and `docs/engineering/BACKLOG.md` (mark it `Done`) if the repository maintains them.
   - Recommend the next `Ready`, unblocked issue per [`AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-issue`](./AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-issue) — informational, not a second autonomous action; starting that next issue is still a separate, explicit invocation.
3. **If Level 2 or Level 3:** present, then wait — do not merge, and do not treat silence or an unrelated follow-up message as approval:
   - **Verification evidence** — the full [`commands/verify.md`](./commands/verify.md) report.
   - **Risk summary** — which category triggered Level 2/3, and the specific trust boundary, business logic, or irreversibility concern in plain language.
   - **Files changed** — the diff summary (file list plus line counts at minimum; the full diff if the reviewer wants it).
   - **Issue completed** — confirmation the linked issue's acceptance criteria are met, with the issue reference.
   - For **Level 2**: once a human explicitly approves in this session, the agent may proceed with the same merge/close/update sequence as step 2.
   - For **Level 3**: the agent never performs the merge itself, even after approval — state plainly that a human needs to merge this one directly, and stop there. The agent may still perform the close/update bookkeeping *after* the human confirms the merge has actually happened, not before.

## Related Documents

- [`commands/ship.md`](./commands/ship.md) — the executable workflow this standard governs
- [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md) — the approval bar a diff must clear before this standard's merge-level question is even relevant
- [`ISSUE_METADATA_STANDARD.md`](./ISSUE_METADATA_STANDARD.md) — the `Risk` field this standard's classification cross-checks against
- [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md) — the boundary/threat-model discipline behind several Level 2/3 categories
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — how an agent reaches the point of shipping, and what "stop" means generally
- [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) — routes "merge this PR" / "ship this feature" / "finish this issue" requests through this standard
- [`SKILLS_STANDARD.md#precedence-on-conflict`](./SKILLS_STANDARD.md#precedence-on-conflict) — how a repository may narrow (never widen) these levels locally
