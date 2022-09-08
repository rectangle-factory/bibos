#!/bin/bash

# deploy bibos
# set env vars RPC_URL and PRIVATE_KEY using `source .env`

DEPLOYMENTS_PATH=./deployment/deployments.json

write_deployment_address() {
    echo $(jq '.'$1'="'$2'"' $DEPLOYMENTS_PATH) > $DEPLOYMENTS_PATH
}

get_return_value() {
    echo "$2" | grep "{" | jq -r '.returns.'$1'.value'
}

# deploy bibos
SCRIPT_OUTPUT="$(forge script --private-key $PRIVATE_KEY --rpc-url $RPC_URL --broadcast --json src/scripts/deploy_bibos.sol:deploy_bibos)"
BIBOS_ADDRESS="$(get_return_value "bibos" "$SCRIPT_OUTPUT")"

# save the bibos address in deployments.json
write_deployment_address "Bibos" $BIBOS_ADDRESS

echo "$SCRIPT_OUTPUT"