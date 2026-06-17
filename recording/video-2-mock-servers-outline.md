# Video 2 — Mock Servers for Third-Party Integration Development

Target length: 5–7 minutes. Async Loom.

This video is for Andrei specifically — his daily integration workflow.
The narrative shape is: name his blocker, show the inner loop without it,
land the env-toggle moment as the close. Cut the CI beat; the CI story is
already told in Video 1 and dilutes momentum here.

## Opening (45s) — Andrei's blocker, named

- Greet Michael, Jacob, and Andrei by name.
- Frame the pain directly. Read it like you mean it:
  > "Andrei — every time you integrate with the partner online banking
  > API, you're blocked. Their sandbox is up maybe 60% of the time. You
  > can't trigger a 503 on demand. You're waiting three days for fresh
  > credentials when the existing set expires. Today I want to show you
  > what your inner development loop looks like when none of that is
  > blocking you anymore."
- One-line guardrail: "This doesn't replace the real partner validation,
  Playwright, Checkly, or your CI — it makes the dev loop faster *before*
  code reaches any of those layers."

## Beat 1 — The partner contract (1 min)

- Open the **Partner Online Banking API - Mock Demo** collection in Postman.
- Five requests: OAuth token, account balances, loan summary, payment quote,
  customer eligibility — a sanitized third-party online banking surface.
- "This is the contract you're integrating against — Andrei, this is what
  you've been waiting on the partner sandbox to give you reliable access to."

## Beat 2 — The mock server URL (1 min)

- Show the mock server created from this collection and its URL.
- "Local code points here instead of waiting on the partner sandbox."
- Open `ci/sample-output/mock-server-local-dev-output.log` — show
  `PARTNER_API_BASE_URL` resolving to the mock URL. "One env var. Andrei's
  local app now talks to a stable mock contract instead of a flaky sandbox."

## Beat 3 — Happy path AND every failure mode, in 30 seconds (2 min) [STRONGEST MIDDLE BEAT]

This used to be two beats. Land it as one continuous arc — the comparison
is what sells it.

- Send `GET {{baseUrl}}/loans/{{loanId}}/summary` → deterministic
  `200 ACTIVE` payload. Pause on it. "Same payload every time. Andrei's
  local code gets a known-good response in 30 milliseconds."
- Without changing endpoints, switch the example:
  - `partner-unavailable-503` → "Now I want to test what my retry logic
    does when the partner is down. Same endpoint, just flip the example."
  - `auth-failure-401` → "Token expired? Token refresh path tested."
  - `malformed-loan-summary-200` → "Partner ships a broken payload?
    Defensive parsing tested."
  - `payment-quote-business-failure-422` → "Business-rule rejection?
    Tested."
- Land the punchline: "In 30 seconds Andrei just tested four failure modes
  that would have taken weeks to reproduce against a real sandbox — if they
  can be reproduced there at all."

## Beat 4 — The env toggle — same collection, real sandbox (1.5 min) [THE CLOSE]

This is the strongest sell in the entire video. The "Postman is the
integration abstraction layer" moment. Land it slowly.

- Switch from **Local Dev - Partner Mock** to **Partner Sandbox** environment
  in the env switcher. Don't touch the collection.
- Send the same `GET /loans/{loanId}/summary`. This time it hits the
  real partner sandbox.
- "Same collection. Same request. Same code path in Andrei's app. The mock
  was scaffolding for the inner loop — when the real sandbox is available,
  this is the only thing that changes." (Point at the env dropdown.)
- "No code changes. No new test suite. No throwaway integration glue. The
  collection IS the contract — Andrei built once, runs against mock during
  dev, runs against sandbox during integration validation, runs against
  prod during smoke checks."

## Close (30s)

- Concrete benefit, not generic SaaS pitch:
  > "Andrei goes from 'I'm blocked, can't test, can't ship' to 'I'm
  > shipping defensive code that handles every failure mode the partner
  > has ever thrown at us — without ever waiting on their sandbox.'
  > That's hours per week of unblocked work, and code that handles
  > production failure modes the first time they happen instead of the
  > tenth."
- "Mock servers — design-time abstraction for the integrations your team
  doesn't control."

## Post-roll safety net (if asked)

If someone asks "how do you keep the mock in sync with the real contract
as the partner evolves?": "The mock is generated from the same OpenAPI
contract Andrei syncs from the partner. When the partner publishes a new
version, you re-import, regenerate the mock, and the same five requests
update with it. The mock is a downstream artifact of the contract — never
hand-maintained, never drifts unless the contract drifts."
