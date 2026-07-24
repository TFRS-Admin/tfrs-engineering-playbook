<!-- Purpose: Production-ready template for documenting a repository's current architecture. -->
# Repository Architecture Template

Copy this into a new `ARCHITECTURE.md` at the root of any repository adopting this playbook. Keep it current — documentation drift against this file is checked in [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md).

---

# tfrs-website Architecture

## Purpose

`tfrs-website` is the public marketing and customer-facing site for TFRS. It serves static marketing pages, a contact form, and (as of Epic #142) a shared content-metadata pipeline.

## System Overview

```text
Browser
  ↓
Static pages (build-time rendered) ──▶ CDN
  ↓
Contact form POST ──▶ API layer (src/api/) ──▶ Validation (src/lib/contactFormRules.ts)
                                             ──▶ Storage
```

## Key Directories

| Path | Responsibility |
| --- | --- |
| `src/components/` | Presentational UI components (PascalCase, per [`docs/code-patterns/README.md`](../docs/code-patterns/README.md)) |
| `src/api/` | HTTP endpoint handlers and shared error shapes |
| `src/lib/` | Shared logic (validation rules, formatting helpers) reused by both client and server code |
| `docs/decision-log/` | ADRs recording architectural decisions for this repository |

## External Dependencies

- CDN for static asset delivery.
- No external database as of this writing; contact form submissions are stored via the API layer's storage adapter (see `src/api/storage.ts`).

## Architectural Decisions in Effect

See [`docs/decision-log/`](../docs/decision-log/README.md) for the full ADR index. Notably: ADR-002 establishes that client and server validation share one rule module rather than maintaining parallel definitions.

## Known Constraints

- The shared validation module (`src/lib/contactFormRules.ts`) must remain framework-agnostic since both the browser bundle and the server import it directly.
- Page metadata generation depends on the shared source introduced in Epic #142 — do not reintroduce per-page hand-maintained metadata.

## Last Reviewed

2026-07-09, as part of the `tfrs-website` onboarding pass described in [`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md).

## Related Documents

[`REPOSITORY_BOOTSTRAP_GUIDE.md`](../REPOSITORY_BOOTSTRAP_GUIDE.md) · [`REPO_HEALTH_STANDARD.md`](../REPO_HEALTH_STANDARD.md) · [`docs/decision-log/README.md`](../docs/decision-log/README.md)
