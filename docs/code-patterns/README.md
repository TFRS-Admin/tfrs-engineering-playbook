<!-- Purpose: Document approved TypeScript-oriented implementation patterns for TFRS repositories. -->
# TFRS Code Patterns

## Comments

Comment the *why*, not the *what* — well-named code already shows what it does. A comment earns its place only when it explains a non-obvious constraint, a workaround, or a reason a future reader would otherwise have to rediscover the hard way. Don't leave TODOs for something you could just do now, and don't leave commented-out code — git history already remembers it.

## Async Patterns

- Prefer `async` functions with `await` for readability.
- Use `Promise.all` only when work is truly independent.
- Wrap external I/O in small functions so failures stay localized.

```ts
export async function loadCustomerProfile(
  apiClient: ApiClient,
  customerId: string,
): Promise<{ customer: Customer; orders: Order[] }> {
  const [customer, orders] = await Promise.all([
    apiClient.getCustomer(customerId),
    apiClient.listOrders(customerId),
  ]);

  return { customer, orders };
}
```

## Error Handling

- Throw domain-relevant errors with actionable messages.
- Do not swallow exceptions silently.
- Convert unknown upstream failures into repository-appropriate error shapes at boundaries.
- **Pick one error pattern per API and use it everywhere.** If some endpoints throw, others return `null` on failure, and others return `{ error }`, a consumer can't predict behavior without reading every call site. For REST endpoints, pair an HTTP status code with a structured error body (`{ error: { code, message, details? } }`): `400` invalid input, `401` not authenticated, `403` authenticated but not authorized, `404` not found, `409` conflict, `422` validation failed, `500` server error (never expose internal detail in the message).

```ts
export async function fetchInventory(apiClient: ApiClient, sku: string): Promise<Inventory> {
  try {
    return await apiClient.getInventory(sku);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    throw new Error(`Unable to load inventory for ${sku}: ${message}`);
  }
}
```

## Module Structure

- Keep one primary responsibility per module.
- Export named functions by default for easier refactoring and testing.
- Group pure helpers near the feature that uses them unless they are broadly shared.

## Component Patterns (React When Applicable)

- Use PascalCase component filenames.
- Keep presentational components thin and move data fetching into hooks or container layers.
- Prefer explicit props over spreading broad objects into components.
- Interactive and user-facing components meet **WCAG 2.1 AA**: keyboard-navigable, meaningful ARIA labels, visible focus states, and a contrast ratio of at least 4.5:1 for normal text (3:1 for large text). This is a pointer, not a full accessibility standard — expand into a dedicated standard if a repository's UI surface grows enough to need one.
- Choose state management by scope, not by habit:

| Scope | Use |
| --- | --- |
| Component-specific UI state | Local state (`useState`) |
| Shared between 2–3 sibling components | Lifted state |
| Read-heavy, write-rare (theme, auth, locale) | Context |
| Filters, pagination, shareable UI state | URL state (`searchParams`) |
| Remote data with caching | Server-state library (React Query, SWR) |
| Complex client state shared app-wide | Global store (Zustand, Redux) |

Avoid prop drilling deeper than 3 levels — reach for Context or restructure instead.

## API Call Patterns

- Centralize HTTP clients or SDK wrappers.
- Validate inputs before making remote calls.
- Normalize responses so UI and services do not each reinvent mapping logic.
- **Trust internal code; validate at system edges.** Validation belongs where external input enters — route handlers, form submission handlers, parsing a third-party service's response (always treat third-party data as untrusted, per [`SECURITY_STANDARD.md`](../../SECURITY_STANDARD.md)) — not between internal functions that already share a type contract.
- **Prefer addition over modification** when evolving a shared interface: add an optional field rather than removing or retyping an existing one. Once an interface has real consumers, assume every observable behavior is depended on by somebody regardless of what the contract promises (Hyrum's Law) — a "safe" change to undocumented behavior can still break a consumer. Plan for how a field would eventually be removed at the point you add it, rather than leaving that for later.
- **Avoid forcing consumers to choose between multiple versions of the same dependency or API at once** — extend an existing interface rather than forking it into a v2 that must be maintained alongside v1 indefinitely.
