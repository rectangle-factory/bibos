"use strict";
const { XMLParser, XMLValidator } = require("fast-xml-parser");

const tokenUri = process.argv[3];

var fs = require("fs");
var file = fs.readFileSync("./output/render.svg", "utf8");

const parser = new XMLParser();
// const validator = new XMLValidator();
const validated = XMLValidator.validate(file);
console.log(validated);
const parsed = parser.parse(file);
console.log(parsed);
