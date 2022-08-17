#!/bin/bash

# anvil rpc
RPC_URL=http://127.0.0.1:8545
# // anvil account 9
PRIVATE_KEY=0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6
PUBLIC_KEY=0xa0ee7a142d267c1f36714e4a8f75612f20a79720


# forge script --private-key $PRIVATE_KEY --rpc-url $RPC_URL --broadcast --json src/scripts/deploy_bibos.sol:deploy_bibos
# cast send --private-key $PRIVATE_KEY --rpc-url $RPC_URL $BIBOS_ADDRESS "withdraw(address)" "$TO"
# cast send --private-key $PRIVATE_KEY --rpc-url $RPC_URL --value "0.1ether" $BIBOS_ADDRESS "mint()"