import SyntaxHighlighter from "react-syntax-highlighter";
import formatSVG from "xml-formatter";
import syntaxStyle from "react-syntax-highlighter/dist/cjs/styles/hljs/atelier-lakeside-dark";

type trait = {
  trait_type: string;
  value: string;
};

export const TraitsPanel = ({tokenId, attributes}: {tokenId: number; attributes: trait[]}) => {
  const Launching = () => <>Bibos</>;
  const BibosLabel = (tokenId) => `Bibos #${tokenId}`;

  return (
    <div className="panel rarity-panel">
      <span className="bibosNumber">{tokenId == -1 ? Launching() : BibosLabel(tokenId)}</span>
      <span />

      {attributes.map(({trait_type, value}) => (
        <span key={trait_type}>
          {trait_type}: {value}
        </span>
      ))}
    </div>
  );
};

export const SVGPanel = ({svg}: {svg: string}) => {
  return (
    <div className="panel svg-panel">
      <SyntaxHighlighter
        style={syntaxStyle}
        customStyle={{margin: "0", overflowX: "hidden", width: "max-content"}}
        language="xml"
      >
        {svg.length > 0 && formatSVG(svg)}
      </SyntaxHighlighter>
    </div>
  );
};
