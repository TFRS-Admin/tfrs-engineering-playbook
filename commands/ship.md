<!-- Purpose: Executable procedure for merging, releasing, and communicating a verified change. -->
# Command: Ship

## Purpose

Merge a verified, approved change, update GitHub to reflect completion, and communicate downstream impact. Ship is the last step of the per-issue lifecycle; it does not begin until [`commands/verify.md`](./verify.md) has produced a passing report.

## When to Use It

- A PR has required approvals, green CI, and a passing verification report attached.
- Never use this command to merge a PR with failing CI or an unresolved blocking review comment — go back to [`commands/execute.md`](./execute.md) instead.

## Required Inputs

- The approved PR.
- Its attached verification report (from [`commands/verify.md`](./verify.md)).
- Release/versioning context if the change affects a tagged release or this playbook's own `VERSION.md`.

## Workflow

1. Confirm required approvals are present per [`REVIEW_STANDARD.md`](../REVIEW_STANDARD.md) and no blocking comments remain unresolved.
2. Confirm CI is green and the verification report is attached and shows an overall Pass.
3. Merge the PR respecting branch protections (no `--no-verify`, no force-merging around a failing required check).
4. Close the linked issue with the correct `state_reason` (`completed`).
5. Move the project item's `Status` to `Done`.
6. If the change affects a versioned artifact (a release, or this playbook itself), update the changelog (`VERSION.md` for this repository; the repository's own release notes elsewhere) per its versioning rules.
7. Communicate downstream impact: if other repositories or teams depend on the changed behavior, note it in the PR/issue and, for playbook changes, in the README adoption table.
8. If the shipped item belongs to a sprint, leave it in the `Release` view until the release actually goes out, then move it to `Completed`.

## Required Outputs

- Merged PR, closed issue, `Status` = `Done`.
- Updated changelog/release notes where applicable.
- Downstream communication recorded where the change has cross-repository impact.

## Quality Gates

- No merge without required approvals and green CI.
- No merge without an attached, passing verification report.
- Issue closed with the correct `state_reason` — never closed silently with no reason.
- Breaking or cross-repository-impacting changes have explicit downstream communication, not just a merged PR.

## Failure Handling

- **CI is red**: do not merge. Return to [`commands/execute.md`](./execute.md); do not bypass required checks.
- **A late review comment blocks merge**: resolve it or explicitly get sign-off that it's a follow-up, tracked as its own issue, before merging.
- **Release communication is unclear who needs it**: default to over-communicating (note it in the PR and the affected repositories' READMEs) rather than assuming no one depends on it.

## Example

**Input:**
> PR #201, approved, CI green, verification report attached with overall PASS (per `commands/verify.md` example).

**Output (excerpt):**
```text
Merged PR #201 into main.
Closed issue #143 (state_reason: completed).
Project item #143: Status → Done.

No cross-repository impact — contact form validation is internal to
tfrs-website. No README/adoption table update needed.

Issue #144 (integration tests, previously Blocked by #143) is now
unblocked: Blocked → No, Status: Backlog → Ready.
```
