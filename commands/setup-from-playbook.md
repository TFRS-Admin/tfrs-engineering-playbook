<!-- Purpose: Executable procedure for adopting this playbook in an existing repository that hasn't fully onboarded yet. -->
# Command: Setup From Playbook

## Purpose

Bring an existing repository that has partially or informally adopted TFRS conventions fully onto this playbook. This is the "existing repository" entry point; for a brand-new repository or the full end-to-end lifecycle including GitHub Project setup, use [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md) instead — this command is one step of that guide (step 2, "Copy Playbook"), runnable on its own when a repository just needs its baseline files aligned.

## When to Use It

- A repository already has code and its own conventions, but hasn't adopted `AGENTS.md`/`CLAUDE.md`/the standards from this playbook.
- A repository has drifted from the playbook (e.g., its own `AGENTS.md` references something other than this playbook or the shared skills fork) and needs to be realigned — run [`REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist`](../REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist) first to see exactly what's missing.

## Required Inputs

- Read access to the target repository's current README, `AGENTS.md`/`CLAUDE.md` (if any), branch protection settings, and contributor docs.
- The current playbook version from [`VERSION.md`](../VERSION.md).

## Required Skill Consultation

Check for `skills/tfrs/repository-adoption` in [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) first (see [`SKILLS_STANDARD.md#skill-selection`](../SKILLS_STANDARD.md#skill-selection)). As of this writing it does not exist in the fork yet; until it does, this command is the whole procedure — there is no generic upstream skill for adopting a TFRS-specific playbook.

## Workflow

1. Review the target repository's README, branch protections, and existing contributor docs — including any existing `AGENTS.md`/`CLAUDE.md`, even an informal one; don't assume the repository has nothing to say.
2. Copy or reference the baseline files: [`AGENTS.md`](../AGENTS.md), [`CLAUDE.md`](../CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md), [`REVIEW_STANDARD.md`](../REVIEW_STANDARD.md), and [`EXECUTION_STANDARD.md`](../EXECUTION_STANDARD.md). If the repository has its own conflicting `AGENTS.md`, don't silently overwrite it — flag the conflict per [`SKILLS_STANDARD.md#precedence-on-conflict`](../SKILLS_STANDARD.md#precedence-on-conflict) and get explicit sign-off on which rule wins before replacing it.
3. Update the target repository's README with a short section naming this repository as the engineering source of truth, and [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) as the skills execution library, per [`SKILLS_STANDARD.md`](../SKILLS_STANDARD.md).
4. Create or align the repository's GitHub Project using [`GITHUB_PROJECT_STANDARD.md`](../GITHUB_PROJECT_STANDARD.md) — or explicitly record that none exists yet and issues will use structured-text fields in the interim (see [`REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist`](../REPOSITORY_BOOTSTRAP_GUIDE.md#repository-readiness-checklist)).
5. Add issue templates, PR template, and any reusable workflow files from [`templates/`](../templates/README.md) that fit the target repository's stack.
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
- **No GitHub Project can be created in this pass** (tooling limits, missing permissions): document the limitation explicitly in the PR and in the target repository, per the honesty this playbook expects — don't claim Project setup is done when it isn't.

## Example

**Input:**
> `tfrs-website` has its own `AGENTS.md` pointing agents at a locally vendored `agent-skills-main/` copy instead of this playbook or the TFRS fork, and no GitHub Project.

**Output (excerpt):**
```text
Conflict found: tfrs-website/AGENTS.md instructs agents to treat a vendored
agent-skills-main/ copy as authoritative, contradicting SKILLS_STANDARD.md's
"never vendor" rule and this playbook's canonical status.

Flagged for human sign-off rather than silently overwritten. Recorded as a
condition in the Repository Readiness Checklist rather than assumed fixed.

No GitHub Project exists — recorded as a known gap; issues continue using
structured-text Priority/Risk/Size/Dependencies fields in the interim.
```
