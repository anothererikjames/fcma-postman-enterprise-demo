#!/usr/bin/env bash
# Runs a Postman collection with the first-party Postman CLI when available
# (and logged in), falling back to Newman automatically — so the same script
# works on a presenter laptop (CLI, on-brand for the demo) and in CI with no
# Postman credentials. Force the fallback with RUNNER=newman.
set -euo pipefail

COLLECTION="${1:?usage: run-collection.sh <collection.json> <environment.json>}"
ENVIRONMENT="${2:?usage: run-collection.sh <collection.json> <environment.json>}"

if [ "${RUNNER:-auto}" != "newman" ] && command -v postman >/dev/null 2>&1; then
  echo "Runner: Postman CLI"
  echo
  if postman collection run "${COLLECTION}" -e "${ENVIRONMENT}"; then
    exit 0
  fi
  status=$?
  echo
  echo "Postman CLI run failed (exit ${status})."
  echo "If this is an authentication error: postman login --with-api-key \$POSTMAN_API_KEY"
  echo "Or force the no-login fallback: RUNNER=newman $0 $*"
  exit "${status}"
fi

echo "Runner: Newman (fallback — install/login the Postman CLI for the first-party runner)"
echo
npx newman run "${COLLECTION}" -e "${ENVIRONMENT}"
