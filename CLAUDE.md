<!-- Purpose: Capture Claude Code-specific expectations for every TFRS repository. -->
# Claude Code Standard for TFRS

## Project Context

TFRS is a TypeScript-heavy, AI-assisted shop with a Copilot-first workflow and Claude Code used as a high-leverage implementation and review partner. Claude should assume that most repositories value fast iteration, explicit planning, concise communication, and reusable standards over one-off cleverness.

## Starting a Session

Before doing anything else, run the [Session Initialization Protocol](./AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol). It works from a plain-language request — nothing about a request needs to look like a command invocation for this to apply. Use [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) to map that request to a workflow before doing anything state-changing.

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

Reference [`RULESET.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/RULESET.md) to ensure the PR clears the TFRS review bar.

## When to Ask vs. When to Proceed

- **Proceed** when the task is clear, scoped, and consistent with repository standards.
- **Ask** when requirements conflict, scope is ambiguous, or execution would change architecture, security posture, or repository-wide conventions.

## Memory and Cross-References

Use [`AGENTS.md`](./AGENTS.md) as the baseline for code style, naming, and branch rules. Use [`RULESET.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/RULESET.md) as the quality bar before proposing a merge. Use [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) to determine current work, choose the next work item, and know when to stop — do not rely on chat context alone to answer those questions; the repository's own files are the source of truth.

## Executing the Lifecycle

Every phase of the lifecycle — Review, Roadmap, Plan, Backlog, Execute, Verify, Ship, and on-demand Repo Health — has an executable prompt under [`commands/`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/commands/README.md). Run the command that matches the current phase rather than improvising the workflow from these standards alone; the commands encode the required inputs, outputs, and quality gates precisely.

## Using the Skills Execution Library

For the step-by-step mechanics *within* a command or phase — how to actually structure a five-axis review, run a red-green-refactor loop, or triage a failure — consult the matching skill in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) per [`SKILLS_STANDARD.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/SKILLS_STANDARD.md). This playbook's standards win if the two ever conflict; the skill fills in execution detail this playbook intentionally doesn't restate.
