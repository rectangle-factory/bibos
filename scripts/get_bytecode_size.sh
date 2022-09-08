#!/bin/bash


# set env var RPC_URL using `source .env`

# $1 is the name of the contract
CREATE_OUTPUT=$(forge create --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 $1 --json)
DEPLOYED_TO=$(echo $CREATE_OUTPUT | jq -r '.deployedTo')

forge script src/scripts/bytecode_size.sol --silent --rpc-url $RPC_URL -s "get_bytecode_size(address)" $DEPLOYED_TO --json 

