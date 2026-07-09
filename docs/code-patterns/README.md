<!-- Purpose: Document approved JavaScript-oriented implementation patterns for TFRS repositories. -->
# TFRS Code Patterns

## Async Patterns

- Prefer `async` functions with `await` for readability.
- Use `Promise.all` only when work is truly independent.
- Wrap external I/O in small functions so failures stay localized.

```js
export async function loadCustomerProfile(apiClient, customerId) {
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

```js
export async function fetchInventory(apiClient, sku) {
  try {
    return await apiClient.getInventory(sku);
  } catch (error) {
    throw new Error(`Unable to load inventory for ${sku}: ${error.message}`);
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

## API Call Patterns

- Centralize HTTP clients or SDK wrappers.
- Validate inputs before making remote calls.
- Normalize responses so UI and services do not each reinvent mapping logic.
