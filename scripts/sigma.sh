#!/usr/bin/env bash
# Round-trip a Sigma data model spec through the REST API.
#   scripts/sigma.sh post     <spec-file>
#   scripts/sigma.sh put      <dataModelId> <spec-file>
#   scripts/sigma.sh get-spec <dataModelId>
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
set -a; source "$root/.env"; set +a

token=$(curl -sS -X POST "$SIGMA_BASE_URL/v2/auth/token" \
  -d grant_type=client_credentials \
  -d client_id="$SIGMA_CLIENT_ID" \
  -d client_secret="$SIGMA_CLIENT_SECRET" | jq -r .access_token)

call() { curl -sS -H "Authorization: Bearer $token" -H "Accept: application/json" "$@"; }

case "${1:-}" in
  post)     call -X POST -H "Content-Type: application/json" --data-binary "@${2:?spec file}" "$SIGMA_BASE_URL/v2/dataModels/spec" ;;
  put)      call -X PUT  -H "Content-Type: application/json" --data-binary "@${3:?spec file}" "$SIGMA_BASE_URL/v2/dataModels/${2:?dataModelId}/spec" ;;
  get-spec) call "$SIGMA_BASE_URL/v2/dataModels/${2:?dataModelId}/spec" ;;
  *) echo "usage: sigma.sh post <spec> | put <id> <spec> | get-spec <id>" >&2; exit 2 ;;
esac
