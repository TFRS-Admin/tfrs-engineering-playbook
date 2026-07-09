<!-- Purpose: Define baseline instructions for AI coding agents operating in TFRS repositories. -->
# TFRS Agent Operating Standard

## Agent Identity & Scope

AI coding agents operating in TFRS repositories are authorized to plan, implement, test, document, and review changes that are explicitly requested in issues, pull requests, or maintainer instructions. Agents should optimize for small, safe changes that preserve repository intent and should treat this playbook as the default operating contract unless a repository documents a stricter local rule.

## File Naming Conventions

- Prefer **JavaScript-first** repository layouts and documentation examples.
- Use **kebab-case** for general files and folders such as `order-service.js` or `project-board-template.md`.
- Use **PascalCase** for React components, pages, and other framework conventions that expect component naming.
- Keep filenames descriptive enough that Copilot and Claude can infer intent from path and name alone.

## Code Style Rules

- Prefer **ES modules** over CommonJS in new code.
- Prefer **async/await** over chained `.then()` calls except when a library API makes promises awkward.
- Never introduce `var`; use `const` by default and `let` only when reassignment is required.
- Keep functions focused, name side effects clearly, and default to early returns for guard clauses.
- Reuse repository-standard tooling and patterns before introducing new dependencies.

## Commit Message Format

Use Conventional Commits for every agent-authored commit:

- `feat: add new behavior`
- `fix: correct broken behavior`
- `docs: update standards or usage guidance`
- `chore: maintain tooling or repo structure`

## What Agents Must Not Do

- Do not force push or rewrite shared history unless a human maintainer explicitly owns that operation.
- Do not delete the `.github/` directory or weaken repository protections.
- Do not commit secrets, credentials, tokens, or private keys — see [`SECURITY_STANDARD.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/SECURITY_STANDARD.md) for what to do if one ever is committed anyway.
- Do not make unrelated refactors while addressing a focused task.
- Do not ignore existing tests, lint rules, or review feedback without documenting why.
- Do not merge a pull request classified `Level 2` or `Level 3` under [`PR_AUTONOMY_STANDARD.md`](./PR_AUTONOMY_STANDARD.md) without the specific human approval that standard requires — and never merge a `Level 3` change at all, even after approval; a human merges those directly.

## How Agents Should Use This Playbook

0. **Start every session with the [Session Initialization Protocol](./AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol)** — this applies even to a plain-language request with no issue number attached; route it with [`DECISION_ROUTER.md`](./DECISION_ROUTER.md) rather than guessing which command applies.
1. Read [`CLAUDE.md`](./CLAUDE.md) for response and execution conventions.
2. Read [`AI_AGENT_OPERATING_MODEL.md`](./AI_AGENT_OPERATING_MODEL.md) for the full operating loop: what to read first, how to pick the next issue, when to stop, and how to update GitHub. This document defines behavior and conventions; that one defines the loop those conventions run inside.
3. Follow [`EXECUTION_STANDARD.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/EXECUTION_STANDARD.md) when coding, and the executable command library under [`commands/`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/commands/README.md) for every phase of the lifecycle.
4. Check [`REVIEW_STANDARD.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/REVIEW_STANDARD.md) before asking for or approving a pull request, and [`SECURITY_STANDARD.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/SECURITY_STANDARD.md) / [`TESTING_STANDARD.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/TESTING_STANDARD.md) whenever a change touches external input, auth, or behavior that needs test coverage.
5. Once verification passes, classify the change per [`PR_AUTONOMY_STANDARD.md`](./PR_AUTONOMY_STANDARD.md) before merging anything — `Level 1` merges automatically, `Level 2` waits for explicit approval, `Level 3` is never merged by the agent at all.
6. Use [`AI_ENGINEERING_WORKFLOW.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/AI_ENGINEERING_WORKFLOW.md) to decide what work belongs to humans versus AI.
7. Consult [`SKILLS_STANDARD.md`](https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/SKILLS_STANDARD.md) for the step-by-step execution mechanics of a given task type (code review, planning, implementation, verification, and so on) — this playbook defines *what's required*, [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) defines *how to execute it*; don't re-derive a skill's workflow from scratch when one already exists.

## Branch Naming

Use one of these prefixes for working branches:

- `feature/`
- `fix/`
- `docs/`
- `chore/`
