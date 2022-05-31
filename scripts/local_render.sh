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

extract_token_URI() {
    echo "$1" | grep "tokenURI: string" | cut -d " " -f 3 | tr -d '"'
}

LOCAL_RENDER_SCRIPT_PATH="src/scripts/local_render.sol"
SCRIPT_OUTPUT="$(forge script $LOCAL_RENDER_SCRIPT_PATH:local_render)"
# extract the bibos address return value from SCRIPT_OUTPUT
TOKEN_URI="$(extract_token_URI "$SCRIPT_OUTPUT")"

# return tokenURI
echo "$TOKEN_URI"