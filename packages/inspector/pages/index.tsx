import { useState, useEffect } from "react";
import { decodeBase64 } from "../util";

import { Dots } from "../components/Dots";

enum Status {
  UNFETCHED,
  FETCHING,
  FETCHED,
  ERROR,
}

type trait = {
  trait_type: string;
  value: string;
};

const TraitsPanel = ({ tokenId, attributes }: { tokenId: number; attributes: trait[] }) => {
  const Launching = () => <>Bibos</>;
  const BibosLabel = (tokenId) => `Bibos #${tokenId}`;

  return (
    <div className="panel">
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
const Main = () => {
  const [tokenURI, setTokenURI] = useState("");
  const [metadata, setMetadata] = useState({ image: "", attributes: [] });
  const [tokenId, setTokenId] = useState(-1);
  const [status, setStatus] = useState(Status.UNFETCHED);

  const handleFetchTokenURI = async () => {
    if (status == Status.FETCHING) return;
    setStatus(Status.FETCHING);
    const response = await fetch("http://localhost:3001");
    const text = await response.text();

    setTokenURI(text);
  };

  const handleComputeTokenId = () => {
    if (status == Status.UNFETCHED) return setTokenId(-1);
    setTokenId(Math.floor(Math.random() * 999));
  };

  useEffect(() => {
    handleFetchTokenURI();
    handleComputeTokenId();
  }, []);

  useEffect(() => {
    if (tokenURI.length == 0) return;

    const metadata = JSON.parse(decodeBase64(tokenURI));
    setMetadata(metadata);
    handleComputeTokenId();
    setStatus(Status.FETCHED);
  }, [tokenURI]);

  return (
    <>
      <section className="content">
        <div className="svg-holder">
          <img src={metadata.image} />
        </div>
        <TraitsPanel tokenId={tokenId} attributes={metadata.attributes} />
      </section>
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
      <span className="copyright">© BibosCorp Research Group, 2022</span>
    </>
  );
};

export default Main;
