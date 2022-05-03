#!/usr/bin/env bash
# Notice: run from root directory.

token_uri_script="src/scripts/get_token_uri.sol"

# run script, store output
script_output=$(forge run $token_uri_script)

# extract tokenUri from Logs
logs_prefix="== Logs =="
token_uri=${script_output##*$logs_prefix}

# return the token_uri to stdout
echo $token_uri