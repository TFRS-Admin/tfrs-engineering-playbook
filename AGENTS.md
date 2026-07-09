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
- Do not commit secrets, credentials, tokens, or private keys.
- Do not make unrelated refactors while addressing a focused task.
- Do not ignore existing tests, lint rules, or review feedback without documenting why.

## How Agents Should Use This Playbook

1. Read [`CLAUDE.md`](./CLAUDE.md) for response and execution conventions.
2. Follow [`EXECUTION_STANDARD.md`](./EXECUTION_STANDARD.md) when coding.
3. Check [`REVIEW_STANDARD.md`](./REVIEW_STANDARD.md) before asking for or approving a pull request.
4. Use [`AI_ENGINEERING_WORKFLOW.md`](./AI_ENGINEERING_WORKFLOW.md) to decide what work belongs to humans versus AI.

## Branch Naming

Use one of these prefixes for working branches:

- `feature/`
- `fix/`
- `docs/`
- `chore/`
