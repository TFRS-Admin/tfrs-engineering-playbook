<!-- Purpose: Define the canonical testing discipline for TFRS repositories — the practice that makes commands/verify.md's evidence requirement possible. -->
# TFRS Testing Standard

## Purpose

[`commands/verify.md`](./commands/verify.md) requires evidence, not assertion, that acceptance criteria are met. That evidence has to come from somewhere — this document is the testing discipline that produces it. Previously TFRS's only testing guidance was a single "Tests" bullet in [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md); that bullet now points here for the full standard.

This standard synthesizes practices adopted from the `agent-skills` engineering methodology (see [`docs/agent-skills-main.zip`](./docs/agent-skills-main.zip), credited in [`README.md`](./README.md#engineering-methodology-lineage)), adapted to TFRS's TypeScript-heavy delivery model.

## Red-Green-Refactor

Write tests as part of implementing, not after:

1. **Red** — write a failing test that describes the behavior you're about to build.
2. **Green** — write the minimal code that makes it pass.
3. **Refactor** — clean up the implementation with the test still passing; re-run the suite after every refactor step, not just at the end.

For a bug fix, use the same cycle in **Prove-It** form: reproduce the bug as a failing test first, confirm it fails for the reason you think it does, then fix the code until the test passes, then run the full suite to confirm no regression. A bug fix without a regression test isn't done — see the [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md#6-how-to-document-evidence) evidence requirement.

## Test Coverage Shape

Aim for roughly this distribution of test effort across a codebase — not a hard quota, a shape to notice you're drifting from:

- **~80% unit tests** — pure logic, no I/O, isolated, fast (milliseconds).
- **~15% integration tests** — component interactions and API boundaries, real dependencies where practical.
- **~5% end-to-end tests** — full user flows through a real browser or client, reserved for the paths that matter most.

A codebase that is mostly E2E tests is slow to run and slow to debug when something breaks; a codebase with only unit tests can pass while the integrated system is broken. Both ends are a red flag.

### A Note on "Size" Terminology

The source methodology this is adapted from also names a *resource-based* test-sizing scale (no I/O vs. localhost-only vs. full external services). TFRS intentionally does **not** reuse the labels `Small`/`Medium`/`Large` for that scale, because [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) already uses `S`/`M`/`L`/`XL` for issue-effort sizing, and reusing near-identical labels for a different axis would be exactly the kind of inconsistent terminology this playbook is trying to eliminate. If you need to talk about a test's resource footprint, describe it directly — "no I/O," "local services only," "hits external services" — rather than inventing another size scale.

## Test Style: DAMP Over DRY

Production code should be DRY (Don't Repeat Yourself). Test code should be **DAMP** (Descriptive And Meaningful Phrases) instead: a test should read as a self-contained specification of one behavior, even if that means repeating setup that a shared helper could have hidden. A reader debugging a failing test should be able to understand it without tracing through three layers of shared fixtures. Some duplication in test code is the acceptable cost of independent readability — don't "DRY up" tests at the expense of that.

## The Beyoncé Rule

**"If you liked it, you should have put a test on it."** A refactor, a migration, or an infrastructure change is not exempt from needing test coverage for the behavior it touches — the change itself isn't what's supposed to catch your bugs, your tests are. If you're about to refactor code that has no tests, add the tests first — this is the same discipline as Chesterton's Fence in [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md#complexity--simplification): understand and cover the existing behavior before you touch it.

## What Counts as Evidence

Per [`commands/verify.md`](./commands/verify.md), a passing test run is evidence; a claim that code "should work" is not. Concretely:

- Command output showing the test suite passed (not a paraphrase of it).
- For browser-facing behavior, drive the actual UI (or use the environment's `verify` skill if available) rather than reasoning about the code in the abstract.
- When automated test infrastructure genuinely doesn't exist for a criterion, document the exact manual steps taken and observed, and file the automation gap as a [`templates/technical-debt-template.md`](./templates/technical-debt-template.md) issue rather than letting the gap go unrecorded.

## Related Documents

- [`commands/verify.md`](./commands/verify.md) — the executable procedure that consumes this discipline as evidence
- [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md) — the Tests review axis points here for full detail
- [`REPO_HEALTH_STANDARD.md`](./REPO_HEALTH_STANDARD.md) — the Testing dimension uses the coverage-shape guidance above
- [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) — the `QA Required` field, which determines when a full verification report is mandatory
- If working in Claude Code and this environment has the built-in `verify` skill available, use it to drive a change end-to-end before attaching evidence to a PR.
