import { useState, useEffect } from "react";

import formatSVG from "xml-formatter";

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

  useEffect(() => {
    console.log(formatted, error);
  }, [formatted, error]);

  return { formatted, error };
};
