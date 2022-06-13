#!/bin/bash

# anvil rpc
RPC_URL=http://127.0.0.1:8545
# // anvil account 9
PRIVATE_KEY=0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6
PUBLIC_KEY=0xa0ee7a142d267c1f36714e4a8f75612f20a79720

DEPLOYMENTS_PATH=./deployment/deployments.json

deploy_library() {
    LIBRARY_NAME=$1
    OUTPUT=$(forge create --json --rpc-url $RPC_URL \
        --private-key $PRIVATE_KEY ${@:2} src/libraries/$LIBRARY_NAME.sol:$LIBRARY_NAME)
    ADDRESS=$(echo $OUTPUT | jq -r '.deployedTo')
    # echo $(jq '.'$LIBRARY_NAME'="'$ADDRESS'"' $DEPLOYMENTS_PATH) > $DEPLOYMENTS_PATH
}

deploy_contract() {
    CONTRACT_NAME=$1
    CONTRACT_PATH=$2
    OUTPUT=$(forge create --json  \
        --private-key $PRIVATE_KEY ${@:3} $CONTRACT_PATH:$CONTRACT_NAME)
    ADDRESS=$(echo $OUTPUT | jq -r '.deployedTo')
    echo "$OUTPUT" | jq '.name="'$CONTRACT_NAME'"'
}

# external library args for forge create
get_libraries() {
    LIBRARIES=""
    for NAME in "$@"
    do
        ADDRESS=$(jq -r '.'$NAME'' $DEPLOYMENTS_PATH)
        LIBRARIES="$LIBRARIES --libraries src/libraries/$NAME.sol:$NAME:$ADDRESS"
    done
    echo $LIBRARIES
}

get_forge_script_return_value() {
    echo "$3" | grep "$2: $1" | cut -d " " -f 3
}

write_deployment_address() {
    echo $(jq '.'$1'="'$2'"' $DEPLOYMENTS_PATH) > $DEPLOYMENTS_PATH
}


# deploy bibos and store the script output
# SCRIPT_OUTPUT="$(forge script --private-key $PRIVATE_KEY --rpc-url $RPC_URL --broadcast src/scripts/deploy_bibos.sol:deploy_bibos)"
forge script --private-key $PRIVATE_KEY --rpc-url $RPC_URL --broadcast src/scripts/deploy_bibos.sol:deploy_bibos
# # extract the bibos address return value from SCRIPT_OUTPUT
# BIBOS_ADDRESS="$(get_forge_script_return_value address bibos "$SCRIPT_OUTPUT")"

# # erase deployments.json
# echo "{}" > $DEPLOYMENTS_PATH

# # save the bibos address in deployments.json
# write_deployment_address "Bibos" $BIBOS_ADDRESS