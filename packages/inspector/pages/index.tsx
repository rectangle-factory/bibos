import { useState, useEffect } from "react";
import { decodeBase64 } from "../util";
import syntaxStyle from "react-syntax-highlighter/dist/cjs/styles/hljs/atelier-lakeside-dark";
import { Dots } from "../components/Dots";
import format from "xml-formatter";
import SyntaxHighlighter from "react-syntax-highlighter";
enum Status {
  UNFETCHED,
  FETCHING,
  FETCHED,
  ERROR,
}

enum View {
  IMAGE,
  SVG,
}

type trait = {
  trait_type: string;
  value: string;
};

const TraitsPanel = ({ tokenId, attributes }: { tokenId: number; attributes: trait[] }) => {
  const Launching = () => <>Bibos</>;
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

const SVGPanel = ({ svg }: { svg: string }) => {
  return (
    <div className="panel svg-panel">
      <SyntaxHighlighter
        style={syntaxStyle}
        customStyle={{ margin: "0", overflowX: "hidden", width: "max-content" }}
        language="xml"
      >
        {svg}
      </SyntaxHighlighter>
    </div>
  );
};
const Main = () => {
  const [view, setView] = useState(View.IMAGE);
  const [tokenURI, setTokenURI] = useState("");
  const [metadata, setMetadata] = useState({ image: "", attributes: [] });
  const [tokenId, setTokenId] = useState(-1);
  const [status, setStatus] = useState(Status.UNFETCHED);
  const [rawSVG, setRawSVG] = useState("");

  const handleFetchTokenURI = async () => {
    if (status == Status.FETCHING) return;
    setStatus(Status.FETCHING);
    const response = await fetch("http://localhost:3001");
    const text = await response.text();
    setTokenURI(text);
    setMetadata(JSON.parse(decodeBase64(text)));
  };

  const handleComputeTokenId = () => {
    if (status == Status.UNFETCHED) return setTokenId(-1);
    setTokenId(Math.floor(Math.random() * 999));
  };

  const handleDecodeSVG = () => {
    if (status == Status.UNFETCHED) return;
    const rawSVG = decodeBase64(metadata.image);

    setRawSVG(format(rawSVG));
  };

  const handleToggleView = () => {
    setView((view) => (view == View.IMAGE ? View.SVG : View.IMAGE));
  };

  useEffect(() => {
    handleFetchTokenURI();
  }, []);

  useEffect(() => {
    if (metadata.image.length == 0) return;

    handleComputeTokenId();
    handleDecodeSVG();
    setStatus(Status.FETCHED);
  }, [metadata]);

  return (
    <>
      {view == View.IMAGE ? (
        <section className="content">
          <div className="svg-holder">
            <img src={metadata.image} />
          </div>
          <TraitsPanel tokenId={tokenId} attributes={metadata.attributes} />
        </section>
      ) : (
        <section className="content">
          <SVGPanel svg={rawSVG} />
        </section>
      )}
      <div className="button-panel">
        <button disabled={status == Status.FETCHING ? true : false} onClick={handleFetchTokenURI}>
          {status == Status.FETCHING ? (
            <span className="rendering">
              rendering
              <Dots />
            </span>
          ) : (
            "render"
          )}
        </button>
        <button onClick={handleToggleView}>{view == View.IMAGE ? "SVG" : "image"}</button>
      </div>
      <span className="copyright">© BibosCorp Research Group, 2022</span>
    </>
  );
};

export default Main;
