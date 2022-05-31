RPC_URL=http://127.0.0.1:8545
LIBRARY_FACTORY=0x700b6a60ce7eaaea56f065753d8dcb9653dbad35
DEPLOYER=0xa0ee7a142d267c1f36714e4a8f75612f20a79720
DEPLOYMENTS_PATH=./deployment/deployments.json

# cast compute-address

get_address() {
    LIBRARY_NAME=$1
    OUTPUT=$(cast call \
        --rpc-url $RPC_URL \
        $LIBRARY_FACTORY "addresses(string)" $LIBRARY_NAME)

    ADDRESS=$(cast --abi-decode "addresses(string)(address)" $OUTPUT)
    echo $(jq '.'$LIBRARY_NAME'="'$ADDRESS'"' $DEPLOYMENTS_PATH) > $DEPLOYMENTS_PATH
}

echo "{}" > $DEPLOYMENTS_PATH
get_address "Mouth"
get_address "Cheeks"
get_address "Eyes"
get_address "Face"
get_address "Body"
get_address "Glints"

COMPUTED_ADDRESS_OUTPUT=$(cast compute-address --nonce 1 $DEPLOYER)
BIBOS_ADDRESS=${COMPUTED_ADDRESS_OUTPUT:(-42)}
echo $(jq '.Bibos="'$BIBOS_ADDRESS'"' $DEPLOYMENTS_PATH) > $DEPLOYMENTS_PATH