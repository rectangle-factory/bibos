#!/usr/bin/env bash

# first arg is raw tokenUri
validate_node_script_path="./scripts/validate.js"
output=$(node $validate_node_script_path $1)
# return uint256, 0 if succesful, positive integer if not
printf $(cast --to-uint256 $output)