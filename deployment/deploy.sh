RPC_URL=http://127.0.0.1:8545
PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
DEPLOYMENTS_PATH=./deployment/deployments.json

deploy_library() {
    NAME=$1
    OUTPUT=$(forge create --json --rpc-url $RPC_URL \
        --private-key $PRIVATE_KEY src/libraries/$NAME.sol:$NAME)
    ADDRESS=$(echo $OUTPUT | jq -r '.deployedTo')
    echo $(jq '.'$NAME'="'$ADDRESS'"' $DEPLOYMENTS_PATH) > $DEPLOYMENTS_PATH
}

get_library() {
    NAME=$1
    ADDRESS=$(jq -r '.'$NAME'' $DEPLOYMENTS_PATH)
    echo "src/libraries/$NAME.sol:$NAME:$ADDRESS"
}

echo "{}" > $DEPLOYMENTS_PATH
deploy_library SVG
deploy_library Face
deploy_library Eyes
deploy_library Glints

# forge create --json \
#     --rpc-url $RPC_URL \
#     --private-key $PRIVATE_KEY \
#     --libraries \
#         $(get_library SVG) \
#     --libraries \
#         $(get_library Face) \
#     --libraries \
#         $(get_library Eyes) \
#     src/Bibos.sol:Bibos


