#!/bin/bash

# anvil rpc
RPC_URL=http://127.0.0.1:8545
# // anvil account 9
PRIVATE_KEY=0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6
PUBLIC_KEY=0xa0ee7a142d267c1f36714e4a8f75612f20a79720

balance_before=$(cast balance $PUBLIC_KEY)
forge create --private-key $PRIVATE_KEY src/libraries/Points.sol:Points
balance_after=$(cast balance $PUBLIC_KEY)

echo "Points1:"
echo "($balance_before - $balance_after) / 10^18" | bc -l

balance_before=$(cast balance $PUBLIC_KEY)
forge create --private-key $PRIVATE_KEY src/libraries/Points3.sol:Points3
balance_after=$(cast balance $PUBLIC_KEY)

echo "Points3:"
echo "($balance_before - $balance_after) / 10^18" | bc -l