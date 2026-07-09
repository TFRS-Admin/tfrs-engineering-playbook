<!-- Purpose: Define the recurring repository health assessment every TFRS repository runs on a fixed cadence. -->
# TFRS Repository Health Standard

## Purpose

Review (see [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md) and [`commands/review.md`](./commands/review.md)) is typically triggered by upcoming work. Repository health is different: it is a **recurring, cadence-driven** assessment that runs whether or not new work is planned, so drift is caught before it blocks a feature. The executable, step-by-step version of this standard is [`commands/repo-health.md`](./commands/repo-health.md).

## Dimensions

Every health check assesses all eight dimensions below. If a dimension cannot be assessed (e.g., no dependency manifest exists), record it as a gap rather than skipping it silently.

| Dimension | What it checks | Cadence |
| --- | --- | --- |
| Architecture drift | Does the implemented structure still match the last recorded architecture doc / ADRs in [`docs/decision-log/`](./docs/decision-log/README.md)? | Quarterly |
| Documentation drift | Do README, playbook adoption notes, and [`templates/repository-architecture-template.md`](./templates/repository-architecture-template.md) still describe current behavior? | Monthly |
| Dependency health | Are dependencies current, and are there known-vulnerable or end-of-life packages? Assess using the dependency-audit triage in [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md#dependency-auditing). | Monthly (weekly if automated scanning is available) |
| Security | Are secrets, auth boundaries, and dependency advisories clean? Assess against [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md) in full. | Weekly automated scan; quarterly manual deep audit |
| Technical debt | Is the open technical-debt backlog ([`templates/technical-debt-template.md`](./templates/technical-debt-template.md) issues) growing faster than it's resolved? | Quarterly |
| Testing | Is coverage of critical paths adequate per the shape in [`TESTING_STANDARD.md`](./TESTING_STANDARD.md#test-coverage-shape), and are there flaky or skipped tests accumulating? | Monthly |
| CI | Is the pipeline green, fast enough to keep in the loop, and free of long-disabled checks? | Monthly |
| GitHub Project hygiene | Are fields complete, is `Blocked` accurate, are stale items being triaged? | Weekly (this cadence is already defined in [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md#issue-triage-cadence) — do not duplicate that triage separately) |

## Recommended Cadence Summary

- **Weekly:** GitHub Project hygiene triage, automated security scan review.
- **Monthly:** Documentation drift, dependency health, testing, CI.
- **Quarterly:** Architecture drift, technical debt trend, full manual security audit.

Align these with the repository's sprint cadence — e.g., run the monthly pass at the start of the first sprint of the month, and the quarterly pass alongside roadmap refresh (see [`commands/roadmap.md`](./commands/roadmap.md)).

## Output

Every health check produces a Repository Health Report. There is no separate report template file for this — it is the same finding format used by [`commands/review.md`](./commands/review.md), scoped to these eight dimensions, dated, and compared against the previous report so trend (improving / flat / degrading) is visible per dimension.

Findings that require action are filed as backlog issues via [`commands/backlog.md`](./commands/backlog.md) — a health report is not complete if its findings only exist as prose. Use [`templates/technical-debt-template.md`](./templates/technical-debt-template.md) for anything that isn't a specific bug or feature.

## Escalation

- A `Critical` or `High` risk security finding is filed and escalated immediately — do not wait for the next scheduled cadence to report it.
- Two consecutive "degrading" trends on the same dimension should be raised at the next roadmap pass, not left to accumulate for a third cycle.

## Related Documents

- [`commands/repo-health.md`](./commands/repo-health.md) — the executable version of this standard
- [`commands/review.md`](./commands/review.md) — the finding format reused here
- [`SECURITY_STANDARD.md`](./SECURITY_STANDARD.md) and [`TESTING_STANDARD.md`](./TESTING_STANDARD.md) — the standards behind the Security, Dependency health, and Testing dimensions
- [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md) — project hygiene cadence and fields
- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) — how findings become tracked work
