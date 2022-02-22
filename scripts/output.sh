# first arg is tokenUri, base64 encoded
token_uri=$1

# remove header
encoded_metadata=$(echo $token_uri | cut -d "," -f 2)

# decode base64 into json text
decoded_metadata=$(echo $encoded_metadata | base64 -d)
echo $decoded_metadata > output/metadata.json

# json metadata
# pipe to jq, get the image subfield, trim off quotes
image_data=$(echo $decoded_metadata | jq '. | .image' | tr -d '"')

# replace img src in index.html
# update <img/> tag
# write to temporary buffer
awk -v var="<img src=\"$image_data\"/>" '{ gsub(/<img.*\>/,var,$0); print $0}' output/template.html > output/index.html

# decode the image and save to svg
# first remove the header text
raw_svg=$(echo $image_data | cut -d "," -f 2 | base64 -d)
echo $raw_svg > output/render.svg

# return bytes for ffi
printf 0x00