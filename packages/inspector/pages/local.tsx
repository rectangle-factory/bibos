import { useState } from "react";

import { NFTStatus, IndexView } from "../types";
import { SVGPanel, TraitsPanel, ImagePanel } from "../components/Panels";
import { MintButton, ViewButton } from "../components/Buttons";
import { useLocalRPC } from "../hooks/useLocalRPC";
import { useNFT } from "../hooks/useNFT";

const BibosInspectorIndex = () => {
  const [view, setView] = useState(IndexView.IMAGE);
  const { tokenURI, status, handleFetchNFT } = useLocalRPC();
  const { metadata, tokenId, rawSVG } = useNFT(tokenURI);

  const handleToggleView = () =>
    setView((view) => (view == IndexView.IMAGE ? IndexView.SVG : IndexView.IMAGE));

  return (
    <>
      {view == IndexView.IMAGE ? (
        <section className="content">
          <ImagePanel src={metadata.image} />
          <TraitsPanel tokenId={tokenId} attributes={metadata.attributes} />
        </section>
      ) : (
        <section className="content">
          <SVGPanel svg={rawSVG} />
        </section>
      )}
      <div className="button-panel">
        <ViewButton view={view} handleClick={handleToggleView} />
        <MintButton fetching={status == NFTStatus.FETCHING} handleClick={handleFetchNFT} />
      </div>
      <span className="copyright">© BibosCorp Research Group, 2022</span>
    </>
  );
};

export default BibosInspectorIndex;
