<!-- Purpose: Production-ready Architecture Decision Record template. This is the single authoritative copy — see docs/decision-log/README.md for the index that uses it. -->
# ADR Template

Copy this into a new file under `docs/decision-log/` (e.g. `docs/decision-log/ADR-002-title.md`) and add an entry to that repository's ADR index.

`Status` follows this lifecycle: `Proposed` → `Accepted` → (`Superseded by ADR-XXX` | `Deprecated`). **Don't delete an old ADR when a decision changes** — record a new ADR and set the old one's status to `Superseded by ADR-XXX`, referencing the new one; the decision history stays intact either way.

---

# ADR-002: Replace client-only contact form validation with a shared server-side rule set

Status: Accepted
Date: 2026-07-09

## Context

`tfrs-website`'s contact form validated required fields and formats only in the browser. Any client bypassing the UI — a direct API call, a script, or a misbehaving integration — could submit invalid data, and there was no shared source of truth between client and server for what "valid" meant.

## Decision

Introduce a server-side validation layer that reuses the existing client-side rule definitions (`src/lib/contactFormRules.js`) rather than maintaining a second, separate rule set. The API rejects invalid submissions with a 400 and field-level errors before they reach storage.

## Alternatives Considered

**Duplicate the validation rules on the server independently.**
- Pros: no shared-module refactor required; server and client teams could iterate independently.
- Cons: guarantees drift over time as fields change on one side and not the other — the exact bug this ADR exists to close.
- Rejected: reintroduces the problem this decision is meant to solve.

**Validate only via a third-party form-handling service.**
- Pros: no custom validation code to maintain at all.
- Cons: adds an external dependency and cost for logic simple enough to own directly; TFRS's boundary-validation pattern (see [`docs/code-patterns/README.md`](../docs/code-patterns/README.md)) already expects this validation to live at the API edge.
- Rejected: disproportionate for the problem size.

## Consequences

Submissions are now guaranteed valid regardless of client behavior. Future form fields must update the shared rule module rather than client and server rule sets independently, which removes an entire class of client/server drift bug but means the shared module needs to stay framework-agnostic (no client-only APIs) as new fields are added.

## Related Documents

[`docs/decision-log/README.md`](../docs/decision-log/README.md) · [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md)
