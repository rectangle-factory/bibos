RPC_URL=http://127.0.0.1:8545
PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
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
    OUTPUT=$(forge create --json --rpc-url $RPC_URL \
        --private-key $PRIVATE_KEY ${@:3} $CONTRACT_PATH:$CONTRACT_NAME)
    ADDRESS=$(echo $OUTPUT | jq -r '.deployedTo')
    # echo $OUTPUT | jq '.'
    # echo $(jq '.'$CONTRACT_NAME'="'$ADDRESS'"' $DEPLOYMENTS_PATH) > $DEPLOYMENTS_PATH
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


deploy_contract deploy ./src/scripts/deploy.sol $(get_libraries Eyes Mouth Cheeks)
deploy_contract Bibos "src/Bibos.sol" $(get_libraries Body Glints Face Eyes Mouth Cheeks)