import { useState } from "react";

import { SVGPanel, TraitsPanel } from "../components/Panels";
import { RenderButton } from "../components/Buttons";
import { useBibos, Status } from "../hooks/useBibos";

enum View {
  IMAGE,
  SVG,
}

const BibosInspector = () => {
  const [view, setView] = useState(View.IMAGE);
  const { status, metadata, tokenId, rawSvg, handleFetchBibo } = useBibos();

  const handleClickView = () => setView((view) => (view == View.IMAGE ? View.SVG : View.IMAGE));

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
          <SVGPanel svg={rawSvg} />
        </section>
      )}
      <div className="button-panel">
        <RenderButton fetching={status == Status.FETCHING} handleClick={handleFetchBibo} />
        <button onClick={handleClickView}>{view == View.IMAGE ? "SVG" : "image"}</button>
      </div>
      <span className="copyright">© BibosCorp Research Group, 2022</span>
    </>
  );
};

export default BibosInspector;
