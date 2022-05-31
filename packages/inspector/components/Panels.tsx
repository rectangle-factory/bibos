import { trait } from "../types";
import { useSvg } from "../hooks/useSVG";

import SyntaxHighlighter from "react-syntax-highlighter";
import syntaxStyle from "react-syntax-highlighter/dist/cjs/styles/hljs/atelier-lakeside-dark";

export const TraitsPanel = ({
  name,
  loading,
  tokenId,
  attributes,
}: {
  name: string;
  loading: boolean;
  tokenId: number;
  attributes: trait[];
}) => {
  const Loading = () => "loading";
  return (
    <div className="panel traits-panel">
      <span className="bibosNumber">{name}</span>
      <span />

      {attributes.map(({ trait_type, value }) => (
        <span key={trait_type}>
          {trait_type}: {value}
        </span>
      ))}
    </div>
  );
};

export const ImagePanel = ({ src }: { src: string }) => (
  <div className="image-panel panel">
    <div className="frame">
      <img src={src} />
    </div>
  </div>
);

export const SVGPanel = ({ svg }: { svg: string }) => {
  const { formatted, error } = useSvg(svg);
  return (
    <div className="panel svg-panel">
      {error.length == 0 ? (
        <SyntaxHighlighter
          style={syntaxStyle}
          customStyle={{ margin: "0", overflowX: "hidden", width: "max-content" }}
          language="xml"
        >
          {formatted}
        </SyntaxHighlighter>
      ) : (
        `Error parsing SVG: ${error}`
      )}
    </div>
  );
};
