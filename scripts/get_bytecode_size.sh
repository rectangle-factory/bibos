#!/bin/bash

# anvil rpc
RPC_URL=http://127.0.0.1:8545
# // anvil account 9
PRIVATE_KEY=0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6
PUBLIC_KEY=0xa0ee7a142d267c1f36714e4a8f75612f20a79720

# $1 is the name of the contract
CREATE_OUTPUT=$(forge create --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 $1 --json)
DEPLOYED_TO=$(echo $CREATE_OUTPUT | jq -r '.deployedTo')


forge script src/scripts/bytecode_size.sol --silent --rpc-url $RPC_URL -s "get_bytecode_size(address)" $DEPLOYED_TO --json 

