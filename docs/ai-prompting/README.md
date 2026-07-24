<!-- Purpose: Provide reusable AI prompt templates for standard TFRS workflows. -->
# TFRS AI Prompt Library

## Planning Prompts

### Plan a Scoped Work Item

**When to use:** before implementation starts.

```text
Create a TFRS-style execution plan for this work item.
Goal: {{goal}}
Constraints: {{constraints}}
Acceptance criteria: {{acceptance_criteria}}
Return a checklist, risks, open questions, and suggested validation steps.
```

## Coding Prompts

### Implement a Minimal Safe Change

**When to use:** when a work item is ready for build.

```text
Implement the smallest safe change for this repository.
Task: {{task}}
Files to inspect first: {{files}}
Standards to follow: AGENTS.md, CLAUDE.md, RULESET.md
Validation to run: {{validation}}
```

## Review Prompts

### Review an AI-Assisted PR

**When to use:** before approval.

```text
Review this AI-assisted pull request.
Focus on functionality, tests, security, scope control, and docs.
PR summary: {{summary}}
Files changed: {{files_changed}}
Return only actionable findings and clearly mark blockers.
```

## Debugging Prompts

### Triage a Failing Workflow or Bug

**When to use:** when tests, builds, or runtime behavior fail.

```text
Investigate this failure in a TFRS repository.
Symptoms: {{symptoms}}
Recent changes: {{recent_changes}}
Logs or errors: {{logs}}
Return likely causes, the next best check, and the smallest safe fix.
```

For the full triage sequence this prompt is a shortcut for, see [`RULESET.md`](../../RULESET.md) rule 7.
