#!/bin/bash

# anvil rpc
RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/_gg7wSSi0KMBsdKnGVfHDueq6xMB9EkC
# // anvil account 9
PRIVATE_KEY=0x3992f6bfb796e40beb6814fdb5b87b94000dd0bcc40d44652337f517f5257847
PUBLIC_KEY=0x8fA3ce35E7c74de9b76230D95E1DE6EC4c165824
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


# # deploy bibos and store the script output
# SCRIPT_OUTPUT="$(forge script --private-key $PRIVATE_KEY --rpc-url $RPC_URL --broadcast src/scripts/deploy_bibos.sol:deploy_bibos)"

# # extract the bibos address return value from SCRIPT_OUTPUT
# BIBOS_ADDRESS="$(get_forge_script_return_value address bibos "$SCRIPT_OUTPUT")"

# # erase deployments.json
# echo "{}" > $DEPLOYMENTS_PATH

# # save the bibos address in deployments.json
# write_deployment_address "Bibos" $BIBOS_ADDRESS

# forge script --private-key $PRIVATE_KEY --rpc-url $RPC_URL --broadcast src/scripts/deploy_bibos.sol:deploy_bibos

# cast send --private-key $PRIVATE_KEY --rpc-url $RPC_URL 0x0Fa224f8F90be835f4C1Eb4cE2f2035bA31Cc8aC "mint()"
# forge verify-contract --chain-id 4 --compiler-version "0.8.13+commit.abaa5c0e" "0x0Fa224f8F90be835f4C1Eb4cE2f2035bA31Cc8aC" src/Bibos.sol:Bibos "WGRBABVVTP7CX4R3VAVFDSN7FZY27CQJPI"

# forge verify-check --chain-id 4 "kjz4mnzrkkatttdrqsa3brabb4jwmfbdaxta5mfppvzmhxnk9j" "WGRBABVVTP7CX4R3VAVFDSN7FZY27CQJPI"

# forge verify-contract --chain-id 4 --compiler-version "0.8.13+commit.abaa5c0e" "0x2a6b74cb76a64C055C97bC7285a5E654ec87584C" "src/libraries/Points.sol:Points" "WGRBABVVTP7CX4R3VAVFDSN7FZY27CQJPI"
forge verify-check --chain-id 4 "beqh2iw9syjkgd6cjabm1ecmyudfzun3nrzhhslndinapdkfqt" "WGRBABVVTP7CX4R3VAVFDSN7FZY27CQJPI"
