# FCMA Demo — Complete Asset Inventory

Everything that was created for the two FCMA async Loom videos, where it lives,
and the state it was verified in. Built 2026-06-11.

---

## 1. GitHub repository

**Repo:** https://github.com/anothererikjames/fcma-postman-enterprise-demo (public, 40+ files)

### Branches (the Video 1 demo arc)

| Branch | `apis/customer-truth-center/openapi.yaml` | API Governance result |
|---|---|---|
| `main` | compliant spec (neutral base) | ✅ success (staged run in Actions tab) |
| `feature/global-customer-id` | proposed spec with 5 deliberate violations | ❌ failure (staged run) |
| `fix/fcma-api-standards` | compliant spec (the "fix") | ✅ success (staged run) |

Staged runs already exist in the Actions tab — the red/green split is ready to
show on camera. Failing run: actions/runs/27372396161.

### Repo contents

- `apis/customer-truth-center/` — three OpenAPI 3.0.3 specs:
  - `openapi-compliant.yaml` (v1.0.0) — passes all governance rules
  - `openapi-proposed-global-customer-id.yaml` (v1.1.0-proposed) — the
    customerId→globalCustomerId proposal with 5 deliberate violations
  - `openapi.yaml` — the branch-swapped active spec (see table above)
- `apis/partner-online-banking/openapi.yaml` — sanitized third-party API
  (OAuth token, balances, loan summary, payment quote, eligibility)
- `governance/fcma-api-standards.spectral.yaml` — 8 Spectral rules
  (descriptions, X-Correlation-Id, 401/403, StandardError, path-param +
  schema-property casing, response examples, pagination on list endpoints)
- `governance/examples/` + `ci/sample-output/` — staged pass/fail/CI logs
- `postman/collections/` — both collections (also imported to the workspace)
- `postman/environments/` — all three environments (also imported)
- `mocks/partner-online-banking/examples/` — 6 example payloads + notes
- `ci/scripts/` — `lint-openapi.sh`, `validate-contract.sh`,
  `generate-ci-log.sh` (all executable)
- `.github/workflows/` — three workflows (below)
- `.github/pull_request_template.md` + `CODEOWNERS` (demo placeholder teams)
- `recording/` — both video outlines, `demo-runbook.md`, `asset-checklist.md`

### Verified npm behavior

- `npm run demo:fail` → exit 1, exactly **5 errors**, one per deliberate
  violation (401/403, correlation-id, description, StandardError, casing)
- `npm run demo:pass` → exit 0, zero errors, zero warnings
- Both collection JSONs and all YAML parse clean

### GitHub Actions

All three have `workflow_dispatch` (the "Run workflow" button — visible only
when signed in as `anothererikjames`), and run on `actions/checkout@v5` +
`actions/setup-node@v5` (Node 24-ready; deprecation warning resolved).

| Workflow | What it runs | Note |
|---|---|---|
| API Governance | `npm run lint:customer` against the branch's `openapi.yaml` | drives the red→green branch story |
| Contract Conformance | Newman contract collection | illustrative — fake endpoint unless a mock is attached |
| Mock Demo Smoke | Newman mock collection | works once env points at the live mock URL |

---

## 2. Postman workspace

**Workspace:** "FCMA Demo Sandbox"
**Team:** `erik-james-v12` (demo account `anothererikjames` — NOT the corporate
@postman.com account; switch accounts to see it)
**URL:** https://erik-james-v12.postman.co/workspace/5cd17cb0-0ac0-4e04-a3b2-15b3c71e1201

### Specs (Spec Hub)

| Spec | ID |
|---|---|
| Customer Truth Center API (compliant baseline) | `08fc0d74-53fd-4926-9eb0-d4fc33d5d83b` |
| Customer Truth Center API (proposed globalCustomerId — the failing proposal) | `b4667a0f-9c5f-46d8-8ee5-17addffed7aa` |
| Partner Online Banking API | `34f29a34-155e-4431-a5aa-c99be54ea392` |

### Collections (imported via API)

| Collection | UID |
|---|---|
| Customer Truth Center API - Contract Collection | `52238111-e914b9d9-2caa-462c-9c17-3f392a4f377b` |
| Partner Online Banking API - Mock Demo | `52238111-e9f6a149-3ae0-499e-abd2-018f1372c918` |

### Environments (imported via API)

| Environment | Note |
|---|---|
| FCMA Contract Dev | baseUrl = api.fcma-demo.local (illustrative) |
| Local Dev - Partner Mock | **baseUrl already set to the live mock URL** |
| Partner Sandbox | baseUrl = partner-sandbox.example.com |

### Mock server (live)

- **Name:** Partner Online Banking Mock
- **URL:** `https://4fb965ab-6114-40e6-bcce-0194ae7e8212.mock.pstmn.io`
- Verified live: `GET /loans/loan_12345/summary` and `POST /oauth/token` answer.

**Recording tip:** the loan-summary route has multiple saved 200 examples and
the mock serves the *malformed* one by default. Select examples
deterministically with the `x-mock-response-name` header:

```
x-mock-response-name: loan-summary-200          → happy path
x-mock-response-name: partner-unavailable-503   → partner outage
x-mock-response-name: auth-failure-401          → auth failure
x-mock-response-name: payment-quote-business-failure-422
x-mock-response-name: malformed-loan-summary-200
```

That header IS a demo beat for Video 2: "force any partner failure mode on demand."

---

## 3. Known notes / deviations from the original brief

1. `main` holds the **compliant** spec (brief's section C said the failing copy
   is the default; the branch plan won — better demo flow). The failing copy
   with verbatim comments lives on `feature/global-customer-id`.
2. The staged fail log says "4 violations"; live linting finds **5** (the log
   predates the casing rule and was kept verbatim per the brief). Regenerate
   with `ci/scripts/generate-ci-log.sh` if you want them to match.
3. Workspace was created via the demo-account API; it reports type "team" on
   team `erik-james-v12`. To host on the corporate team instead, recreate
   there and re-run the import steps (scripted, ~5 minutes) with a corporate
   API key.
4. One stray failed run on `main` exists in Actions history (pre-fix dispatch);
   deletable from the run's ⋯ menu if you want pristine history on camera.

---

## 4. Pre-recording checklist (everything else is done)

- [ ] Sign into Postman + GitHub as the demo account (`anothererikjames`)
- [ ] Optional: set the happy-path example as default on the loan-summary
      request (or use the `x-mock-response-name` header trick on camera)
- [ ] Optional: delete the stray failed `main` run from Actions history
- [ ] Follow `recording/video-1-governed-api-contracts-outline.md` and
      `recording/video-2-mock-servers-outline.md`
