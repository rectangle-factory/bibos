import { useState, useEffect } from "react";
// import babelParser from 'prettier/parser-babel'
import htmlParser from 'prettier/parser-html'

import prettier from 'prettier/standalone'

const options = {
  parser: 'html', 
  plugins: [htmlParser],
  tabWidth: 2,
  semi: false,
  singleQuote: false
}

function formatSVG(code: string) {
  return prettier.format(code, options)
}


export const useSvg = (svg: string) => {
  const [formatted, setFormatted] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    try {
      if (svg === null) {
        setFormatted("");
      } else {
        setFormatted(formatSVG(svg));
      }
    } catch (e) {
      setError(e.message);
    }
  }, [svg]);

  return { formatted, error };
};
