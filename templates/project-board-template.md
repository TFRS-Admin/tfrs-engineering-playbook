<!-- Purpose: Describe the standard board, field, and automation setup for the optional TFRS GitHub Project dashboard. -->
# TFRS Project Board Template (Optional)

This template is for a repository whose humans want a visual GitHub Project dashboard. It is **never required** — see [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md). The repository's `docs/engineering/` files and each issue's `## Metadata` block (per [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md)) remain authoritative regardless of whether this board exists; a Project built from this template should mirror those, not replace them.

## Column Setup

Create these columns or single-select status values:

1. Backlog
2. Ready
3. In Progress
4. In Review
5. Done

## Field Setup

Create these custom fields:

- **Priority:** P0, P1, P2, P3
- **Type:** Feature, Bug, Chore, Docs
- **Sprint:** current sprint name, date range, or milestone marker

## Automation Setup

- Auto-add new issues to the board.
- Default new issues to Backlog.
- Move items to In Progress when a linked branch or PR is active.
- Move items to In Review when the PR is marked ready.
- Move items to Done when the PR merges.
