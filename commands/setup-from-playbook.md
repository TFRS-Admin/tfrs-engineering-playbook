<!-- Purpose: Executable procedure for adopting this playbook in an existing repository that hasn't fully onboarded yet. -->
# Command: Setup From Playbook

## Purpose

Bring an existing repository that has partially or informally adopted TFRS conventions fully onto this playbook. This is the "existing repository" entry point; for a brand-new repository or the full end-to-end lifecycle including establishing repository engineering documentation, use [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md) instead — this command is one step of that guide (step 2, "Copy Playbook"), runnable on its own when a repository just needs its baseline files aligned.

## When to Use It

- A repository already has code and its own conventions, but hasn't adopted `AGENTS.md`/`CLAUDE.md`/the standards from this playbook.
- A repository has drifted from the playbook (e.g., its own `AGENTS.md` references something other than this playbook or the shared skills fork) and needs to be realigned — run [`REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist`](../REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist) first to see exactly what's missing.

## Required Inputs

- Read access to the target repository's current README, `AGENTS.md`/`CLAUDE.md` (if any), branch protection settings, and contributor docs.
- The current playbook version from [`VERSION.md`](../VERSION.md).

## Required Skill Consultation

Check for `skills/tfrs/repository-adoption` in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) first (see [`SKILLS_STANDARD.md#skill-selection`](../SKILLS_STANDARD.md#skill-selection)). As of this writing it does not exist in the fork yet; until it does, this command is the whole procedure — there is no generic upstream skill for adopting a TFRS-specific playbook.

## Minimum Baseline

This is the one authoritative list of what a downstream repository must have — by copy where an agent needs it without a live fetch of this repository, or by GitHub-native placement where GitHub itself only honors a file living in the consuming repository. Everything else in this playbook is referenced, never copied (see [`README.md#what-should-stay-centralized`](../README.md#what-should-stay-centralized)) — copying a `*_STANDARD.md` doc or a `commands/` file creates a second copy that drifts the moment this repository updates. If a step below or elsewhere in this playbook ever conflicts with this table, this table wins for what counts as baseline.

| File | Handling | Why |
| --- | --- | --- |
| `AGENTS.md` | Copy | Read first, every session, per [`AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol`](../AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol) step 2 — an agent needs this without fetching this repository first. |
| `CLAUDE.md` | Copy | Same rationale, step 3. |
| `AI_AGENT_OPERATING_MODEL.md` | Copy | The operating loop itself — an agent needs the full protocol locally, not a summary of it. |
| `DECISION_ROUTER.md` | Copy | Needed to route a plain-language request (step 6–7 of the Session Initialization Protocol) before the agent has done anything else — it cannot be deferred to a live fetch either. |
| `ARCHITECTURE.md` | Create (repository-specific from the moment it exists) | Seeded from [`templates/repository-architecture-template.md`](../templates/repository-architecture-template.md) — this is what an agent reads to determine current-state architecture without re-deriving it via `commands/review.md` every session. |
| `docs/engineering/ROADMAP.md` | Create | Seeded from [`templates/engineering-roadmap-template.md`](../templates/engineering-roadmap-template.md) — the repository's own sequenced Epic list; this is what `AI_AGENT_OPERATING_MODEL.md#2-how-to-determine-current-work` reads for broader context. |
| `docs/engineering/BACKLOG.md` | Create | Seeded from [`templates/engineering-backlog-template.md`](../templates/engineering-backlog-template.md) — the repository's own backlog index, kept in sync with the GitHub Issues it lists. |
| `docs/engineering/CURRENT_SPRINT.md` | Create | Seeded from [`templates/engineering-current-sprint-template.md`](../templates/engineering-current-sprint-template.md) — read before GitHub Issues themselves in the "what's next" order, since it names what's actively in flight. |
| `docs/engineering/REPO_HEALTH.md` | Create | Seeded from [`templates/engineering-repo-health-template.md`](../templates/engineering-repo-health-template.md) — the running Repository Health Report history per [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md). |
| `.github/ISSUE_TEMPLATE/` | GitHub-native (must exist locally) | GitHub only surfaces issue templates that live in the consuming repository, and they carry the `## Metadata` block from [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md). |
| `.github/PULL_REQUEST_TEMPLATE.md` | GitHub-native (must exist locally) | Same reason. |

None of the above requires a GitHub Project — see [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md). A Project is optional visualization a repository may add later; it is never part of this baseline.

Everything else — [`REVIEW_STANDARD.md`](../REVIEW_STANDARD.md), [`PLANNING_STANDARD.md`](../PLANNING_STANDARD.md), [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md), [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md), [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md), [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md), [`SECURITY_STANDARD.md`](../SECURITY_STANDARD.md), [`TESTING_STANDARD.md`](../TESTING_STANDARD.md), [`SKILLS_STANDARD.md`](../SKILLS_STANDARD.md), [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md), [`PR_AUTONOMY_STANDARD.md`](../PR_AUTONOMY_STANDARD.md), the [`commands/`](./README.md) library, [`AI_ENGINEERING_WORKFLOW.md`](../AI_ENGINEERING_WORKFLOW.md), and [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md) — is referenced directly from this repository, never copied. This resolves what used to be an inconsistent "copy or reference" framing elsewhere in this playbook; wherever you see `REVIEW_STANDARD.md` or `EXECUTION_STANDARD.md` described as something to "copy," treat this table as the correction.

The [Repository Readiness Checklist](../REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist) tests for this baseline directly — a repository failing an `AGENTS.md`, `CLAUDE.md`, or `DECISION_ROUTER.md` check on that list is failing this baseline, not a separate requirement.

The four copied files are written so their own links stay valid once copied into a downstream repository: a link from one copied baseline file to another (e.g. `AGENTS.md` → `CLAUDE.md`) stays a local relative link, since both sides travel together; a link from a copied file to anything centralized (any `*_STANDARD.md`, `AI_ENGINEERING_WORKFLOW.md`, `REPOSITORY_BOOTSTRAP_GUIDE.md`, or anything under `commands/` or `templates/`) is a full `https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/...` URL back to this repository, not a relative path that would silently 404 once the file no longer lives next to what it's referencing. Follow this same convention if you ever add a link to one of the four baseline files.

## Workflow

1. Review the target repository's README, branch protections, and existing contributor docs — including any existing `AGENTS.md`/`CLAUDE.md`, even an informal one; don't assume the repository has nothing to say.
2. Copy the baseline files ([`AGENTS.md`](../AGENTS.md), [`CLAUDE.md`](../CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md), [`DECISION_ROUTER.md`](../DECISION_ROUTER.md)) per the Minimum Baseline above. If the repository has its own conflicting `AGENTS.md`, don't silently overwrite it — flag the conflict per [`SKILLS_STANDARD.md#precedence-on-conflict`](../SKILLS_STANDARD.md#precedence-on-conflict) and get explicit sign-off on which rule wins before replacing it.
3. Update the target repository's README with a short section naming this repository as the engineering source of truth, and [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) as the skills execution library, per [`SKILLS_STANDARD.md`](../SKILLS_STANDARD.md).
4. Create `ARCHITECTURE.md` and the four `docs/engineering/` files per the Minimum Baseline above — this is the repository-local documentation that makes the repository operational; a GitHub Project is optional and never required (see [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md)). If a repository's humans want a Project anyway, align it to the same fields per that document, but do not block adoption on it.
5. Add `.github/ISSUE_TEMPLATE/` and `.github/PULL_REQUEST_TEMPLATE.md` (the GitHub-native baseline items above, with issue templates carrying the `## Metadata` block from [`ISSUE_METADATA_STANDARD.md`](../ISSUE_METADATA_STANDARD.md)), and any reusable workflow files from [`templates/`](../templates/README.md) that fit the target repository's stack.
6. Record the adopted playbook version from [`VERSION.md`](../VERSION.md) in the target repository.

## Required Outputs

- Baseline files present in the target repository, with any conflicts against its pre-existing local guidance explicitly resolved (not silently overwritten).
- A README section naming this playbook and the skills fork.
- A recorded playbook version.
- A pull request in the target repository summarizing files copied, files referenced, and any intentional deviations.

## Quality Gates

- No pre-existing repository-local instruction was silently discarded — every conflict was surfaced and resolved with explicit sign-off.
- The target repository's Repository Readiness Checklist (see [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist)) improves as a direct result of this pass — don't call this done without re-running the checklist.

## Failure Handling

- **The repository's existing local guidance conflicts with this playbook in a way that isn't a simple override**: stop and ask a human rather than deciding which one wins.
- **`docs/engineering/` files can't be seeded from real content yet** (e.g. no roadmap exists because this is a brand-new repository): create them anyway with an explicit "empty by design" note rather than skipping them — an absent file and an intentionally-empty one look identical to an agent unless the file says which it is.

## Example

**Input:**
> `tfrs-website` has its own `AGENTS.md` pointing agents at a locally vendored `agent-skills-main/` copy instead of this playbook or the TFRS fork, and no `ARCHITECTURE.md` or `docs/engineering/` files.

**Output (excerpt):**
```text
Conflict found: tfrs-website/AGENTS.md instructs agents to treat a vendored
agent-skills-main/ copy as authoritative, contradicting SKILLS_STANDARD.md's
"never vendor" rule and this playbook's canonical status.

Flagged for human sign-off rather than silently overwritten. Recorded as a
condition in the Repository Readiness Checklist rather than assumed fixed.

No GitHub Project exists, and none is required — issues use the
`## Metadata` block from ISSUE_METADATA_STANDARD.md directly. `ARCHITECTURE.md`
and `docs/engineering/` are missing and recorded as the actual onboarding gap.
```
