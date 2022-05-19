import { useState } from "react";

import { NFTStatus, IndexView } from "../types";
import { SVGPanel, TraitsPanel, ImagePanel } from "../components/Panels";
import { RenderButton, ViewButton } from "../components/Buttons";
import { useLocalNft } from "../hooks/useLocalNft";

const BibosInspectorIndex = () => {
  const [view, setView] = useState(IndexView.IMAGE);
  const { status, metadata, tokenId, rawSvg, handleFetchNFT } = useLocalNft();

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
          <SVGPanel svg={rawSvg} />
        </section>
      )}
      <div className="button-panel">
        <ViewButton view={view} handleClick={handleToggleView} />
        <RenderButton fetching={status == NFTStatus.FETCHING} handleClick={handleFetchNFT} />
      </div>
      <span className="copyright">© BibosCorp Research Group, 2022</span>
    </>
  );
};

export default BibosInspectorIndex;
