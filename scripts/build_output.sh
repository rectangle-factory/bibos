#!/usr/bin/env bash

# run mint script, outputs token uri to output/token_uri.base64
forge run src/scripts/mint.sol 1> /dev/null
token_uri=$(cat output/token_uri.base64)

# remove header, cut at ","
encoded_metadata=$( | cut -d "," -f 2)

# decode base64 into ascii text, metadata is in json format
decoded_metadata=$(echo $encoded_metadata | base64 -d)
echo $decoded_metadata > output/metadata.json

# pipe to jq, get the image subfield, trim off quotes
image_data=$(echo $decoded_metadata | jq '. | .image' | tr -d '"')

# replace img src in index.html
# update <img/> tag
awk -v var="<img src=\"$image_data\"/>" '{ gsub(/<img.*\>/,var,$0); print $0}' output/template.html > output/index.html

# remove the header text, decode the svg from base64, and save to file 
raw_svg=$(echo $image_data | cut -d "," -f 2 | base64 -d)
echo $raw_svg > output/render.svg