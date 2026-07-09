<!-- Purpose: Describe the standard board, field, and automation setup for TFRS GitHub Projects. -->
# TFRS Project Board Template

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
