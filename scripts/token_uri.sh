#!/usr/bin/env bash


token_uri_script="./src/scripts/token_uri.sol"
forge run $token_uri_script 1> /dev/null
token_uri=$(cat ./output/token_uri.base64)

echo $token_uri