<!-- Purpose: Provide the standard checklist for creating a new TFRS repository from this playbook. -->
# New TFRS Repository Checklist

## Repository Setup

- [ ] Create the repository with a clear name, description, and visibility.
- [ ] Protect `main` with required pull requests and status checks.
- [ ] Add repository topics and a concise description that matches the product domain.

## Playbook Adoption

- [ ] Copy the Minimum Baseline exactly — see [`commands/setup-from-playbook.md#minimum-baseline`](../commands/setup-from-playbook.md#minimum-baseline): [`AGENTS.md`](../AGENTS.md), [`CLAUDE.md`](../CLAUDE.md), [`AI_AGENT_OPERATING_MODEL.md`](../AI_AGENT_OPERATING_MODEL.md), and [`DECISION_ROUTER.md`](../DECISION_ROUTER.md).
- [ ] Reference (don't copy) [`RULESET.md`](../RULESET.md), [`WORK_ITEM_METADATA_STANDARD.md`](../WORK_ITEM_METADATA_STANDARD.md), and the rest of the `*_STANDARD.md` family directly from this playbook.
- [ ] Add a README section linking back to this playbook repository and naming [`TFRS-Admin/agent-skills`](https://github.com/TFRS-Admin/agent-skills) as the skills execution library.
- [ ] Record the adopted playbook version from [`VERSION.md`](../VERSION.md).
- [ ] Create `ARCHITECTURE.md`, `docs/engineering/ROADMAP.md`, and an empty `docs/engineering/backlog/` directory, per [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md).

## Repository Metadata

- [ ] Add repository topics.
- [ ] Verify repository description reflects the current product and owner.
- [ ] Confirm the PR template is enabled.
