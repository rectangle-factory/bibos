"use strict";
const { XMLValidator } = require("fast-xml-parser");

const decodeBase64 = (encodedMetadata) =>
  Buffer.from(stripMimeType(encodedMetadata), "base64").toString("ascii");

const stripMimeType = (encoding) => encoding.slice(encoding.indexOf(",") + 1);

const tokenUri = process.argv[2];
const metadata = JSON.parse(decodeBase64(tokenUri));
const svg = decodeBase64(metadata.image);
const validated = XMLValidator.validate(svg);

// return 1 if invalid
if (validated !== true) {
  console.log(1);
}

// else return 0
console.log(0);
