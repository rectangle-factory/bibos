import { useState, useEffect } from "react";
// import babelParser from 'prettier/parser-babel'
import htmlParser from "prettier/parser-html";
import prettier from "prettier/standalone";

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
        setFormattedSvg(formatSVG(svg));
      }
    } catch (e) {
      setError(e.message);
    }
  }, [svg]);

  return { formattedSvg, error };
};
