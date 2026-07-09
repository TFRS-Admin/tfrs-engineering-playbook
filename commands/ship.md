<!-- Purpose: Executable procedure for merging, releasing, and communicating a verified change. -->
# Command: Ship

## Purpose

Merge a verified change, update GitHub to reflect completion, and communicate downstream impact. Ship is the last step of the per-issue lifecycle; it does not begin until [`commands/verify.md`](./verify.md) has produced a passing report. Ship does **not** assume every merge needs a fresh human approval — it classifies the change per [`PR_AUTONOMY_STANDARD.md`](../PR_AUTONOMY_STANDARD.md) and merges immediately when that standard says so.

## When to Use It

- A PR has green CI and a passing verification report attached, and — for anything `PR_AUTONOMY_STANDARD.md` classifies `Level 2` or `Level 3` — required human approval.
- Never use this command to merge a PR with failing CI or an unresolved blocking review comment — go back to [`commands/execute.md`](./execute.md) instead.

## Required Inputs

- The PR, with its attached verification report (from [`commands/verify.md`](./verify.md)).
- The PR's merge-level classification per [`PR_AUTONOMY_STANDARD.md`](../PR_AUTONOMY_STANDARD.md) (produced in step 1 below if not already known).
- Release/versioning context if the change affects a tagged release or this playbook's own `VERSION.md`.

## Required Skill Consultation

Mandatory per [`SKILLS_STANDARD.md#when-consultation-is-mandatory`](../SKILLS_STANDARD.md#when-consultation-is-mandatory): consult [`skills/shipping-and-launch`](https://github.com/TFRS-Admin/agent-skills/tree/main/skills/shipping-and-launch) in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) for rollout/rollback mechanics; TFRS's merge-gate specifics (merge autonomy, `state_reason`, the `docs/engineering/BACKLOG.md`/`CURRENT_SPRINT.md` update) still govern per [`PR_AUTONOMY_STANDARD.md`](../PR_AUTONOMY_STANDARD.md), [`REVIEW_STANDARD.md`](../REVIEW_STANDARD.md), and [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md).

## Workflow

1. **Classify the merge level** per [`PR_AUTONOMY_STANDARD.md#how-to-classify-a-change`](../PR_AUTONOMY_STANDARD.md#how-to-classify-a-change). This determines whether step 2 needs a human at all.
2. **Confirm the gate for that level:**
   - `Level 1`: confirm every [`PR_AUTONOMY_STANDARD.md#level-1-requirements`](../PR_AUTONOMY_STANDARD.md#level-1-requirements) condition holds (verification passed, single-issue scope, no unresolved review comments, no merge conflicts, required checks green, no branch-protection bypass). No human approval step is inserted.
   - `Level 2` or `Level 3`: confirm required approvals are present per [`REVIEW_STANDARD.md`](../REVIEW_STANDARD.md) and no blocking comments remain unresolved. For `Risk: High` or `Risk: Critical` items, consider the optional parallel fan-out gate described in [`AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md#9-orchestration-between-personas) — independent Reviewer, Verifier, and security passes run concurrently against the same diff and merge findings before this step. This is optional; the default flow is sequential.
3. Confirm CI is green and the verification report is attached and shows an overall Pass — required at every level.
4. **Merge, per the classification:**
   - `Level 1`: merge immediately — no additional wait.
   - `Level 2`: merge only after the explicit human approval from step 2 was actually given in this session.
   - `Level 3`: **do not merge.** Present the verification evidence, risk summary, files changed, and issue-completion confirmation (per [`PR_AUTONOMY_STANDARD.md#session-behavior`](../PR_AUTONOMY_STANDARD.md#session-behavior)) and stop; a human merges this PR directly. Resume at step 5 only once a human confirms the merge has happened.
   - Every merge, regardless of level, still respects branch protections (no `--no-verify`, no force-merging around a failing required check).
5. Close the linked issue with the correct `state_reason` (`completed`).
6. Move the issue's `## Metadata` `Status` to `Done`. Mirror to a GitHub Project only if the repository runs one per [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md).
7. If the change affects a versioned artifact (a release, or this playbook itself), update the changelog (`VERSION.md` for this repository; the repository's own release notes elsewhere) per its versioning rules.
8. Communicate downstream impact: if other repositories or teams depend on the changed behavior, note it in the PR/issue and, for playbook changes, in the README adoption table.
9. Update `docs/engineering/CURRENT_SPRINT.md` to remove the shipped item, and `docs/engineering/BACKLOG.md` to reflect it as `Done`, once the release actually goes out.
10. For a `Level 1` merge only: recommend the next `Ready`, unblocked issue per [`AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-issue`](../AI_AGENT_OPERATING_MODEL.md#3-how-to-choose-the-next-issue) — informational; starting it is still a separate, explicit invocation, not an automatic continuation.

## Required Outputs

- The merge-level classification and why it applied.
- Merged PR (or, for `Level 3`, a clear handoff that a human must merge), closed issue, issue `## Metadata` `Status` = `Done`.
- Updated `docs/engineering/CURRENT_SPRINT.md` and `docs/engineering/BACKLOG.md`.
- Updated changelog/release notes where applicable.
- Downstream communication recorded where the change has cross-repository impact.
- For `Level 1`: the recommended next `Ready` issue.

## Quality Gates

- No merge without green CI and an attached, passing verification report — at every level, no exceptions.
- No `Level 2`/`Level 3` merge without the required human approval from step 2; no `Level 3` merge performed by the agent at all, ever.
- No `Level 1` merge if any [`PR_AUTONOMY_STANDARD.md#level-1-requirements`](../PR_AUTONOMY_STANDARD.md#level-1-requirements) condition fails — treat it as `Level 2` instead rather than forcing it through.
- Issue closed with the correct `state_reason` — never closed silently with no reason.
- Breaking or cross-repository-impacting changes have explicit downstream communication, not just a merged PR.

## Failure Handling

- **CI is red**: do not merge, at any level. Return to [`commands/execute.md`](./execute.md); do not bypass required checks.
- **A late review comment blocks merge**: resolve it or explicitly get sign-off that it's a follow-up, tracked as its own issue, before merging — this also disqualifies an otherwise-`Level 1`-eligible change from autonomous merge for this pass.
- **Merge-level classification is ambiguous**: default to `Level 2` per [`PR_AUTONOMY_STANDARD.md#how-to-classify-a-change`](../PR_AUTONOMY_STANDARD.md#how-to-classify-a-change) — never resolve ambiguity toward `Level 1`.
- **Release communication is unclear who needs it**: default to over-communicating (note it in the PR and the affected repositories' READMEs) rather than assuming no one depends on it.

## Example

**Input (Level 1):**
> PR #201, a `docs`-only change, CI green, verification report attached with overall PASS, no unresolved comments, no conflicts.

**Output (excerpt):**
```text
Merge level: Level 1 (Autonomous) — documentation-only change per
PR_AUTONOMY_STANDARD.md, all Level 1 Requirements satisfied.

Merged PR #201 into main.
Closed issue #143 (state_reason: completed).
Issue #143 Metadata: Status → Done.
docs/engineering/CURRENT_SPRINT.md and BACKLOG.md updated.

No cross-repository impact — contact form validation is internal to
tfrs-website. No README/adoption table update needed.

Issue #144 (integration tests, previously Blocked by #143) is now
unblocked: Blocked → No, Status: Backlog → Ready. Recommended next.
```

**Input (Level 2):**
> PR #205 adds a new permissions check to the admin API. CI green, verification report PASS.

**Output (excerpt):**
```text
Merge level: Level 2 (Approval Required) — permissions change per
PR_AUTONOMY_STANDARD.md.

Presented: verification evidence, risk summary (new permission gate on
/admin/users, no prior authz existed on this route), files changed
(3 files, +64/-8), issue #150 acceptance criteria confirmed met.

Waiting for explicit approval before merging.
```
