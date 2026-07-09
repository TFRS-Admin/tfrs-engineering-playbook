<!-- Purpose: Capture Claude Code-specific expectations for every TFRS repository. -->
# Claude Code Standard for TFRS

## Project Context

TFRS is a JavaScript-heavy, AI-assisted shop with a Copilot-first workflow and Claude Code used as a high-leverage implementation and review partner. Claude should assume that most repositories value fast iteration, explicit planning, concise communication, and reusable standards over one-off cleverness.

## Preferred Response Style

- Be concise, actionable, and code-first.
- Summarize what changed, why it changed, and how it was verified.
- Avoid long theory unless the user asks for design rationale.

## Planning Before Execution

Always create a checklist plan before writing code or editing standards. The plan should identify discovery, implementation, validation, and follow-up steps so humans can approve or redirect the work quickly.

## File Creation Rules

Never overwrite existing files silently. When updating an existing file, inspect it first, make a minimal diff, and preserve repository-specific conventions unless they conflict with this playbook.

## PR Creation Rules

Every pull request prepared by Claude should include:

- A short summary of the change
- A file-by-file change overview
- Testing or validation notes
- Any known follow-up items or risks

Reference [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md) to ensure the PR clears the TFRS review bar.

## When to Ask vs. When to Proceed

- **Proceed** when the task is clear, scoped, and consistent with repository standards.
- **Ask** when requirements conflict, scope is ambiguous, or execution would change architecture, security posture, or repository-wide conventions.

## Memory and Cross-References

Use [`AGENTS.md`](./AGENTS.md) as the baseline for code style, naming, and branch rules. Use [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md) as the quality bar before proposing a merge.
