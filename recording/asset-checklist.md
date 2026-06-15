# Asset Checklist

Pre-recording verification for both Loom videos.

## Video 1 — Governed API Contracts

**The Postman UI surface (Beats 1–3) is the strongest sell. Verify the
Governance Group looks pristine BEFORE worrying about the CI half.**

Postman surface:

- [ ] **FCMA Demo Sandbox** workspace created
- [ ] Compliant spec `Customer Truth Center API` in Spec Hub
- [ ] Proposed spec `Customer Truth Center API (proposed globalCustomerId)` in Spec Hub
- [ ] **Governance Group "FCMA Spec Rules"** scoped to FCMA Demo Sandbox
- [ ] All 8 rules visible in the group, ERROR severity, OpenAPI 3.0 format:
  - `correlation-id-required`
  - `operation-description-required`
  - `pagination-required-on-list-endpoints`
  - `path-parameter-casing`
  - `response-examples-required`
  - `schema-property-casing`
  - `secured-endpoints-require-401-403`
  - `standard-error-schema-required`
- [ ] At least one rule expanded once to confirm rule definitions render cleanly
- [ ] (Optional bonus shot) inline governance violations visible on the proposed spec in Spec Hub

CI surface:

- [ ] `npm run demo:fail` returns exactly 5 errors locally
- [ ] `npm run demo:pass` returns 0 errors locally
- [ ] GitHub Actions workflow visible (`.github/workflows/api-governance.yml`)
- [ ] Staged Action runs available: `main` green, `feature/global-customer-id` red, `fix/fcma-api-standards` green
- [ ] CI fail log visible (`ci/sample-output/fcma-api-governance-check.log`)
- [ ] Contract collection + environment in the workspace (carries over from later beats)

## Video 2 — Mock Servers

- [ ] Partner collection imported (`partner-online-banking-mock-demo.collection.json`)
- [ ] Happy-path examples present (auth-token-200, loan-summary-200, account/eligibility 200s)
- [ ] Edge-case examples present (partner-unavailable-503, auth-failure-401, malformed-loan-summary-200, payment-quote-business-failure-422)
- [ ] Mock server created from the partner collection
- [ ] Mock URL pasted into the **Local Dev - Partner Mock** environment (`baseUrl`)
- [ ] **Partner Sandbox** environment available for the toggle moment
- [ ] curl commands ready in a terminal (loan summary happy path + one edge case)
- [ ] Mock-demo workflow visible (`.github/workflows/mock-demo-smoke.yml`)
- [ ] Local dev output log visible (`ci/sample-output/mock-server-local-dev-output.log`)
