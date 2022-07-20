#!/usr/bin/env bash
# Notice: run from root directory.

extract_json_output() {
    echo "$1" | grep "{" 
}

# LOCAL_RENDER_SCRIPT_PATH="src/scripts/local_render.sol"
SCRIPT_OUTPUT="$(forge script local_render --json -s "run(uint256)" $1)"
JSON_OUTPUT="$(extract_json_output "$SCRIPT_OUTPUT")"


echo "$JSON_OUTPUT" | jq .returns.tokenURIs.value