<!-- Purpose: Define the code review standard and approval bar for all TFRS pull requests. -->
# TFRS Review Standard

## Purpose

The review standard ensures that every TFRS pull request is functionally correct, safe, documented, and appropriately scoped before merge.

## Review Checklist

### Functionality

- The change satisfies the stated acceptance criteria.
- Edge cases and failure paths are handled deliberately.
- The implementation matches existing repository architecture.

### Tests

- Existing relevant tests pass.
- New or updated behavior has focused validation when infrastructure exists.
- Manual verification notes are included when automation is unavailable.

### Security

- No secrets or sensitive data are introduced.
- Input handling, authentication boundaries, and dependency choices are appropriate.
- Tooling output and generated code have been sanity checked before merge.

### Style

- Repository naming, module, and formatting conventions are preserved.
- The change is small enough for an effective review.
- Unrelated refactors are excluded.

### Documentation

- User-facing or contributor-facing behavior changes are documented.
- Cross-references, examples, and templates stay accurate.

## Approval Requirements

- At least one reviewer should confirm correctness and maintainability.
- Higher-risk changes should receive review from the repository owner or area owner.
- No pull request should merge with unresolved critical review comments.

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
- Distinguish blocking issues from optional improvements.

## Related Documents

This document is the approval bar for a specific pull request's diff. For assessing the *current state* of a system or feature area before planning new work — not a diff — see [`commands/review.md`](./commands/review.md), which produces findings rather than approve/reject decisions. See also [`commands/verify.md`](./commands/verify.md) for the evidence a PR must carry before it reaches this review bar, and [`REPO_HEALTH_STANDARD.md`](./REPO_HEALTH_STANDARD.md) for recurring, cadence-driven assessment.
