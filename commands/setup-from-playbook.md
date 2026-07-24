<!-- Purpose: Executable procedure for adopting this playbook in an existing repository that hasn't fully onboarded yet. -->
# Command: Setup From Playbook

## Purpose

Bring an existing repository that has partially or informally adopted TFRS conventions fully onto this playbook. This is the "existing repository" entry point; for a brand-new repository or the full end-to-end lifecycle including establishing repository engineering documentation, use [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md) instead — this command is one step of that guide, runnable on its own when a repository just needs its baseline files aligned.

## When to Use It

- A repository already has code and its own conventions, but hasn't adopted `AGENTS.md`/`CLAUDE.md`/the standards from this playbook.
- A repository has drifted from the playbook (e.g., its own `AGENTS.md` references something other than this playbook or the shared skills fork) and needs to be realigned — check [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md) first to see exactly what's missing.

## Required Inputs

- Read access to the target repository's current README, `AGENTS.md`/`CLAUDE.md` (if any), branch protection settings, and contributor docs.
- The current playbook version from [`VERSION.md`](../VERSION.md).

## Required Skill Consultation

Check for `skills/tfrs/repository-adoption` in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) first (see [`SKILLS_STANDARD.md#skill-selection`](../SKILLS_STANDARD.md#skill-selection)). As of this writing it does not exist in the fork yet; until it does, this command is the whole procedure.

## Minimum Baseline

This is the one authoritative list of what a downstream repository must have — by copy where an agent needs it without a live fetch of this repository, or by GitHub-native placement where GitHub itself only honors a file living in the consuming repository. Everything else in this playbook is referenced, never copied — copying a `*_STANDARD.md` doc or a `commands/` file creates a second copy that drifts the moment this repository updates.

| File | Handling | Why |
| --- | --- | --- |
| `AGENTS.md` | Copy | Read first, every session, per [`AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol`](../AI_AGENT_OPERATING_MODEL.md#1-session-initialization-protocol) step 2. |
| `CLAUDE.md` | Copy | Same rationale, step 3. |
| `AI_AGENT_OPERATING_MODEL.md` | Copy | The operating loop itself — an agent needs the full protocol locally, not a summary of it. |
| `DECISION_ROUTER.md` | Copy | Needed to route a plain-language request before the agent has done anything else. |
| `ARCHITECTURE.md` | Create (repository-specific from the moment it exists) | Seeded from [`templates/repository-architecture-template.md`](../templates/repository-architecture-template.md). |
| `docs/engineering/ROADMAP.md` | Create | Seeded from [`templates/engineering-roadmap-template.md`](../templates/engineering-roadmap-template.md) — sequenced Epics as sections, plus anything not yet scheduled. |
| `docs/engineering/backlog/` | Create (directory, may start empty) | Holds one file per work item, per [`WORK_ITEM_METADATA_STANDARD.md`](../WORK_ITEM_METADATA_STANDARD.md) — this is the backlog; there is no separate index file. |
| `.github/PULL_REQUEST_TEMPLATE.md` | GitHub-native (must exist locally) | GitHub only surfaces a PR template that lives in the consuming repository. |

None of the above requires a GitHub Issue template or a GitHub Project — work items are files, per [`WORK_ITEM_METADATA_STANDARD.md`](../WORK_ITEM_METADATA_STANDARD.md).

Everything else — [`WORK_ITEM_METADATA_STANDARD.md`](../WORK_ITEM_METADATA_STANDARD.md), [`RULESET.md`](../RULESET.md), [`BACKLOG_STANDARD.md`](../BACKLOG_STANDARD.md), [`SECURITY_STANDARD.md`](../SECURITY_STANDARD.md), [`TESTING_STANDARD.md`](../TESTING_STANDARD.md), [`SKILLS_STANDARD.md`](../SKILLS_STANDARD.md), the [`commands/`](./README.md) library, and [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md) — is referenced directly from this repository, never copied.

The four copied files are written so their own links stay valid once copied into a downstream repository: a link from one copied baseline file to another (e.g. `AGENTS.md` → `CLAUDE.md`) stays a local relative link, since both sides travel together; a link from a copied file to anything centralized (any `*_STANDARD.md`, `RULESET.md`, `REPOSITORY_BOOTSTRAP_GUIDE.md`, or anything under `commands/` or `templates/`) is a full `https://github.com/TFRS-Admin/tfrs-engineering-playbook/blob/main/...` URL back to this repository. Follow this same convention if you ever add a link to one of the four baseline files.

## Workflow

1. Review the target repository's README, branch protections, and existing contributor docs — including any existing `AGENTS.md`/`CLAUDE.md`, even an informal one; don't assume the repository has nothing to say.
2. Copy the baseline files ([`AGENTS.md`](../AGENTS.md), [`CLAUDE.md`](../CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md), [`DECISION_ROUTER.md`](../DECISION_ROUTER.md)) per the Minimum Baseline above. If the repository has its own conflicting `AGENTS.md`, don't silently overwrite it — flag the conflict per [`SKILLS_STANDARD.md#precedence-on-conflict`](../SKILLS_STANDARD.md#precedence-on-conflict) and get explicit sign-off on which rule wins before replacing it.
3. Update the target repository's README with a short section naming this repository as the engineering source of truth, and [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) as the skills execution library, per [`SKILLS_STANDARD.md`](../SKILLS_STANDARD.md).
4. Create `ARCHITECTURE.md`, `docs/engineering/ROADMAP.md`, and an empty `docs/engineering/backlog/` directory per the Minimum Baseline above — this is what makes the repository operational.
5. Add `.github/PULL_REQUEST_TEMPLATE.md` and any reusable workflow files from [`templates/`](../templates/README.md) that fit the target repository's stack.
6. Record the adopted playbook version from [`VERSION.md`](../VERSION.md) in the target repository.

## Required Outputs

- Baseline files present in the target repository, with any conflicts against its pre-existing local guidance explicitly resolved (not silently overwritten).
- A README section naming this playbook and the skills fork.
- A recorded playbook version.
- A pull request in the target repository summarizing files copied, files referenced, and any intentional deviations.

## Quality Gates

- No pre-existing repository-local instruction was silently discarded — every conflict was surfaced and resolved with explicit sign-off.
- Every item in the Minimum Baseline table above is actually present in the target repository — check by hand; there is no scored checklist to run.

## Failure Handling

- **The repository's existing local guidance conflicts with this playbook in a way that isn't a simple override**: stop and ask rather than deciding which one wins.
- **`docs/engineering/` files can't be seeded from real content yet** (e.g. no roadmap exists because this is a brand-new repository): create them anyway with an explicit "empty by design" note rather than skipping them.

## Example

**Input:**
> `tfrs-website` has its own `AGENTS.md` pointing agents at a locally vendored `agent-skills-main/` copy instead of this playbook or the TFRS fork, and no `ARCHITECTURE.md` or `docs/engineering/` files.

**Output (excerpt):**
```text
Conflict found: tfrs-website/AGENTS.md instructs agents to treat a vendored
agent-skills-main/ copy as authoritative, contradicting SKILLS_STANDARD.md's
"never vendor" rule and this playbook's canonical status.

Flagged for human sign-off rather than silently overwritten.

ARCHITECTURE.md, docs/engineering/ROADMAP.md, and docs/engineering/backlog/
are missing and recorded as the actual onboarding gap.
```
