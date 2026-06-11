# Partner Online Banking API (demo)

Sanitized representation of a third-party online banking partner API,
supporting the **Mock Servers for Third-Party Integration Development** video.
All hosts, identifiers, and data are fake demo values
(`partner-sandbox.example.com`, `loan_12345`, `acct_demo_1001`).

## Purpose

When a partner sandbox is slow, rate-limited, or not yet available, a Postman
mock server built from this contract gives local code a deterministic target:

- Happy path: `GET /loans/{loanId}/summary` returns a stable `200 ACTIVE` payload.
- Edge cases that are hard to force against a real sandbox: `503 PARTNER_UNAVAILABLE`,
  `401 INVALID_TOKEN`, a malformed `200` body, and a `422 PAYMENT_QUOTE_NOT_AVAILABLE`
  business failure.

Mock example payloads live in `mocks/partner-online-banking/examples/` and as
saved examples in `postman/collections/partner-online-banking-mock-demo.collection.json`.

This does not replace real partner integration testing, Playwright, Checkly,
or FCMA's CI/CD — it accelerates the inner loop before code ships.
