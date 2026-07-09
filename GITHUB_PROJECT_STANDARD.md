<!-- Purpose: Standardize GitHub Project setup and operating rules for TFRS repositories. -->
# TFRS GitHub Project Standard

## Standard Columns

Every TFRS project board should include these status columns:

1. **Backlog**
2. **Ready**
3. **In Progress**
4. **In Review**
5. **Done**

## Required Custom Fields

### Priority

Use one of:

- `P0`
- `P1`
- `P2`
- `P3`

### Type

Use one of:

- `Feature`
- `Bug`
- `Chore`
- `Docs`

### Sprint

Use a sprint label or date range that matches how the team plans work.

## Automation Rules to Configure

- New issues land in **Backlog** by default.
- Issues with an approved owner and acceptance criteria move to **Ready**.
- Opening a linked pull request moves the item to **In Progress** or **In Review**.
- Merging the PR moves the item to **Done**.
- Closed issues without merged work should be reviewed before automation marks them complete.

## How to Link Repositories to a Project

1. Add the repository to the GitHub Project settings.
2. Confirm issues and pull requests from that repository can be added automatically.
3. Align labels and field names so automation rules stay predictable.
4. Reference the project in the repository README or contributor docs.

## Issue Triage Cadence

Run issue triage at least once per week:

- Re-prioritize backlog items
- Close stale or superseded work
- Move ready items into the next sprint or work queue
- Confirm each in-progress item still has an owner and next step
