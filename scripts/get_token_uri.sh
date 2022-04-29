#!/usr/bin/env bash

# run from root-directory

token_uri_script="src/scripts/get_token_uri.sol"
script_output=$(forge run $token_uri_script)
# extract tokenUri from Logs
logs_prefix="== Logs =="
token_uri=${script_output##*$logs_prefix}
echo $token_uri