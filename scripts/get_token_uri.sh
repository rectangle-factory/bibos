#!/usr/bin/env bash
# Notice: run from root directory.

DEPLOYMENTS_PATH=./deployment/deployments.json

get_libraries() {
    LIBRARIES=""
    for NAME in "$@"
    do
        ADDRESS=$(jq -r '.'$NAME'' $DEPLOYMENTS_PATH)
        LIBRARIES="$LIBRARIES --libraries src/libraries/$NAME.sol:$NAME:$ADDRESS"
    done
    echo $LIBRARIES
}

token_uri_script="src/scripts/get_token_uri.sol"
script_output=$(forge run $token_uri_script $(get_libraries Eyes Mouth Cheeks Face Body Glints))

# # extract tokenUri from Logs
logs_prefix="== Logs =="
token_uri=${script_output##*$logs_prefix}

# # return the token_uri
echo $token_uri