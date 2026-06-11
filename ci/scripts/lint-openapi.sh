#!/usr/bin/env bash
# FCMA API standards check — lints an OpenAPI spec against the demo ruleset.
# Usage: ci/scripts/lint-openapi.sh [SPEC_PATH] [RULESET_PATH]
set -euo pipefail

SPEC_PATH="${1:-apis/customer-truth-center/openapi.yaml}"
RULESET_PATH="${2:-governance/fcma-api-standards.spectral.yaml}"

echo "FCMA API Standards Check"
echo "Spec:    ${SPEC_PATH}"
echo "Ruleset: ${RULESET_PATH}"
echo "------------------------------------------------------------"

npx spectral lint "${SPEC_PATH}" -r "${RULESET_PATH}"
