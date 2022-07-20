#!/usr/bin/env bash
# Notice: run from root directory.



extract_json_output() {
    echo "$1" | grep "{" 
}



SCRIPT_OUTPUT="$(forge script local_render --json)"
JSON_OUTPUT="$(extract_json_output "$SCRIPT_OUTPUT")"

# return tokenURI
echo "$JSON_OUTPUT" | jq .returns.tokenURI.value