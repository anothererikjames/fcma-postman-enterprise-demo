# Video 2 — Mock Servers for Third-Party Integration Development

Target length: 5–7 minutes. Async Loom.

## Opening (30s)

- Greet Michael, Jacob, and Andrei.
- Framing: "This one is about Andrei's daily third-party integration
  workflow. Mock servers don't replace real partner validation, Playwright,
  Checkly, or your CI/CD — they make the inner development loop faster
  before code ever reaches those layers."

## Beat 1 — The partner contract (1 min)

- Open the **Partner Online Banking API - Mock Demo** collection in Postman.
- Five requests: OAuth token, account balances, loan summary, payment quote,
  customer eligibility — a sanitized third-party online banking surface.

## Beat 2 — The mock server URL (1 min)

- Show the mock server created from this collection and its URL.
- "Local code points here instead of waiting on a partner sandbox." Show
  `PARTNER_API_BASE_URL` in `ci/sample-output/mock-server-local-dev-output.log`.

## Beat 3 — Happy path (1 min)

- Send `GET {{baseUrl}}/loans/{{loanId}}/summary` → deterministic
  `200 ACTIVE` payload, same every time.

## Beat 4 — Edge cases on demand (1–2 min)

- `503 PARTNER_UNAVAILABLE` (retry logic), `401 INVALID_TOKEN` (token
  refresh), `malformed-loan-summary-200` (defensive parsing), and
  `422 PAYMENT_QUOTE_NOT_AVAILABLE` (business-rule handling).
- "These are hard to reproduce against a real sandbox, easy in the mock."

## Beat 5 — Environment toggle (1 min)

- Switch between **Local Dev - Partner Mock** and **Partner Sandbox**
  environments. "Same collection, different target." When the real sandbox
  is available, nothing about the workflow changes.

## Beat 6 — Optional CI hook (30s)

- Show `.github/workflows/mock-demo-smoke.yml` briefly; the point is the
  inner loop, not the pipeline.

## Close (30s)

- Faster third-party integration, fewer blocked development cycles, better
  edge-case coverage before code ships.
