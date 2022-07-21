import { useState, useEffect } from "react";
import htmlParser from "prettier/parser-html";
import prettier from "prettier/standalone";
import { parse } from "svg-parser";
import { svgElementAttributes } from "svg-element-attributes";

const options = {
  parser: "html",
  plugins: [htmlParser],
  tabWidth: 2,
  semi: false,
  singleQuote: false,
  bracketSameLine: true,
};

function formatSVG(code: string) {
  return prettier.format(code, options);
}

export const useFormattedSvg = (svg: string) => {
  const [formattedSvg, setFormattedSvg] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    try {
      if (svg === null) {
        setFormattedSvg("");
      } else {
        const ast = parse(svg);

        validateTagsAndProperties(ast);

        const formatted = formatSVG(svg);
        setFormattedSvg(formatted);
      }
    } catch (e) {
      setError(e.message);
    }
  }, [svg]);

  return { formattedSvg, error };
};

// Overrides
svgElementAttributes.svg.push("xmlns", "xmlns:xlink");
svgElementAttributes.mpath.push("xlink:href");

const validTags = Object.keys(svgElementAttributes).filter((tag) => tag !== "*");

function validateTagsAndProperties(node) {
  if (node.children) {
    node.children.forEach((child) => {

      if (child.type === "element") {

        // Check tag names first
        if (validTags.includes(child.tagName) === false) {
          // somehow write a traceback that ascends the tree
          throw Error(`Invalid tag name: ${child.tagName}`);
        }

        // Check attributes
        const validPropertiesForThisTag = [
          ...svgElementAttributes[child.tagName],
          ...svgElementAttributes["*"],
        ];
        const invalidProperties = Object.keys(child.properties).filter(
          (attr) => validPropertiesForThisTag.includes(attr) === false
        );

        if (invalidProperties.length > 0) {
          throw Error(
            `Invalid attributes for tag ${child.tagName}: ${invalidProperties.join(", ")}`
          );
        }
      }
      validateTagsAndProperties(child);
    });
  }
}
