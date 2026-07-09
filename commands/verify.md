<!-- Purpose: Executable procedure for producing evidence that an implementation satisfies its acceptance criteria. -->
# Command: Verify

## Purpose

Produce evidence — not assertion — that an implementation satisfies its acceptance criteria. This is the operational expression of the guiding principle "Verification provides evidence." Nothing moves to `Done`, and no PR is marked ready for review, without a completed verification report.

If you are running inside Claude Code and this repository has the built-in `verify` skill available, invoke it to drive the change end-to-end in addition to following the steps below — the skill and this command are complementary, not redundant: the skill drives the feature, this command defines what evidence must be captured and where it's attached.

## When to Use It

- After implementation, before opening or marking a PR ready for review (called from [`commands/execute.md`](./execute.md)).
- During a QA pass on any issue where `QA Required` = `Yes`.
- As part of a [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md) testing-dimension check.

## Required Inputs

- The issue or PR being verified.
- Its acceptance criteria (Given/When/Then).
- The `QA Required` field value.

## Workflow

1. List every acceptance criterion from the issue individually — verification is per-criterion, not "overall it works."
2. For each criterion, run the actual behavior: execute the test, drive the feature through the UI/API/CLI, or reproduce the exact steps a user would take. Do not rely on reading the code and reasoning that it should work.
3. Capture evidence for each criterion: command output, test result, screenshot, or a precise description of manual steps taken and what was observed.
4. Mark each criterion Pass / Fail / Not Verifiable (with reason) — never silently omit a criterion.
5. If any criterion fails, stop here — do not proceed to [`commands/ship.md`](./ship.md). Return to [`commands/execute.md`](./execute.md) to fix it.
6. Fill out [`templates/verification-report-template.md`](../templates/verification-report-template.md) with the results.
7. Attach the report to the PR (and to the issue if `QA Required` = `Yes`).

## Required Outputs

- A completed verification report, one line of evidence per acceptance criterion, attached to the PR/issue.
- An explicit Pass/Fail/Not-Verifiable status for the whole change.

## Quality Gates

- Every acceptance criterion has explicit evidence — "looks fine" or "should work" is never sufficient.
- A failing criterion blocks proceeding to `Ship`; there is no partial pass.
- Gaps (untestable criteria due to missing infrastructure) are stated as gaps, not silently dropped from the report.

## Failure Handling

- **No automated test infrastructure exists for a criterion**: document the exact manual steps taken and observed, and note the automation gap as a follow-up (file it, don't just mention it) rather than skipping verification entirely.
- **A criterion fails**: do not weaken the criterion to make it pass. Fix the implementation or send it back to `Plan` if the criterion itself was wrong.
- **Verification reveals scope creep** (the diff does things the acceptance criteria didn't ask for): flag it — this is a signal to trim the diff, not just to verify the extra behavior too.

## Example

**Input:**
> PR #201 implementing issue #143, acceptance criteria per the `commands/plan.md` example.

**Output (excerpt):**
```text
Criterion 1: Given a POST to /api/contact with a missing required field,
  when processed, then a 400 with field-level error is returned.
  Evidence: `curl -X POST .../api/contact -d '{"email":""}'` → 400,
  body `{"errors":{"email":"required"}}`. PASS.

Criterion 2: Integration tests cover the validation boundary.
  Evidence: `npm test -- contact-form.integration.test.js` → 6 passed, 0 failed.
  PASS.

Overall: PASS. No gaps. Proceeding to commands/ship.md.
```
