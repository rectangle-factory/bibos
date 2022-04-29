import { trait } from "../types";
import { useSvg } from "../hooks/useSvg";

import SyntaxHighlighter from "react-syntax-highlighter";
import syntaxStyle from "react-syntax-highlighter/dist/cjs/styles/hljs/atelier-lakeside-dark";

export const TraitsPanel = ({ tokenId, attributes }: { tokenId: number; attributes: trait[] }) => {
  const Launching = () => "Bibos";
  const BibosLabel = (tokenId) => `Bibos #${tokenId}`;

  return (
    <div className="panel rarity-panel">
      <span className="bibosNumber">{tokenId == -1 ? Launching() : BibosLabel(tokenId)}</span>
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
  <div className="image-panel">
    <img src={src} />
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
