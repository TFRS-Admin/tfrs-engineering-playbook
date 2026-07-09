<!-- Purpose: Production-ready template for tracking technical debt discovered during review, execution, or repository health checks. -->
# Technical Debt Template

Copy this into a new GitHub issue when filing technical debt found during [`commands/review.md`](../commands/review.md), [`commands/repo-health.md`](../commands/repo-health.md), or noticed (but out of scope) during [`commands/execute.md`](../commands/execute.md).

---

## Title

`Tech Debt: 4 dependencies in tfrs-website are 2+ major versions behind`

## Origin

Monthly repository health check, dependency-health dimension (see [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md)), 2026-07-09.

## Current State

`package.json` lists `webpack@4`, `eslint@6`, `react-router@5`, and `node-sass@4` as direct dependencies. All four have current major versions two or more releases ahead, and `node-sass@4` is end-of-life with no further security patches.

## Why This Matters

`node-sass@4` no longer receives security patches, which is a compounding risk the longer it stays in place. The other three block adoption of tooling and APIs used elsewhere in TFRS repositories, increasing onboarding friction for agents and humans moving between repositories.

## Risk of Not Fixing

Medium and growing — no active exploit known today, but the gap between current and latest widens every cycle this stays open, and the eventual upgrade gets more expensive the longer it's deferred.

## Proposed Direction

Replace `node-sass` with `sass` (drop-in compatible for this codebase's usage), then upgrade `webpack`, `eslint`, and `react-router` in separate PRs so any breakage is isolated to one dependency at a time.

## Required Project Fields

| Field | Value |
| --- | --- |
| Status | Backlog |
| Phase | Backlog |
| Priority | P2 |
| Risk | Medium |
| Size | M |
| Sprint | (unassigned until scheduled) |
| Epic | (none — standalone debt item) |
| QA Required | Yes |
| Blocked | No |
| Agent Persona | Implementer |

## Acceptance Criteria

```text
Given the current dependency set
When node-sass is replaced with sass and the build is run
Then the build succeeds with no functional change to compiled output

Given webpack, eslint, and react-router at their current major versions
When each is upgraded in its own PR
Then existing tests and lint pass with no behavior change
```

## Related Documents

[`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md) · [`commands/repo-health.md`](../commands/repo-health.md) · [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md)
