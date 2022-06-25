import { useState } from "react";
import SyntaxHighlighter from "react-syntax-highlighter";

import { NFTStatus, IndexView } from "../types";
import { useLocalRender } from "../hooks/useLocalRender";
import { useNFT } from "../hooks/useNFT";
import { useSvg } from "../hooks/useSVG";
import { Container } from "../components/Container";
import { Pane } from "../components/Pane";
import { HorizontalRule } from "../components/HorizontalRule";
import { Toolbar } from "../components/Toolbar";
import { VerticalRule } from "../components/VerticalRule";
import { Button } from "../components/Button";
import { RawSVGViewer } from "../components/RawSVGViewer";
import { ToggleButton } from "../components/ToggleButton";
import { TraitsTable } from "../components/TraitsTable";

export default function Index() {
  const { tokenURI, status, handleFetchNFT } = useLocalRender();
  const { metadata, tokenId, rawSVG } = useNFT(tokenURI);
  const [debug, setDebug] = useState(false);

  const { formatted, error } = useSvg(rawSVG);

  return (
    <Container>
      <Pane>
        <div className="flex h-full overflow-y-scroll">
          <SyntaxHighlighter
            wrapLongLines={true}
            // wrapLines={true}
            showLineNumbers={true}
            useInlineStyles={false}
            customStyle={{ fontSize: "1rem", paddingTop: "1rem" }}
            language="xml"
          >
            {formatted}
          </SyntaxHighlighter>
        </div>
        <HorizontalRule />
        <Toolbar>
          <div className="text-white flex gap-x-2 items-center">
            <div className="text-xl w-8 h-8 bg-black/40 flex items-center justify-center rounded-lg border border-black/50">🔬</div>
            <div>Inspector</div>
          </div>
        </Toolbar>
      </Pane>

      <VerticalRule />

      <Pane className="items-center h-full">
        <div className="flex w-full h-full items-center justify-center p-8">
          <RawSVGViewer rawSVG={rawSVG} debug={debug} isLoading={status == NFTStatus.FETCHING}/>
        </div>
        <HorizontalRule />
        <TraitsTable
          loading={status == NFTStatus.UNFETCHED}
          tokenId={tokenId}
          name={metadata.name}
          attributes={metadata.attributes}
        />
        <HorizontalRule />
        <Toolbar>
          <Button disabled={status == NFTStatus.FETCHING} primary onClick={() => handleFetchNFT()}>
            Render
          </Button>
          <ToggleButton isOn={debug} onClick={() => setDebug(!debug)}>
            Debug
          </ToggleButton>
        </Toolbar>
      </Pane>
    </Container>
  );

  // return (
  //   <>
  //     {view == IndexView.IMAGE ? (
  //       <section className="content">
  //         <ImagePanel src={metadata.image} />
  //         <TraitsPanel
  //           loading={status == NFTStatus.UNFETCHED}
  //           tokenId={tokenId}
  //           name={metadata.name}
  //           attributes={metadata.attributes}
  //         />
  //       </section>
  //     ) : (
  //       <section className="content">
  //         <SVGPanel svg={rawSVG} />
  //       </section>
  //     )}
  //     <div className="button-panel">
  //       <ViewButton view={view} handleClick={handleToggleView} />
  //       <RenderButton fetching={status == NFTStatus.FETCHING} handleClick={handleFetchNFT} />
  //     </div>
  //     <span className="copyright">© BibosCorp Research Group, 2022</span>
  //   </>
  // );
}
