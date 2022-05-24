RPC_URL=http://127.0.0.1:8545
PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
DEPLOYMENTS_PATH=./deployment/deployments.json

deploy_library() {
    LIBRARY_NAME=$1
    OUTPUT=$(forge create --json --rpc-url $RPC_URL \
        --private-key $PRIVATE_KEY ${@:2} src/libraries/$LIBRARY_NAME.sol:$LIBRARY_NAME)
    ADDRESS=$(echo $OUTPUT | jq -r '.deployedTo')
    echo $(jq '.'$LIBRARY_NAME'="'$ADDRESS'"' $DEPLOYMENTS_PATH) > $DEPLOYMENTS_PATH
}

deploy_contract() {
    CONTRACT_NAME=$1
    CONTRACT_PATH=$2
    OUTPUT=$(forge create --json --rpc-url $RPC_URL \
        --private-key $PRIVATE_KEY ${@:3} $CONTRACT_PATH:$CONTRACT_NAME)
    ADDRESS=$(echo $OUTPUT | jq -r '.deployedTo')
    echo $(jq '.'$CONTRACT_NAME'="'$ADDRESS'"' $DEPLOYMENTS_PATH) > $DEPLOYMENTS_PATH
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



echo "{}" > $DEPLOYMENTS_PATH
deploy_library SVG
echo "deployed SVG"
deploy_library Eyes
echo "deployed Eyes"
deploy_library Mouth
echo "deployed Mouth"
deploy_library Cheeks
echo "deployed Cheeks"
deploy_library Face "$(get_libraries Eyes Mouth Cheeks)"
echo "deployed Face"
deploy_library Body
echo "deployed Body"
deploy_library Glints
echo "deployed Glints"

deploy_contract Bibos "src/Bibos.sol" $(get_libraries Body Glints Face Eyes Mouth Cheeks)
echo "deployed Bibos"