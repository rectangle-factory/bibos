#!/usr/bin/env bash

# unix time in seconds, uint256 hex format
# `echo -n` to remove new line

echo -n $( cast --to-uint256 $( date +"%s" ))