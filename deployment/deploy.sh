RPC_URL=127.0.0.1:8545
forge create --rpc-url $RPC_URL \
    --constructor-args "ForgeUSD" "FUSD" 18 1000000000000000000000 \
    --private-key <your_private_key> src/Bibos.sol:Bibos