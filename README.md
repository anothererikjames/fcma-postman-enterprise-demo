# FCMA Postman Enterprise Demo Assets

## Purpose

Supporting assets for two async Loom videos prepared for Farm Credit
Mid-America (FCMA):

1. **Governed API Contracts: SpecHub, Standards, and Governance Rules**
2. **Mock Servers for Third-Party Integration Development**

## What this demo is

Postman Enterprise positioned as the **API contract operating layer** beneath
FCMA's existing stack:

- **Governed API contracts** — organizational standards (OAuth2,
  `X-Correlation-Id`, `StandardError`, pagination, examples, 401/403)
  expressed once and applied consistently across teams.
- **Standardization and deployment confidence** — a deterministic pre-merge
  governance check moves the FCMA API standard out of reviewer memory and
  into a repeatable step, so contract problems are caught at design time,
  before deploy.
- **Mock-server inner loop** — third-party integration development against a
  deterministic mock of the partner contract, including edge cases that are
  hard to force against a real sandbox, before partner systems are available.

## What this demo is not

This is **not** a replacement for anything FCMA already runs:

- Not a Checkly replacement — Checkly remains the post-deploy synthetic
  monitoring layer.
- Not a Backstage replacement.
- Not a Redocly/RDoc or Swagger replacement.
- Not a Playwright replacement.
- Not a replacement for FCMA's CI/CD — the governance check runs as a step
  inside the orchestrator FCMA already uses.

## Video 1 — Governed API Contracts

Walks the governed contract workflow on the Customer Truth Center API:

1. Start from the FCMA API standard (OAuth2, `X-Correlation-Id`,
   `StandardError`, pagination, examples, 401/403).
2. Open `apis/customer-truth-center/openapi-compliant.yaml` — a sanitized
   customer-truth-style API whose contract has a known standard shape.
3. Open `apis/customer-truth-center/openapi-proposed-global-customer-id.yaml`
   — a proposed `customerId` → `globalCustomerId` rename carrying five
   standards violations.
4. `npm run demo:fail` — the governance check blocks the change with readable
   violations.
5. `npm run demo:pass` — the compliant contract goes through clean.
6. `.github/workflows/api-governance.yml` shows the same check as a pre-merge
   step inside existing CI/CD.

## Video 2 — Mock Servers for Third-Party Integration

Walks the partner-integration inner loop on the Partner Online Banking API:

1. The partner contract and collection
   (`postman/collections/partner-online-banking-mock-demo.collection.json`).
2. A Postman mock server built from the collection; local code points at the
   mock URL instead of waiting on a partner sandbox.
3. Happy path: `GET /loans/{{loanId}}/summary` → deterministic `200 ACTIVE`.
4. Edge cases on demand: `503 PARTNER_UNAVAILABLE`, `401 INVALID_TOKEN`,
   malformed `200` body, `422 PAYMENT_QUOTE_NOT_AVAILABLE`.
5. Environment toggle: Local Dev (mock) vs Partner Sandbox — same collection,
   different target.

## Quick start

```bash
npm install
npm run demo:fail   # proposed spec fails the FCMA API standards check (5 violations)
npm run demo:pass   # compliant spec passes clean
```

Other scripts:

```bash
npm run lint:customer    # lint the working spec (openapi.yaml) for this branch
npm run contract:smoke   # newman run of the contract collection (demo endpoint, see note below)
npm run mock:smoke       # newman run of the mock collection (replace mock URL first, see note below)
```

## Recording setup

1. Import both collections from `postman/collections/` and all three
   environments from `postman/environments/` into a Postman workspace
   (suggested name: **FCMA Demo Sandbox**).
2. Create a **mock server** from the Partner Online Banking collection.
3. Replace `baseUrl` in the `Local Dev - Partner Mock` environment
   (placeholder `https://mock-server-url.example.com`) with the generated
   mock URL.
4. Run `npm run demo:fail` and `npm run demo:pass` in a terminal sized for
   recording.
5. Record the two Looms using the outlines in `recording/`.

## GitHub Actions

| Workflow | Trigger | What it runs |
| --- | --- | --- |
| **API Governance** (`api-governance.yml`) | PRs touching `apis/**` or `governance/**`; manual dispatch | `npm run lint:customer:proposed` — the FCMA API standards check |
| **Contract Conformance** (`contract-conformance.yml`) | PRs touching the contract collection/environment; manual dispatch | `npm run contract:smoke` — **illustrative**: the demo baseUrl (`api.fcma-demo.local`) is not a live service; attach a mock or local server for it to execute meaningfully |
| **Mock Demo Smoke** (`mock-demo-smoke.yml`) | PRs touching the mock collection/environment; manual dispatch | `npm run mock:smoke` — replace `https://mock-server-url.example.com` with your real Postman mock URL first |

## Branch demo path

| Branch | `apis/customer-truth-center/openapi.yaml` | Governance result |
| --- | --- | --- |
| `main` | Compliant base | Passes |
| `feature/global-customer-id` | Proposed `globalCustomerId` spec (5 deliberate violations) | **Fails** |
| `fix/fcma-api-standards` | Compliant spec restored | Passes |

Demo flow: open the failing branch → show the diff → `npm run demo:fail` →
switch to the fix branch → `npm run demo:pass`.

## Sanitization note

All data in this repository is fake and demo-only. Hosts are placeholders
(`api.fcma-demo.local`, `partner-sandbox.example.com`,
`mock-server-url.example.com`); identifiers are demo values
(`cust_demo_1001`, `loan_demo_2001`, `acct_demo_1001`,
`01J0FCMADEMO8A7Z4Y6X3W2V1T`). No real FCMA customer data, names, or secrets
appear anywhere.
