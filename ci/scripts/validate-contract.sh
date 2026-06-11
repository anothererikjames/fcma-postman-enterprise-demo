#!/usr/bin/env bash
# FCMA contract smoke check — runs a Postman collection via newman.
# Usage: ci/scripts/validate-contract.sh [COLLECTION] [ENVIRONMENT]
# Note: demo endpoints (api.fcma-demo.local) are not live; point the
# environment at a live or mocked service to execute for real.
set -euo pipefail

COLLECTION="${1:-postman/collections/customer-truth-center-contract.collection.json}"
ENVIRONMENT="${2:-postman/environments/fcma-contract-dev.environment.json}"

echo "FCMA Contract Smoke Check"
echo "Collection:  ${COLLECTION}"
echo "Environment: ${ENVIRONMENT}"
echo "------------------------------------------------------------"

npx newman run "${COLLECTION}" -e "${ENVIRONMENT}"
