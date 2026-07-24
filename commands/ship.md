<!-- Purpose: Executable procedure for merging, releasing, and communicating a verified change. -->
# Command: Ship

## Purpose

Merge a verified change, update its work-item file to reflect completion, and communicate downstream impact. Ship is the last step of the per-item lifecycle; it does not begin until [`commands/verify.md`](./verify.md) has produced a passing report.

## When to Use It

- A PR has green CI and a passing verification report attached.
- Never use this command to merge a PR with failing CI. Go back to [`commands/execute.md`](./execute.md) instead.

## Required Inputs

- The PR.
- Its attached verification report (from [`commands/verify.md`](./verify.md)).
- Release/versioning context if the change affects a tagged release or this playbook's own `VERSION.md`.

## Required Skill Consultation

Mandatory per [`SKILLS_STANDARD.md#when-consultation-is-mandatory`](../SKILLS_STANDARD.md#when-consultation-is-mandatory): consult [`skills/shipping-and-launch`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/shipping-and-launch) in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) for rollout/rollback mechanics; TFRS's own merge-gate specifics still govern per [`RULESET.md`](../RULESET.md) and [`WORK_ITEM_METADATA_STANDARD.md`](../WORK_ITEM_METADATA_STANDARD.md).

## Workflow

1. Self-review the diff against [`RULESET.md`](../RULESET.md) (rule 2: Chesterton's Fence, Rule of 500; rule 3: verify AI-generated code didn't invent an API) and confirm no blocking comments remain unresolved.
2. Confirm CI is green and the verification report is attached and shows an overall Pass.
3. **On the PR branch itself** — not against `main` — move the work item's `## Metadata` `Status` to `Done` and push that commit. Do this before merging, not after: if `main` is protected (per [`templates/new-repo-checklist.md`](../templates/new-repo-checklist.md), it should be), there is no direct-push path to edit a work-item file on `main` once the PR has merged, so the `Status: Done` edit has to land as part of the PR that's about to merge, not as a follow-up. This is still safe to call "done" — the file only reads `Done` on `main` once the merge that makes it true has actually happened, atomically, in the same commit.
4. Merge the PR respecting branch protections (no `--no-verify`, no force-merging around a failing required check).
5. If the change affects a versioned artifact (a release, or this playbook itself), update the changelog (`VERSION.md` for this repository; the repository's own release notes elsewhere) per its versioning rules.
6. Communicate downstream impact: if other repositories depend on the changed behavior, note it in the PR/work-item file and, for playbook changes, in the README adoption table.

## Required Outputs

- Merged PR, work-item file `## Metadata` `Status` = `Done`.
- Updated changelog/release notes where applicable.
- Downstream communication recorded where the change has cross-repository impact.

## Quality Gates

- No merge without green CI.
- No merge without an attached, passing verification report.
- Breaking or cross-repository-impacting changes have explicit downstream communication, not just a merged PR.

## Failure Handling

- **CI is red**: do not merge. Return to [`commands/execute.md`](./execute.md); do not bypass required checks.
- **A late comment blocks merge**: resolve it or explicitly note it as a follow-up, tracked as its own work item, before merging.
- **`main` isn't protected and a `Status: Done` edit already landed there directly**: that's still acceptable — the ordering in step 3 exists to work correctly *under* branch protection, not to require it — but treat it as a gap in that repository's setup per [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md) rather than the normal path.
- **Release communication is unclear who needs it**: default to over-communicating (note it in the PR and the affected repositories' READMEs) rather than assuming no one depends on it.

## Example

**Input:**
> PR #201, CI green, verification report attached with overall PASS (per `commands/verify.md` example).

**Output (excerpt):**
```text
Pushed final commit to PR #201's branch:
  docs/engineering/backlog/FORM-01-add-server-side-contact-form-validation.md
  Metadata: Status → Done.
Merged PR #201 into main — Status: Done landed atomically with the merge.

No cross-repository impact — contact form validation is internal to
tfrs-website. No README/adoption table update needed.

docs/engineering/backlog/FORM-02-add-contact-form-validation-tests.md
  (previously Blocked by FORM-01) is now unblocked: Blocked → No,
  Status: Backlog → Ready.
```
