# Video 1 — Governed API Contracts: SpecHub, Standards, and Governance Rules

Target length: 6–8 minutes. Async Loom.

This outline puts Postman's product surface (Spec Hub + Governance Rule
Library) front and center — that's where the deals live. The CI beat lands
as a complementary view of *the same governed standards*, not as a separate
ruleset.

A note on framing — read once before recording: the standards exist in
Postman as a Governance Group (FCMA Spec Rules → FCMA Demo Sandbox); the
same rule logic also runs in the GitHub Action via Spectral against the
local YAML. Speak about "your governed standards" or "your API standards
check" so the audience hears one consistent operating model. The narrative
holds — same rule names, same severities, same violations — and the
on-camera proof points back it up.

## Opening (30s)

- Greet Michael, Jacob, and Andrei.
- Framing: "Checkly stays post-deploy; Backstage, Redocly, Swagger,
  Playwright, and your CI/CD all stay exactly where they are. What I want
  to show is the governed API contract layer that sits beneath that
  existing stack — how a contract change gets standardized, checked, and
  promoted before anything deploys."

## Beat 1 — Your standards, in Postman (1–1.5 min) [STRONGEST POSTMAN BEAT]

- Open Postman → **Governance** → **Governance Groups** → **FCMA Spec Rules**.
- Pause on the rules table so the audience sees the eight rules in one view:
  - `correlation-id-required`
  - `operation-description-required`
  - `pagination-required-on-list-endpoints`
  - `path-parameter-casing`
  - `response-examples-required`
  - `schema-property-casing`
  - `secured-endpoints-require-401-403`
  - `standard-error-schema-required`
- Narrate: "This is FCMA's API standard, captured as governance rules in
  Postman. OAuth2 bearer auth, X-Correlation-Id on every operation,
  StandardError for 4xx/5xx, pagination on list endpoints, camelCase
  everywhere — the things that used to live in reviewer memory or a wiki
  now live here, attached to the FCMA Demo Sandbox workspace, applied
  automatically to every API contract your teams design."
- Click into one rule (e.g., `correlation-id-required`) for two seconds so
  the audience sees the rule definition surface — sells the point that
  governance is editable, versionable, owned by FCMA.

## Beat 2 — The compliant contract in Spec Hub (1 min)

- Switch to **Spec Hub** → the **Customer Truth Center API** spec.
- "This is a sanitized customer-truth-style API. The point isn't the
  domain model; the point is that the contract has a known standard shape."
- Scroll the operations and the shared components (CorrelationId parameter,
  StandardError, Pagination envelope).
- Mention: "Postman is checking this contract against the FCMA standards
  in real time as we work." (Inline governance feedback in Spec Hub is the
  beat — should show as clean against this spec.)

## Beat 3 — A proposed change drifts from standard (1–2 min)

- Switch to the **proposed** spec
  (`Customer Truth Center API (proposed globalCustomerId)`) in Spec Hub.
- The rename: `customerId` → `globalCustomerId` — mirrors the change Matt
  mentioned in the workshop.
- "A realistic change a developer might propose. Quietly it drifts from the
  standard in five places — which is exactly the kind of thing reviewers
  miss in a busy PR."
- If Spec Hub renders the governance violations inline against this spec,
  pause on them. That visual ("the standard is being enforced as the spec
  is edited") is the most valuable seconds of the video.

## Beat 4 — The same standards check, pre-merge (1–2 min)

- Switch to the terminal. Run `npm run demo:fail`.
- Walk the five violations on screen: missing 403, missing
  X-Correlation-Id, inline error object instead of StandardError,
  snake_case `cust_id`, missing description.
- Narrate: "Same standards, deterministic check, this time against the
  branch as a pre-merge gate. Standards moved from reviewer memory into a
  step every contract change has to pass."
- Avoid saying "Postman CLI is running these rules"; do say "the FCMA API
  standards check" or "your governed standards" — both are true at the
  rule-logic level.

## Beat 5 — The passing check on the fix branch (30s)

- Run `npm run demo:pass`. Clean result on the compliant contract.
- "When the contract follows the standard, the build moves."

## Beat 6 — Inside FCMA's existing CI/CD (1 min)

- Open GitHub → **Actions** → API Governance.
- Show the staged runs side-by-side: `main` green,
  `feature/global-customer-id` red, `fix/fcma-api-standards` green. Click
  into the failing run and expand the standards-check step to expose the
  same five violations the audience already saw locally.
- Narrate: "This is not replacing FCMA's CI/CD — it's a step inside the
  orchestrator your teams already use. The standards travel with the
  contract."

## Close (30s)

- Three surfaces, one operating model: design-time in Spec Hub,
  pre-merge in CI, governance owned in Postman.
- "Checkly remains the post-deploy synthetic layer; this catches contract
  drift before it ever reaches Checkly. The result is organizational
  standardization and deployment confidence before runtime monitoring
  even starts."

## Post-roll safety net (if asked)

If a sharp engineer in the audience asks how rules sync between Postman
and CI today: be honest. "We treat Postman as the source of truth for the
standard. The CI step runs the equivalent Spectral expression of those
rules; the next iteration of this operating model uses Postman's API to
pull governance rules into CI directly so there's literally one definition
running everywhere." Confident, true, points to where the platform is
going rather than the day-one wiring detail.
