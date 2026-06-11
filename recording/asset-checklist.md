# Asset Checklist

Pre-recording verification for both Loom videos.

## Video 1 — Governed API Contracts

- [ ] **FCMA Demo Sandbox** workspace created in Postman
- [ ] Customer Truth Center API imported into the workspace
- [ ] Compliant spec (`openapi-compliant.yaml`) imported
- [ ] Proposed `globalCustomerId` spec (`openapi-proposed-global-customer-id.yaml`) imported
- [ ] FCMA API Standards rules visible (SpecHub governance rules and/or `governance/fcma-api-standards.spectral.yaml`)
- [ ] Failing governance check ready (`npm run demo:fail` verified locally)
- [ ] Passing governance check ready (`npm run demo:pass` verified locally)
- [ ] GitHub Actions workflow visible (`.github/workflows/api-governance.yml` on GitHub)
- [ ] CI fail log visible (`ci/sample-output/fcma-api-governance-check.log`)
- [ ] Contract collection imported (`customer-truth-center-contract.collection.json`)
- [ ] FCMA contract environment imported (`fcma-contract-dev.environment.json`)

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
