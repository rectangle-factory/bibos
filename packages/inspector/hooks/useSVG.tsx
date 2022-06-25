import { useState, useEffect } from "react";
import babelParser from 'prettier/parser-babel'
import prettier from 'prettier/standalone'

function formatSVG(code: string) {
  return prettier.format(code, { parser: 'babel', plugins: [babelParser] })
}


export const useSvg = (svg: string) => {
  const [formatted, setFormatted] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    try {
      setFormatted(formatSVG(svg));
    } catch (e) {
      setError(e.message);
    }
  }, [svg]);

  return { formatted, error };
};
