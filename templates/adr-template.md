<!-- Purpose: Production-ready Architecture Decision Record template. This is the single authoritative copy — see docs/decision-log/README.md for the index that uses it. -->
# ADR Template

Copy this into a new file under `docs/decision-log/` (e.g. `docs/decision-log/ADR-002-title.md`) and add an entry to that repository's ADR index.

---

# ADR-002: Replace client-only contact form validation with a shared server-side rule set

Status: Accepted

## Context

`tfrs-website`'s contact form validated required fields and formats only in the browser. Any client bypassing the UI — a direct API call, a script, or a misbehaving integration — could submit invalid data, and there was no shared source of truth between client and server for what "valid" meant.

## Decision

Introduce a server-side validation layer that reuses the existing client-side rule definitions (`src/lib/contactFormRules.js`) rather than maintaining a second, separate rule set. The API rejects invalid submissions with a 400 and field-level errors before they reach storage.

## Consequences

Submissions are now guaranteed valid regardless of client behavior. Future form fields must update the shared rule module rather than client and server rule sets independently, which removes an entire class of client/server drift bug but means the shared module needs to stay framework-agnostic (no client-only APIs) as new fields are added.

## Related Documents

[`docs/decision-log/README.md`](../docs/decision-log/README.md) · [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md)
