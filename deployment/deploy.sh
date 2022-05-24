RPC_URL=http://127.0.0.1:8545
# // account 9
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

get_libraries() {
    LIBRARIES=""
    for NAME in "$@"
    do
        ADDRESS=$(jq -r '.'$NAME'' $DEPLOYMENTS_PATH)
        LIBRARIES="$LIBRARIES --libraries src/libraries/$NAME.sol:$NAME:$ADDRESS"
    done
    echo $LIBRARIES
}



export ETH_RPC_URL=$RPC_URL
deploy_contract deploy ./src/scripts/deploy.sol $(get_libraries Eyes Mouth Cheeks)
deploy_contract Bibos "src/Bibos.sol" $(get_libraries Body Glints Face Eyes Mouth Cheeks)