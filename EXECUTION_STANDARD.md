<!-- Purpose: Define the expected execution practices for development work across TFRS repositories. -->
# TFRS Execution Standard

## Branch Strategy

Create short-lived branches using the prefixes from [`AGENTS.md`](./AGENTS.md):

- `feature/<scope>`
- `fix/<scope>`
- `docs/<scope>`
- `chore/<scope>`

Merge through pull requests; do not develop directly on `main` except for emergency maintainer-only operations.

## Commit Discipline

Use Conventional Commits and keep each commit reviewable. A good sequence is:

1. Plan or scaffold commit
2. Implementation commit
3. Validation or docs follow-up commit

## PR Size Guidelines

Keep pull requests under **400 lines changed** where practical. If work exceeds that size, split it into stacked or sequential PRs unless the change is tightly coupled and unsafe to separate.

## Definition of Done Checklist

- Acceptance criteria are met.
- Relevant tests or manual validation are complete.
- Documentation and templates are updated when behavior or workflow changes.
- No secrets are introduced.
- The PR description explains scope, files changed, and validation.

## How to Use Copilot During Execution

- Use Copilot for drafting repetitive code, tests, or documentation.
- Review all AI output before committing.
- Prefer AI for acceleration, not for replacing architectural judgment.
- Re-anchor Copilot with repository standards when prompts become broad.

## Handling Blockers

When work is blocked:

1. Document the blocker in the issue or PR.
2. State the decision or input needed from a human.
3. Suggest at least one unblocked next step if available.
4. Set the `Blocked` field to `Yes` on the GitHub Project item immediately (see [`GITHUB_PROJECT_STANDARD.md`](./GITHUB_PROJECT_STANDARD.md)) — a blocker that isn't visible on the board isn't tracked.

## Related Documents

- [`commands/execute.md`](./commands/execute.md) — the executable, step-by-step procedure for this standard
- [`commands/verify.md`](./commands/verify.md) — required before opening a PR for review
- [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) — how an agent decides what to execute next and when to stop
- [`BACKLOG_STANDARD.md`](./BACKLOG_STANDARD.md) — how work arrives here from planning
