#!/usr/bin/env bash
# setup-project-board.sh
#
# DEPRECATED as of v3.0.0 (2026-07-09): this script was written against the
# pre-3.0.0 GitHub-Project-centered model — it provisions a 10-field GitHub
# Project as required infrastructure and writes issue bodies using the old
# "Pending"/"Active" adoption vocabulary. Since v3.0.0 the playbook is
# repository-centered: a GitHub Project is optional visualization only (see
# GITHUB_PROJECT_STANDARD.md), issue bodies carry the `## Metadata` block
# defined in ISSUE_METADATA_STANDARD.md instead of Project custom fields, and
# adoption status uses the three-state model in
# REPOSITORY_BOOTSTRAP_GUIDE.md#adoption-states. Do not run this script
# as-is; it will recreate a superseded model. Kept for historical reference.
#
# Original description:
# Creates the TFRS Engineering Playbook GitHub Project board, custom fields,
# all 12 initial issues, assigns field values, and links sub-issues.
#
# Usage:
#   gh auth login          # authenticate first if not already
#   bash scripts/setup-project-board.sh
#
# Requirements: gh CLI v2.x, jq

set -euo pipefail

OWNER="TFRS-Admin"
REPO="tfrs-engineering-playbook"
PROJECT_TITLE="TFRS Engineering Playbook"
PROJECT_DESC="Tracks development and improvement of the TFRS canonical engineering playbook"

echo "=== TFRS Engineering Playbook — Project Board Setup ==="
echo ""

# ──────────────────────────────────────────────
# 1. Create the project
# ──────────────────────────────────────────────
echo "▶ Creating project: $PROJECT_TITLE"
PROJECT_URL=$(gh project create \
  --owner "$OWNER" \
  --title "$PROJECT_TITLE" \
  --format json | jq -r '.url')

PROJECT_NUMBER=$(echo "$PROJECT_URL" | grep -oE '[0-9]+$')
echo "  Project #$PROJECT_NUMBER created: $PROJECT_URL"

# ──────────────────────────────────────────────
# 2. Create custom fields
# ──────────────────────────────────────────────
echo ""
echo "▶ Creating custom fields..."

create_single_select() {
  local field_name="$1"
  shift
  local options=("$@")
  local opts_args=()
  for opt in "${options[@]}"; do
    opts_args+=(--single-select-option "$opt")
  done
  gh project field-create "$PROJECT_NUMBER" \
    --owner "$OWNER" \
    --name "$field_name" \
    --data-type SINGLE_SELECT \
    "${opts_args[@]}" \
    --format json | jq -r '.id'
}

create_text() {
  local field_name="$1"
  gh project field-create "$PROJECT_NUMBER" \
    --owner "$OWNER" \
    --name "$field_name" \
    --data-type TEXT \
    --format json | jq -r '.id'
}

echo "  Creating Status field..."
STATUS_FIELD_ID=$(create_single_select "Status" "Backlog" "Ready" "In Progress" "In Review" "QA" "Done")

echo "  Creating Phase field..."
PHASE_FIELD_ID=$(create_single_select "Phase" "Review" "Roadmap" "Plan" "Backlog" "Execute" "Verify" "Ship")

echo "  Creating Priority field..."
PRIORITY_FIELD_ID=$(create_single_select "Priority" "P0" "P1" "P2" "P3")

echo "  Creating Risk field..."
RISK_FIELD_ID=$(create_single_select "Risk" "Low" "Medium" "High" "Critical")

echo "  Creating Size field..."
SIZE_FIELD_ID=$(create_single_select "Size" "S" "M" "L" "XL")

echo "  Creating Sprint field..."
SPRINT_FIELD_ID=$(create_text "Sprint")

echo "  Creating Epic field..."
EPIC_FIELD_ID=$(create_text "Epic")

echo "  Creating QA Required field..."
QA_REQUIRED_FIELD_ID=$(create_single_select "QA Required" "Yes" "No")

echo "  Creating Blocked field..."
BLOCKED_FIELD_ID=$(create_single_select "Blocked" "Yes" "No")

echo "  Creating Agent Persona field..."
AGENT_PERSONA_FIELD_ID=$(create_single_select "Agent Persona" \
  "Reviewer" "Planner" "Backlog-Manager" "Implementer" "Verifier" \
  "Release-Manager" "Repo-Health-Auditor")

echo "  ✓ All 10 fields created"

# ──────────────────────────────────────────────
# 3. Link repository to project
# ──────────────────────────────────────────────
echo ""
echo "▶ Linking repository $OWNER/$REPO to project..."
# ProjectV2 repository linking via GraphQL
REPO_ID=$(gh api "repos/$OWNER/$REPO" --jq '.node_id')
PROJECT_ID=$(gh project list --owner "$OWNER" --format json | \
  jq -r --arg num "$PROJECT_NUMBER" '.projects[] | select(.number == ($num | tonumber)) | .id')

gh api graphql -f query="
  mutation {
    linkProjectV2ToRepository(input: {projectId: \"$PROJECT_ID\", repositoryId: \"$REPO_ID\"}) {
      repository { name }
    }
  }
" > /dev/null

echo "  ✓ Repository linked"

# ──────────────────────────────────────────────
# Helper: add issue to project and set fields
# ──────────────────────────────────────────────
add_to_project_and_set_fields() {
  local issue_number="$1"
  local status="$2"
  local phase="$3"
  local priority="$4"
  local risk="$5"
  local size="$6"
  local qa_required="$7"
  local blocked="$8"
  local agent_persona="$9"

  # Get issue node ID
  local issue_node_id
  issue_node_id=$(gh api "repos/$OWNER/$REPO/issues/$issue_number" --jq '.node_id')

  # Add issue to project, get item ID
  local item_id
  item_id=$(gh project item-add "$PROJECT_NUMBER" \
    --owner "$OWNER" \
    --url "https://github.com/$OWNER/$REPO/issues/$issue_number" \
    --format json | jq -r '.id')

  # Set each field
  gh project item-edit \
    --project-id "$PROJECT_ID" \
    --id "$item_id" \
    --field-id "$STATUS_FIELD_ID" \
    --single-select-option-id "$(get_option_id "$STATUS_FIELD_ID" "$status")" > /dev/null

  gh project item-edit \
    --project-id "$PROJECT_ID" \
    --id "$item_id" \
    --field-id "$PHASE_FIELD_ID" \
    --single-select-option-id "$(get_option_id "$PHASE_FIELD_ID" "$phase")" > /dev/null

  gh project item-edit \
    --project-id "$PROJECT_ID" \
    --id "$item_id" \
    --field-id "$PRIORITY_FIELD_ID" \
    --single-select-option-id "$(get_option_id "$PRIORITY_FIELD_ID" "$priority")" > /dev/null

  gh project item-edit \
    --project-id "$PROJECT_ID" \
    --id "$item_id" \
    --field-id "$RISK_FIELD_ID" \
    --single-select-option-id "$(get_option_id "$RISK_FIELD_ID" "$risk")" > /dev/null

  gh project item-edit \
    --project-id "$PROJECT_ID" \
    --id "$item_id" \
    --field-id "$SIZE_FIELD_ID" \
    --single-select-option-id "$(get_option_id "$SIZE_FIELD_ID" "$size")" > /dev/null

  gh project item-edit \
    --project-id "$PROJECT_ID" \
    --id "$item_id" \
    --field-id "$QA_REQUIRED_FIELD_ID" \
    --single-select-option-id "$(get_option_id "$QA_REQUIRED_FIELD_ID" "$qa_required")" > /dev/null

  gh project item-edit \
    --project-id "$PROJECT_ID" \
    --id "$item_id" \
    --field-id "$BLOCKED_FIELD_ID" \
    --single-select-option-id "$(get_option_id "$BLOCKED_FIELD_ID" "$blocked")" > /dev/null

  gh project item-edit \
    --project-id "$PROJECT_ID" \
    --id "$item_id" \
    --field-id "$AGENT_PERSONA_FIELD_ID" \
    --single-select-option-id "$(get_option_id "$AGENT_PERSONA_FIELD_ID" "$agent_persona")" > /dev/null
}

# Helper: look up a single-select option ID by name
get_option_id() {
  local field_id="$1"
  local option_name="$2"
  gh api graphql -f query="
    query {
      node(id: \"$field_id\") {
        ... on ProjectV2SingleSelectField {
          options { id name }
        }
      }
    }
  " | jq -r --arg name "$option_name" '.data.node.options[] | select(.name == $name) | .id'
}

# Helper: link sub-issue to parent
link_sub_issue() {
  local parent_number="$1"
  local child_number="$2"
  local parent_node_id
  parent_node_id=$(gh api "repos/$OWNER/$REPO/issues/$parent_number" --jq '.node_id')
  local child_node_id
  child_node_id=$(gh api "repos/$OWNER/$REPO/issues/$child_number" --jq '.node_id')
  gh api graphql -f query="
    mutation {
      addSubIssue(input: {issueId: \"$parent_node_id\", subIssueId: \"$child_node_id\"}) {
        issue { number }
      }
    }
  " > /dev/null
  echo "  Linked #$child_number as sub-issue of #$parent_number"
}

# ──────────────────────────────────────────────
# 4. Create issues
# ──────────────────────────────────────────────
echo ""
echo "▶ Creating issues..."

# Issue 1 — Epic: Retrofit
echo "  Creating Issue 1: Epic: Retrofit all 5 existing TFRS repositories..."
ISSUE_1=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Epic: Retrofit all 5 existing TFRS repositories to adopt the playbook" \
  --body "## Origin
Playbook v2.0.0 launch. All 5 existing TFRS repositories are currently listed as \"Pending\" adoption in README.md.

## Outcome
Every active TFRS repository has AGENTS.md, CLAUDE.md, AI_AGENT_OPERATING_MODEL.md copied in, a GitHub Project configured with all 10 required fields, and the playbook version recorded in its README.

## Scope
- Code-Gen-AI
- prompt-showcase-by-team44-copy
- QPM_Base44
- Digital-Catalogue
- CPQ-Master-Inventory

## Child Issues
- [ ] Adopt playbook in Code-Gen-AI
- [ ] Adopt playbook in prompt-showcase-by-team44-copy
- [ ] Adopt playbook in QPM_Base44
- [ ] Adopt playbook in Digital-Catalogue
- [ ] Adopt playbook in CPQ-Master-Inventory

## Definition of Done
All 5 repositories have adopted the playbook, their READMEs reference tfrs-engineering-playbook v2.0.0, and the adoption table in this repo's README.md shows \"Active\" for all 5." \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_1 created"

# Issue 2 — Code-Gen-AI
echo "  Creating Issue 2: Adopt TFRS playbook in Code-Gen-AI..."
ISSUE_2=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Adopt TFRS playbook in Code-Gen-AI" \
  --body "## Origin
Child of Epic: Retrofit all 5 existing TFRS repositories to adopt the playbook.

## Acceptance Criteria
Given the Code-Gen-AI repository
When the playbook adoption is complete
Then:
- AGENTS.md, CLAUDE.md, AI_AGENT_OPERATING_MODEL.md are present at repo root
- .github/ISSUE_TEMPLATE/ and PULL_REQUEST_TEMPLATE.md are present
- README.md references tfrs-engineering-playbook v2.0.0
- A GitHub Project exists with all 10 required fields and 8 board views
- The adoption table in tfrs-engineering-playbook README.md is updated to \"Active\"

## Implementation Notes
Follow REPOSITORY_BOOTSTRAP_GUIDE.md steps 2-3 (Copy Playbook + Create GitHub Project). Run commands/review.md against the repo before planning new work.

## Verification
Manual checklist walkthrough against templates/new-repo-checklist.md." \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_2 created"

# Issue 3 — prompt-showcase
echo "  Creating Issue 3: Adopt TFRS playbook in prompt-showcase-by-team44-copy..."
ISSUE_3=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Adopt TFRS playbook in prompt-showcase-by-team44-copy" \
  --body "## Origin
Child of Epic: Retrofit all 5 existing TFRS repositories to adopt the playbook.

## Acceptance Criteria
Given the prompt-showcase-by-team44-copy repository
When the playbook adoption is complete
Then:
- AGENTS.md, CLAUDE.md, AI_AGENT_OPERATING_MODEL.md are present at repo root
- .github/ISSUE_TEMPLATE/ and PULL_REQUEST_TEMPLATE.md are present
- README.md references tfrs-engineering-playbook v2.0.0
- A GitHub Project exists with all 10 required fields and 8 board views
- The adoption table in tfrs-engineering-playbook README.md is updated to \"Active\"

## Verification
Manual checklist walkthrough against templates/new-repo-checklist.md." \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_3 created"

# Issue 4 — QPM_Base44
echo "  Creating Issue 4: Adopt TFRS playbook in QPM_Base44..."
ISSUE_4=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Adopt TFRS playbook in QPM_Base44" \
  --body "## Origin
Child of Epic: Retrofit all 5 existing TFRS repositories to adopt the playbook.

## Acceptance Criteria
Given the QPM_Base44 repository
When the playbook adoption is complete
Then:
- AGENTS.md, CLAUDE.md, AI_AGENT_OPERATING_MODEL.md are present at repo root
- .github/ISSUE_TEMPLATE/ and PULL_REQUEST_TEMPLATE.md are present
- README.md references tfrs-engineering-playbook v2.0.0
- A GitHub Project exists with all 10 required fields and 8 board views
- The adoption table in tfrs-engineering-playbook README.md is updated to \"Active\"

## Verification
Manual checklist walkthrough against templates/new-repo-checklist.md." \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_4 created"

# Issue 5 — Digital-Catalogue
echo "  Creating Issue 5: Adopt TFRS playbook in Digital-Catalogue..."
ISSUE_5=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Adopt TFRS playbook in Digital-Catalogue" \
  --body "## Origin
Child of Epic: Retrofit all 5 existing TFRS repositories to adopt the playbook.

## Acceptance Criteria
Given the Digital-Catalogue repository
When the playbook adoption is complete
Then:
- AGENTS.md, CLAUDE.md, AI_AGENT_OPERATING_MODEL.md are present at repo root
- .github/ISSUE_TEMPLATE/ and PULL_REQUEST_TEMPLATE.md are present
- README.md references tfrs-engineering-playbook v2.0.0
- A GitHub Project exists with all 10 required fields and 8 board views
- The adoption table in tfrs-engineering-playbook README.md is updated to \"Active\"

## Verification
Manual checklist walkthrough against templates/new-repo-checklist.md." \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_5 created"

# Issue 6 — CPQ-Master-Inventory
echo "  Creating Issue 6: Adopt TFRS playbook in CPQ-Master-Inventory..."
ISSUE_6=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Adopt TFRS playbook in CPQ-Master-Inventory" \
  --body "## Origin
Child of Epic: Retrofit all 5 existing TFRS repositories to adopt the playbook.

## Acceptance Criteria
Given the CPQ-Master-Inventory repository
When the playbook adoption is complete
Then:
- AGENTS.md, CLAUDE.md, AI_AGENT_OPERATING_MODEL.md are present at repo root
- .github/ISSUE_TEMPLATE/ and PULL_REQUEST_TEMPLATE.md are present
- README.md references tfrs-engineering-playbook v2.0.0
- A GitHub Project exists with all 10 required fields and 8 board views
- The adoption table in tfrs-engineering-playbook README.md is updated to \"Active\"

## Verification
Manual checklist walkthrough against templates/new-repo-checklist.md." \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_6 created"

# Issue 7 — Epic: Repo Health
echo "  Creating Issue 7: Epic: Run first repo-health pass..."
ISSUE_7=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Epic: Run first repo-health pass on all adopted repositories" \
  --body "## Origin
REPO_HEALTH_STANDARD.md defines a recurring health cadence. This Epic captures the first pass across all repositories once adoption is complete.

## Outcome
Every adopted repository has a dated Repository Health Report covering all 8 dimensions. Actionable findings are filed as backlog issues.

## Blocked by
Adoption Epic (all 5 repos must be adopted first)

## Definition of Done
Health reports exist for all adopted repos. All actionable findings are tracked as issues." \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_7 created"

# Issue 8 — Branch protection
echo "  Creating Issue 8: Add branch protection rules..."
ISSUE_8=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Add branch protection rules to tfrs-engineering-playbook main branch" \
  --body "## Origin
templates/new-repo-checklist.md step: protect main with required pull requests and status checks.

## Acceptance Criteria
Given the tfrs-engineering-playbook repository
When branch protection is configured on main
Then:
- Direct pushes to main are blocked
- PRs require at least 1 approval before merge
- The validate-playbook.yml workflow is a required status check

## Priority
P1 — the playbook validate-playbook.yml workflow is already in place but not enforced." \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_8 created"

# Issue 9 — Repository topics
echo "  Creating Issue 9: Add repository topics..."
ISSUE_9=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Add repository topics and update description for tfrs-engineering-playbook" \
  --body "## Origin
templates/new-repo-checklist.md — repositories should have topics matching the product domain.

## Acceptance Criteria
Given the tfrs-engineering-playbook repository settings
When topics are added
Then the repository has topics: engineering, playbook, ai-assisted-development, javascript, standards, github-copilot, claude

## Implementation
Settings → General → Topics. Also confirm description reads: \"TFRS canonical engineering standards, AI workflow guidelines, and project templates\"" \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_9 created"

# Issue 10 — ADR-001
echo "  Creating Issue 10: Write ADR-001..."
ISSUE_10=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Write ADR-001: Adopt tfrs-engineering-playbook as canonical TFRS standard" \
  --body "## Origin
docs/decision-log/README.md references ADR-001 as the first entry but it has not been written yet.

## Acceptance Criteria
Given docs/decision-log/ADR-001-adopt-playbook.md does not exist
When the ADR is written using templates/adr-template.md
Then:
- The file exists at docs/decision-log/ADR-001-adopt-playbook.md
- Status is Accepted
- Context, Decision, and Consequences sections are complete
- The ADR index in docs/decision-log/README.md is updated with the entry

## Implementation Notes
Use templates/adr-template.md as the starting template." \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_10 created"

# Issue 11 — Quarterly roadmap
echo "  Creating Issue 11: First quarterly roadmap pass..."
ISSUE_11=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Run first quarterly roadmap pass for tfrs-engineering-playbook" \
  --body "## Origin
commands/roadmap.md — roadmap should run quarterly.

## Acceptance Criteria
Given the current backlog of issues
When commands/roadmap.md is run for Q3 2026
Then:
- A sequenced roadmap document exists for Q3
- Epics are prioritized and sized
- The roadmap is recorded in the Roadmap board view

## Timing
Run after the adoption Epic is in progress so findings from the first wave of repo retrofits can inform the roadmap." \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_11 created"

# Issue 12 — Communication standard
echo "  Creating Issue 12: Document team communication standards..."
ISSUE_12=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "Playbook improvement: document team communication standards" \
  --body "## Origin
Opened via .github/ISSUE_TEMPLATE/playbook_improvement.md convention.

## Which file should change
A new COMMUNICATION_STANDARD.md or a section in EXECUTION_STANDARD.md.

## What change
Document where async team communication happens (chat, issues, PRs) and when to use each channel. Currently the playbook is silent on this.

## Why
AI agents need to know where to post status updates, blockers, and decisions when a human is not actively present in a session.

## Priority
P3 — important but not blocking any current work." \
  --format json | jq -r '.number')
echo "  ✓ Issue #$ISSUE_12 created"

echo ""
echo "▶ All 12 issues created. Issue numbers:"
echo "  Epic 1 (Retrofit):       #$ISSUE_1"
echo "  Issue 2 (Code-Gen-AI):   #$ISSUE_2"
echo "  Issue 3 (prompt-show):   #$ISSUE_3"
echo "  Issue 4 (QPM_Base44):    #$ISSUE_4"
echo "  Issue 5 (Digital-Cat):   #$ISSUE_5"
echo "  Issue 6 (CPQ-Master):    #$ISSUE_6"
echo "  Epic 7 (Repo Health):    #$ISSUE_7"
echo "  Issue 8 (Branch prot):   #$ISSUE_8"
echo "  Issue 9 (Topics):        #$ISSUE_9"
echo "  Issue 10 (ADR-001):      #$ISSUE_10"
echo "  Issue 11 (Roadmap):      #$ISSUE_11"
echo "  Issue 12 (Comms std):    #$ISSUE_12"

# ──────────────────────────────────────────────
# 5. Add issues to project and set fields
# ──────────────────────────────────────────────
echo ""
echo "▶ Adding issues to project and setting field values..."

add_to_project_and_set_fields "$ISSUE_1"  "Backlog" "Backlog"  "P1" "Low"    "L" "No" "No"  "Planner"
echo "  ✓ Issue #$ISSUE_1 configured"
add_to_project_and_set_fields "$ISSUE_2"  "Backlog" "Backlog"  "P1" "Low"    "S" "No" "No"  "Implementer"
echo "  ✓ Issue #$ISSUE_2 configured"
add_to_project_and_set_fields "$ISSUE_3"  "Backlog" "Backlog"  "P1" "Low"    "S" "No" "No"  "Implementer"
echo "  ✓ Issue #$ISSUE_3 configured"
add_to_project_and_set_fields "$ISSUE_4"  "Backlog" "Backlog"  "P2" "Low"    "S" "No" "No"  "Implementer"
echo "  ✓ Issue #$ISSUE_4 configured"
add_to_project_and_set_fields "$ISSUE_5"  "Backlog" "Backlog"  "P2" "Low"    "S" "No" "No"  "Implementer"
echo "  ✓ Issue #$ISSUE_5 configured"
add_to_project_and_set_fields "$ISSUE_6"  "Backlog" "Backlog"  "P2" "Low"    "S" "No" "No"  "Implementer"
echo "  ✓ Issue #$ISSUE_6 configured"
add_to_project_and_set_fields "$ISSUE_7"  "Backlog" "Backlog"  "P2" "Low"    "M" "No" "Yes" "Repo-Health-Auditor"
echo "  ✓ Issue #$ISSUE_7 configured"
add_to_project_and_set_fields "$ISSUE_8"  "Ready"   "Backlog"  "P1" "Medium" "S" "No" "No"  "Implementer"
echo "  ✓ Issue #$ISSUE_8 configured"
add_to_project_and_set_fields "$ISSUE_9"  "Ready"   "Backlog"  "P2" "Low"    "S" "No" "No"  "Implementer"
echo "  ✓ Issue #$ISSUE_9 configured"
add_to_project_and_set_fields "$ISSUE_10" "Ready"   "Backlog"  "P2" "Low"    "S" "No" "No"  "Implementer"
echo "  ✓ Issue #$ISSUE_10 configured"
add_to_project_and_set_fields "$ISSUE_11" "Backlog" "Roadmap"  "P2" "Low"    "S" "No" "No"  "Planner"
echo "  ✓ Issue #$ISSUE_11 configured"
add_to_project_and_set_fields "$ISSUE_12" "Backlog" "Plan"     "P3" "Low"    "S" "No" "No"  "Planner"
echo "  ✓ Issue #$ISSUE_12 configured"

# ──────────────────────────────────────────────
# 6. Link sub-issues
# ──────────────────────────────────────────────
echo ""
echo "▶ Linking sub-issues to epics..."
link_sub_issue "$ISSUE_1" "$ISSUE_2"
link_sub_issue "$ISSUE_1" "$ISSUE_3"
link_sub_issue "$ISSUE_1" "$ISSUE_4"
link_sub_issue "$ISSUE_1" "$ISSUE_5"
link_sub_issue "$ISSUE_1" "$ISSUE_6"
echo "  ✓ Issues #$ISSUE_2–#$ISSUE_6 linked as sub-issues of #$ISSUE_1"

# ──────────────────────────────────────────────
# Done
# ──────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════"
echo "✅ Setup complete!"
echo ""
echo "Project board: $PROJECT_URL"
echo "Issues:        https://github.com/$OWNER/$REPO/issues"
echo "═══════════════════════════════════════════"
