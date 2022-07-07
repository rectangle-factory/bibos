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

  const loc = formatted.split(/\r\n|\r|\n/).length;
  const kb = ((new TextEncoder().encode(rawSVG)).length * 0.001).toFixed(3)

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
        {
          error.length === 0 ? (
            null
          ) :
          <>
          <div className="border-t border-t-red-500/50 flex flex-col w-full px-4 py-2 bg-red-500/10 text-white">
          <div className="w-full text-sm font-bold text-red-500">
            Error parsing SVG
            </div>
            <div className="w-full text-sm">{error}</div>
          </div>
          </>
        }
        <HorizontalRule />
        <Toolbar className="justify-between">
          <div className="text-white flex gap-x-1 items-center">
            <div className="text-2xl">🔬</div>
            <div className="opacity-70">Inspector</div>
          </div>

          <div className="flex gap-x-2 items-center">
            <div className="text-white text-sm"><div className="inline mr-1">{loc}</div><div className="inline opacity-50">LOC</div></div>
            <div className="text-white text-sm"><div className="inline mr-1">{kb}</div><div className="inline opacity-50">kb</div></div>

          </div>
        </Toolbar>
      </Pane>

      <VerticalRule />

      <Pane className="items-center h-full">
        <div className="flex w-full h-full items-center justify-center p-8">
          <RawSVGViewer tokenId={tokenId} rawSVG={rawSVG} debug={debug} isLoading={status == NFTStatus.FETCHING}/>
        </div>

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
}
