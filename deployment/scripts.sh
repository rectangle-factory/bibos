#!/bin/bash

# scripts to help interact with bibos

# forge script --private-key $PRIVATE_KEY --rpc-url $RPC_URL --broadcast --json src/scripts/deploy_bibos.sol:deploy_bibos
# cast send --private-key $PRIVATE_KEY --rpc-url $RPC_URL $BIBOS_ADDRESS "withdraw(address)" "$TO"
# cast send --private-key $PRIVATE_KEY --rpc-url $RPC_URL --value "0.1ether" $BIBOS_ADDRESS "mint()"