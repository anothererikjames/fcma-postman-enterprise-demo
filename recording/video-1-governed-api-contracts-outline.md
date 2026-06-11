# Video 1 — Governed API Contracts: SpecHub, Standards, and Governance Rules

Target length: 6–8 minutes. Async Loom.

## Opening (30s)

- Greet Michael, Jacob, and Andrei.
- Framing: "Checkly stays post-deploy; Backstage, Redocly, Swagger,
  Playwright, and your CI/CD all stay exactly where they are. What I want to
  show is the governed API contract layer that sits beneath that existing
  stack — how a contract change gets standardized, checked, and promoted
  before anything deploys."

## Beat 1 — Start from a standard (1 min)

- Show the FCMA API standard as a short list: OAuth2 bearer auth,
  `X-Correlation-Id` on every operation, `StandardError` for all 4xx/5xx,
  pagination envelope on list endpoints, examples on every 200, 401/403 on
  secured operations.
- Point: this is organizational standardization — one standard, every team,
  every contract.

## Beat 2 — The compliant contract (1 min)

- Open `apis/customer-truth-center/openapi-compliant.yaml`.
- "This is a sanitized customer-truth-style API; the point is the contract
  has a known standard shape." Scroll the operations and the shared
  components (CorrelationId parameter, StandardError, Pagination).

## Beat 3 — A proposed change (1–2 min)

- Open `apis/customer-truth-center/openapi-proposed-global-customer-id.yaml`.
- The rename: `customerId` → `globalCustomerId` — mirrors the change Matt
  mentioned in the workshop.
- A realistic change that quietly drifts from the standard in five places.

## Beat 4 — The failing check (1–2 min)

- Run `npm run demo:fail`.
- Walk the violations: missing 403, missing X-Correlation-Id, inline error
  object, snake_case `cust_id`, missing description.
- Point: "This is the standards check moving from reviewer memory into a
  deterministic step." Design-time feedback, before deploy.

## Beat 5 — The passing check (30s)

- Run `npm run demo:pass`. Clean result on the compliant contract.

## Beat 6 — Inside existing CI/CD (1 min)

- Show `.github/workflows/api-governance.yml`.
- "Not replacing FCMA's CI/CD — a step inside the orchestrator you already
  use." Same idea applies in any pipeline (GitHub Actions here as the demo
  vehicle).

## Close (30s)

- Standardization plus deployment confidence before runtime monitoring.
- Checkly remains the post-deploy synthetic layer; this catches contract
  drift before it ever reaches Checkly.
