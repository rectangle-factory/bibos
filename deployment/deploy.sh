#!/bin/bash

# anvil rpc
RPC_URL=http://127.0.0.1:8545
# // anvil account 9
PRIVATE_KEY=0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6
PUBLIC_KEY=0xa0ee7a142d267c1f36714e4a8f75612f20a79720

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

# # erase deployments.json
echo "{}" > $DEPLOYMENTS_PATH

# # save the bibos address in deployments.json
write_deployment_address "Bibos" $BIBOS_ADDRESS

echo "$SCRIPT_OUTPUT"