#!/usr/bin/env bash
# Regenerates the staged CI sample-output logs used in the recording.
# These logs are illustrative artifacts for the Loom videos; the live
# equivalents are produced by lint-openapi.sh and validate-contract.sh.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT_DIR="${REPO_ROOT}/ci/sample-output"
mkdir -p "${OUT_DIR}"

cat > "${OUT_DIR}/fcma-api-governance-check.log" <<'EOF'
FCMA API Standards Check
API: Customer Truth Center API
Branch: feature/global-customer-id
FAILED
Rule: secured-endpoints-require-401-403
File: apis/customer-truth-center/openapi-proposed-global-customer-id.yaml
Path: GET /customers/{globalCustomerId}
Issue: Missing 403 response
Rule: standard-error-schema-required
File: apis/customer-truth-center/openapi-proposed-global-customer-id.yaml
Path: POST /customers/search
Issue: Error response does not reference StandardError
Rule: correlation-id-required
File: apis/customer-truth-center/openapi-proposed-global-customer-id.yaml
Path: GET /customers/{globalCustomerId}/loans
Issue: Missing X-Correlation-Id header
Rule: operation-description-required
File: apis/customer-truth-center/openapi-proposed-global-customer-id.yaml
Path: GET /customers/{globalCustomerId}/relationships
Issue: Operation has summary but no description
Result: 4 violations found. Build blocked before promotion.
EOF

cat > "${OUT_DIR}/fcma-contract-conformance-check.log" <<'EOF'
FCMA Contract Conformance Check
API: Customer Truth Center API
Environment: dev
Collection: Customer Truth Center API - Contract Collection
PASSED WITH WARNINGS
Requests evaluated:
- Get Customer
- Get Customer Loans
- Get Customer Relationships
- Search Customers
Warnings:
- Demo endpoint is not a live FCMA service.
- This output is staged for recording purposes.
Result: Contract smoke check completed.
EOF

cat > "${OUT_DIR}/mock-server-local-dev-output.log" <<'EOF'
Local integration service
PARTNER_API_BASE_URL=https://mock-server-url.example.com
Calling GET /loans/loan_12345/summary...
Response: 200 ACTIVE
Calling POST /loan-payments/quote...
Response: 503 PARTNER_UNAVAILABLE
Retry logic triggered.
Calling GET /customers/cust_demo_1001/eligibility...
Response: 422 PAYMENT_QUOTE_NOT_AVAILABLE
Result: Mock server supports happy path and edge-case testing without partner dependency.
EOF

echo "Regenerated:"
echo "  ${OUT_DIR}/fcma-api-governance-check.log"
echo "  ${OUT_DIR}/fcma-contract-conformance-check.log"
echo "  ${OUT_DIR}/mock-server-local-dev-output.log"
