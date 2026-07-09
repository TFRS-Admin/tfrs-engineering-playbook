<!-- Purpose: Executable procedure for running a recurring repository health assessment. -->
# Command: Repo Health

## Purpose

Run the recurring, cadence-driven assessment defined in [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md) across all eight health dimensions, and route anything actionable into the backlog. Unlike [`commands/review.md`](./review.md), this command runs on a schedule regardless of planned work, and always covers the same fixed set of dimensions.

## When to Use It

- On the cadence defined in [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md#recommended-cadence-summary) (weekly/monthly/quarterly by dimension).
- Before a [`commands/roadmap.md`](./roadmap.md) pass, so roadmap decisions are informed by current repository state.
- On demand when something feels off but there's no specific issue to point at yet.

## Required Inputs

- The repository being assessed.
- The most recent prior health report, if one exists, for trend comparison.
- Which dimensions are due this cycle (not every cadence tier runs every time — see the cadence table).

## Required Skill Consultation

Check for `skills/tfrs/repo-health` in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) first. As of this writing it does not exist in the fork yet (see [`SKILLS_STANDARD.md#skill-selection`](../SKILLS_STANDARD.md#skill-selection)); until it does, follow this command and [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md) directly. Per dimension, the relevant upstream skill still applies where one exists — e.g. `skills/security-and-hardening` for the Security dimension, `skills/test-driven-development` for the Testing dimension.

## Workflow

1. Identify which dimensions are due this cycle from [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md#dimensions).
2. For each due dimension, assess it using the same evidence discipline as [`commands/review.md`](./review.md) — confirmed vs. suspected findings, each with evidence:
   - **Architecture drift**: compare current structure against `docs/decision-log/` ADRs and any architecture doc.
   - **Documentation drift**: spot-check README and key docs against actual current behavior.
   - **Dependency health**: check for outdated or end-of-life packages using the triage table in [`../SECURITY_STANDARD.md`](../SECURITY_STANDARD.md#dependency-auditing).
   - **Security**: review automated scan results against [`../SECURITY_STANDARD.md`](../SECURITY_STANDARD.md); run a manual pass if this is the quarterly deep audit.
   - **Technical debt**: review the trend of open technical-debt issues (opened vs. closed since last report).
   - **Testing**: check coverage of critical paths against the shape in [`../TESTING_STANDARD.md`](../TESTING_STANDARD.md#test-coverage-shape) and count of skipped/flaky tests.
   - **CI**: confirm pipeline is green, check for long-disabled checks.
   - **Issue metadata hygiene**: this is already covered by the weekly triage in [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md#issue-triage-cadence) — reference that cadence's most recent result rather than re-running it here. Check issue `## Metadata` blocks directly, per [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md); a GitHub Project, if one exists, is checked only as a secondary consistency check against the issue bodies.
3. If a dimension cannot be assessed, record it as a gap with the reason (e.g., "no dependency manifest present").
4. Compare each dimension's result to the previous report: improving / flat / degrading.
5. For every actionable finding, file it via [`commands/backlog.md`](./backlog.md) — do not leave findings as prose only.
6. Escalate immediately (do not wait for the report to be read) any `Critical`/`High` security finding, per [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md#escalation).
7. Publish the report into `docs/engineering/REPO_HEALTH.md` (append, keeping prior reports for trend comparison) and update the "last checked" date per dimension.

## Required Outputs

- A dated Repository Health Report covering every due dimension, with trend vs. the previous report.
- Backlog issues filed for every actionable finding.
- An explicit gap list for anything that couldn't be assessed.

## Quality Gates

- Every due dimension is checked or explicitly marked as a gap — no silent skips.
- Every actionable finding becomes a tracked issue, not just a report line.
- Two consecutive "degrading" trends on the same dimension are flagged for the next roadmap pass per [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md#escalation).

## Failure Handling

- **A dimension has no tooling to assess it** (e.g., no automated dependency scanner configured): record the gap, and file a technical-debt issue to add the missing tooling — the gap itself is a finding.
- **Findings volume is too large to file individually in one pass**: batch by dimension, file the highest-severity items first, and note the remainder as a known backlog-filing follow-up rather than dropping them.

## Example

**Input:**
> `tfrs-website`, monthly cycle due (documentation drift, dependency health, testing, CI), no security/architecture/debt dimensions due this cycle.

**Output (excerpt):**
```text
Documentation drift: Flat. README still accurate.
Dependency health: Degrading. 4 packages now 2+ major versions behind
  (was 1 last cycle). Filed as tech-debt issue #150.
Testing: Flat. Coverage on critical paths unchanged at ~78%.
CI: Improving. Build time down from 6m to 4m after cache change.

Gaps: none this cycle.
Escalation: none — no Critical/High findings.
Filed: issue #150 (dependency health).
```
