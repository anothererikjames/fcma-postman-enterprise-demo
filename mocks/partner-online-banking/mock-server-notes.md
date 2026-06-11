# Partner Online Banking Mock Server Notes

These notes support the second video: **Mock Servers for Third-Party
Integration Development**.

## Purpose

A Postman mock server built from the Partner Online Banking collection gives
integration code a deterministic target during the development inner loop:

- **Deterministic responses for local dev** — the same request returns the
  same payload every time, so local runs and demos are repeatable.
- **Test against partner contracts before the partner API is ready** — the
  contract (OpenAPI + saved examples) is the source of truth; development
  starts before sandbox credentials or availability windows exist.
- **Simulate hard-to-force edge cases** — partner outages (`503
  PARTNER_UNAVAILABLE`), expired tokens (`401 INVALID_TOKEN`), malformed
  payloads (`malformed-loan-summary-200`), and business-rule failures (`422
  PAYMENT_QUOTE_NOT_AVAILABLE`) are one saved example away instead of a
  support ticket away.
- **Reduce blocked development cycles** — partner sandbox downtime, rate
  limits, and data resets stop blocking feature work.

## How to use

1. Import `postman/collections/partner-online-banking-mock-demo.collection.json`.
2. In Postman, create a **mock server** from that collection.
3. Copy the generated mock URL and replace `baseUrl` in
   `postman/environments/local-dev-partner-mock.environment.json`
   (placeholder: `https://mock-server-url.example.com`).
4. Select specific saved examples with the `x-mock-response-code` or
   `x-mock-response-name` request headers (e.g.
   `x-mock-response-name: malformed-loan-summary-200`).
5. Point local integration code's `PARTNER_API_BASE_URL` at the mock URL.

Example payloads also live as files in `examples/` for use outside Postman.

## What this does not do

The mock server does **not** replace:

- Real partner integration testing against the partner sandbox.
- Playwright end-to-end test suites.
- Checkly post-deploy synthetic monitoring.
- FCMA's CI/CD pipelines.

It sits beneath those layers and accelerates the inner loop so edge-case
handling is built and verified before code ships.
