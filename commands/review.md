<!-- Purpose: Executable procedure for assessing current state and producing findings before planning begins. -->
# Command: Review

## Purpose

Produce a factual, evidence-backed account of the current state of a system, feature area, or bug — without fixing anything. Review is the first phase of the lifecycle:

```text
Review → Roadmap/Plan → Backlog → Execute → Verify → Ship
```

This is distinct from PR review (see [`REVIEW_STANDARD.md`](../REVIEW_STANDARD.md), which is the approval bar for merging a specific diff — see the terminology map in [`AI_ENGINEERING_WORKFLOW.md`](../AI_ENGINEERING_WORKFLOW.md#terminology-map) for why both are called "Review"). This command reviews *existing state*, not a proposed change.

## When to Use It

- Before starting work in an unfamiliar area of a repository.
- Before a major feature or epic, to establish a baseline.
- When investigating a bug, to separate symptom from root cause before proposing a fix.
- As the discovery step of [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md).
- As the first step of [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md) when onboarding an existing repository.

## Required Inputs

- **Scope**: the repository, directory, feature, or symptom to review. State it explicitly — "review the whole repo" is not a scope.
- **Why now**: what triggered this review (planned feature, incident, scheduled health check).
- **Related artifacts**: linked issues, prior ADRs ([`docs/decision-log/`](../docs/decision-log/README.md)), prior review findings for the same area.
- **Known constraints**: anything already decided that the review should not re-litigate.

## Required Skill Consultation

Not mandatory per [`SKILLS_STANDARD.md#when-consultation-is-mandatory`](../SKILLS_STANDARD.md#when-consultation-is-mandatory) — this command produces findings, not a skill-shaped deliverable. If the review scope is a specific quality dimension (security, performance), optionally skim the matching skill in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) (e.g. `skills/security-and-hardening`) for what to look for, but do not follow its full workflow here — that happens later, in `commands/plan.md` or `commands/execute.md`.

## Workflow

1. Read [`AGENTS.md`](../AGENTS.md), [`CLAUDE.md`](../CLAUDE.md), and any repository-specific architecture doc first.
2. Check [`docs/decision-log/`](../docs/decision-log/README.md) for ADRs covering the scope, so findings don't contradict a recorded decision without flagging it explicitly.
3. Explore the scoped code (search by symbol, by directory, by behavior — use whatever breadth the scope requires; for a scope larger than a few files, fan out multiple independent searches rather than one linear pass).
4. For each observation, capture: what you found, where (file:line or reproduction steps), why it matters, and severity.
5. Distinguish **confirmed** findings (you traced the code path or reproduced the behavior) from **suspected** findings (plausible but unverified) — never present a suspicion as a fact.
6. Do not write or propose a fix in this pass — this is Chesterton's Fence in practice: understand why something is the way it is before deciding whether to change it (see [`REVIEW_STANDARD.md`](../REVIEW_STANDARD.md#complexity--simplification)). If a fix is obvious, note it as a "likely direction" but leave the actual solution design to [`commands/plan.md`](./plan.md).
7. Rank findings by severity, then write the findings document.

## Required Outputs

- A findings document (severity-ranked list; each finding has evidence and a likely direction, not a full fix).
- An explicit list of open questions that need a human decision before planning.
- A recommendation: does this go straight to [`commands/plan.md`](./plan.md), or is it a small enough finding to go directly into [`commands/backlog.md`](./backlog.md) as a task?

## Quality Gates

- Every finding has evidence (file/line, log excerpt, or reproduction steps) — no finding is admitted on assertion alone.
- Findings are ranked by severity, not by order discovered.
- No implementation changes are included in this pass.
- Scope actually reviewed matches the stated scope — if you had to narrow scope mid-review, say so rather than silently under-covering it.

## Failure Handling

- **Scope too large to cover in one pass**: split into multiple review passes by subsystem and say so explicitly; do not silently sample and call it complete.
- **Insufficient evidence for a finding**: mark it "needs verification," do not promote it to "confirmed."
- **Review surfaces something urgent** (security, data loss risk): escalate immediately rather than holding it for the findings document to be read later.

## Example

**Input:**
> Scope: `tfrs-website` contact form submission path. Why now: planning a backlog item to add server-side validation. Related: none yet.

**Output (excerpt):**
```text
Finding 1 [Confirmed, High]: Contact form validation is client-side only
  (src/components/ContactForm.jsx:42-58). Direct POST to the submission
  endpoint bypasses all required-field and format checks.
  Likely direction: add matching server-side validation at the endpoint boundary.

Finding 2 [Suspected, Low]: Form submission has no rate limiting; not
  confirmed against production config.

Open questions:
  - Is there an existing shared validation schema this should reuse, or is
    one being introduced?

Recommendation: Finding 1 is well-scoped enough to go directly to
commands/plan.md; Finding 2 needs a look at production config before it can
be planned.
```
