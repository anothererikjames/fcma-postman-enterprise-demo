# Demo Runbook

Step-by-step prep and execution for both recordings.

## Commands

```bash
npm install            # one-time: installs spectral + the Postman CLI
npm run demo:fail      # lints the proposed globalCustomerId spec — FAILS with 5 readable violations
npm run demo:pass      # lints the compliant spec — passes clean
npm run contract:smoke # the Postman CLI run of the contract collection (demo endpoint; not live unless pointed at a mock/local server)
npm run mock:smoke     # the Postman CLI run of the partner mock collection (replace the placeholder mock URL first)
```

## Postman setup

1. Import both collections from `postman/collections/`:
   - Customer Truth Center API - Contract Collection
   - Partner Online Banking API - Mock Demo
2. Import all environments from `postman/environments/`:
   - FCMA Contract Dev, Local Dev - Partner Mock, Partner Sandbox
3. Create a **mock server** from the Partner Online Banking collection.
4. Copy the generated mock URL.
5. Replace `baseUrl` in **Local Dev - Partner Mock**
   (placeholder `https://mock-server-url.example.com`) with the mock URL.
6. Select the **Local Dev - Partner Mock** environment.
7. Run the mock collection — happy path first, then the edge-case examples.

## GitHub setup

1. Create the repo `fcma-postman-enterprise-demo` and push all branches.
2. Open the **Actions** tab.
3. Run **API Governance** manually (workflow_dispatch) to show the check.
4. Optional: open the compliant-spec branch (`fix/fcma-api-standards`) to
   show the passing run.
5. If the fake URLs prevent full execution of the Postman CLI workflows, use the
   workflow files themselves as the visual proof point — the message is the
   pre-merge step inside existing CI/CD, not the demo endpoints.

## Branch demo path

1. Start on `feature/global-customer-id` — show the `openapi.yaml` diff
   (`customerId` → `globalCustomerId`).
2. Run `npm run demo:fail` — walk the five violations.
3. Switch to `fix/fcma-api-standards`.
4. Run `npm run demo:pass` — clean check, change is promotable.
