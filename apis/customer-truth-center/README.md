# Customer Truth Center API (demo)

Sanitized, demo-only representation of a customer "source of truth" API used in
the **Governed API Contracts** video. All hosts, identifiers, and data are fake
demo values (`api.fcma-demo.local`, `cust_demo_1001`, `01J0FCMADEMO8A7Z4Y6X3W2V1T`).

## Files

| File | Purpose |
| --- | --- |
| `openapi.yaml` | Working spec for the current branch. On `main` it matches the compliant base; on `feature/global-customer-id` it is replaced with the failing proposed spec; on `fix/fcma-api-standards` it is restored to the compliant version. |
| `openapi-compliant.yaml` | Version `1.0.0`. Passes the FCMA API standards ruleset. Used by `npm run demo:pass`. |
| `openapi-proposed-global-customer-id.yaml` | Version `1.1.0-proposed`. Renames `{customerId}` to `{globalCustomerId}` and intentionally includes five governance violations. Used by `npm run demo:fail`. |

## Deliberate violations in the proposed spec

1. `GET /customers/{globalCustomerId}/loans` — missing `X-Correlation-Id` header parameter.
2. `GET /customers/{globalCustomerId}` — missing `403` response.
3. Snake_case field `cust_id` added to the `Customer` schema.
4. `POST /customers/search` — `400` response uses an inline error object instead of `StandardError`.
5. `GET /customers/{globalCustomerId}/relationships` — has a `summary` but no `description`.

Run `npm run demo:fail` and `npm run demo:pass` from the repo root to see the
governance check in action.
