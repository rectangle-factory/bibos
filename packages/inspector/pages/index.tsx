import { useState } from "react";

import { SVGPanel, TraitsPanel } from "../components/Panels";
import { RenderButton, ViewButton } from "../components/Buttons";
import { BibosStatus, IndexView } from "../types";
import { useBibos } from "../hooks/useBibos";

const BibosInspectorIndex = () => {
  const [view, setView] = useState(IndexView.IMAGE);
  const { status, metadata, tokenId, rawSvg, handleFetchBibo } = useBibos();

  const handleToggleView = () =>
    setView((view) => (view == IndexView.IMAGE ? IndexView.SVG : IndexView.IMAGE));

  return (
    <>
      {view == IndexView.IMAGE ? (
        <section className="content">
          <div className="svg-holder">
            <img src={metadata.image} />
          </div>
          <TraitsPanel tokenId={tokenId} attributes={metadata.attributes} />
        </section>
      ) : (
        <section className="content">
          <SVGPanel svg={rawSvg} />
        </section>
      )}
      <div className="button-panel">
        <RenderButton fetching={status == BibosStatus.FETCHING} handleClick={handleFetchBibo} />
        <ViewButton view={view} handleClick={handleToggleView} />
      </div>
      <span className="copyright">© BibosCorp Research Group, 2022</span>
    </>
  );
};

export default BibosInspectorIndex;
