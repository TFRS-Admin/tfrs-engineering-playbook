<!-- Purpose: Executable procedure for an on-demand repository health checklist. -->
# Command: Repo Health

## Purpose

A short, on-demand checklist for catching drift before it blocks a feature — not a scored, dimension-by-dimension audit with trend tracking. There is no standard document behind this command; the checklist below is the whole thing, and it stays this short on purpose.

## When to Use It

- Whenever it crosses your mind, or before starting a significant piece of new work.
- Before a [`commands/roadmap.md`](./roadmap.md) pass, so roadmap decisions are informed by current repository state.

## Required Inputs

- The repository being checked.

## Required Skill Consultation

Check for `skills/tfrs/repo-health` in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) first. As of this writing it does not exist in the fork yet; until it does, run the checklist below directly. `skills/security-and-hardening` and `skills/test-driven-development` apply to their respective checklist items where relevant.

## Checklist

1. **Dependencies.** Run `npm audit` (or the repository's equivalent). Anything Critical/High and reachable in production code gets fixed now, per [`SECURITY_STANDARD.md#dependency-auditing`](../SECURITY_STANDARD.md#dependency-auditing) — don't wait for a scheduled cycle.
2. **Tests.** Run the full suite. Anything failing, skipped, or flaky gets a work-item file filed via [`commands/backlog.md`](./backlog.md), not just a mental note.
3. **CI.** Confirm the pipeline is green and nothing's been silently disabled.
4. **Docs.** Skim the README and `ARCHITECTURE.md` against actual current behavior — anything stale gets fixed inline if it's small, or filed if it's not.
5. **Backlog sanity.** Glob `docs/engineering/backlog/*.md` — any `Ready`/`In Progress` item that's actually stalled or superseded gets its `Status` corrected on the spot.

If something can't be checked (no dependency manifest, no test suite), say so — that gap is itself worth a work-item file rather than a silent skip.

## Required Outputs

- Whatever findings the checklist above surfaced, filed as work-item files via [`commands/backlog.md`](./backlog.md) if actionable.
- Anything fixed inline during the pass, noted in the commit.

## Quality Gates

- Every actionable finding becomes a tracked work item, not just something mentioned in chat.
- A Critical/High security finding is filed and escalated immediately, not held for later.

## Failure Handling

- **No tooling exists to check something** (e.g., no dependency scanner configured): note the gap and file a work item to add the missing tooling.

## Example

**Input:**
> `tfrs-website`, on-demand check before starting a new feature.

**Output (excerpt):**
```text
Dependencies: npm audit clean.
Tests: 3 skipped tests in checkout flow — filed as
  docs/engineering/backlog/DEBT-04-fix-skipped-checkout-tests.md.
CI: green.
Docs: README still accurate.
Backlog: no stale items found.
```
