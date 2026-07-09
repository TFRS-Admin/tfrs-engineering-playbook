<!-- Purpose: Seed docs/engineering/REPO_HEALTH.md — the running Repository Health Report history every adopted repository maintains directly. -->
# Engineering Repo Health Template

Copy this to `docs/engineering/REPO_HEALTH.md` at the repository root. [`commands/repo-health.md`](../commands/repo-health.md) appends a new dated report to this file every cycle — see [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md) for the eight dimensions and cadence.

---

# Repository Health: tfrs-website

## Recorded Cadence

- Weekly: issue metadata hygiene, automated security scan review.
- Monthly: documentation drift, dependency health, testing, CI.
- Quarterly: architecture drift, technical debt trend, full manual security audit.
- Status as of this writing: **not yet started** — first pass scheduled for the next sprint boundary.

## Report History

### 2026-07-09 (Example — Monthly)

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

## Related Documents

[`commands/repo-health.md`](../commands/repo-health.md) · [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md) · [`SECURITY_STANDARD.md`](../SECURITY_STANDARD.md)
