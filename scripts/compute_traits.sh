#!/usr/bin/env bash

BIBOS_TOTAL_SUPPLY=1111
PAGE=0
PAGE_COUNT=12
PAGE_LENGTH=100
TRAITS_PATH='./data/traits.json'
ALL_TRAITS='[]'

get_traits() {
    forge script -s "run(uint256,uint256)" src/scripts/compute_traits.sol $1 $2 --json | grep "{" | jq '.logs[0]' | jq . -r 
}

while [ $PAGE -lt $PAGE_COUNT ]
do
  START=$(( PAGE * PAGE_LENGTH))
  END=$(((PAGE + 1) * PAGE_LENGTH ))
  TRAITS=$(get_traits $START $END )
  ALL_TRAITS=$(echo $ALL_TRAITS | jq ". + $TRAITS")
  echo "COMPUTE BIBOS $START $END"
  PAGE=$(( $PAGE + 1 ))
done

echo $ALL_TRAITS > $TRAITS_PATH
