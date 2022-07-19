import { useState } from "react";
import SyntaxHighlighter from "react-syntax-highlighter";
import { xml } from "@codemirror/lang-xml";
import { EditorView } from "@codemirror/view";
import { basicSetup } from "codemirror";
import CodeMirror from "@uiw/react-codemirror";
import { syntaxHighlighting, bracketMatching, foldGutter, codeFolding } from "@codemirror/language";
import { highlightDark, themeDark } from "../components/CodeMirrorTheme";

import { NFTStatus, IndexView } from "../types";
import { useLocalRender } from "../hooks/useLocalRender";
import { useMultiRender } from "../hooks/useMultiRender";
import { useNFT } from "../hooks/useNFT";
import { useFormattedSvg } from "../hooks/useFormattedSVG";
import { Container } from "../components/Container";
import { Pane } from "../components/Pane";
import { HorizontalRule } from "../components/HorizontalRule";
import { Toolbar } from "../components/Toolbar";
import { VerticalRule } from "../components/VerticalRule";
import { Button } from "../components/Button";
import { SVGViewer } from "../components/SVGViewer";
import { ToggleButton } from "../components/ToggleButton";
import { TraitsTable } from "../components/TraitsTable";

export default function Index() {
  const { tokenURI, status, handleFetchNFT } = useLocalRender();
  const { metadata, tokenId, svg } = useNFT(tokenURI);
  const [debug, setDebug] = useState(false);
  const { formattedSvg, error } = useFormattedSvg(svg);
  
  const loc = formattedSvg.split(/\r\n|\r|\n/).length;
  const kb = (new TextEncoder().encode(svg).length * 0.001).toFixed(3);

  return (
    <Container>
      <Pane>
        <div className="flex h-full overflow-y-scroll">
          <CodeMirror
            className="w-full h-full border-none overflow-y-scroll scrollbar-none"
            value={formattedSvg}
            // height={ '100%' }
            basicSetup={{
              foldGutter: false,
            }}
            editable={false}
            theme={themeDark}
            extensions={[
              xml(),
              EditorView.lineWrapping,
              syntaxHighlighting(highlightDark),
              codeFolding({
                placeholderText: "􀠪",
              }),
              foldGutter({
                markerDOM(open) {
                  const el = document.createElement("span");
                  if (open === true) {
                    el.className = "user-select-none text-label-500";
                    el.innerHTML = "􀁱";
                  } else {
                    el.className = "user-select-none text-[#ff7b72]";
                    el.innerHTML = "􀯽";
                  }
                  return el;
                },
              }),
            ]}
          />
        </div>
        {error.length === 0 ? null : (
          <>
            <div className="border-t border-t-red-500/50 flex flex-col w-full px-4 py-2 bg-red-500/10 text-label">
              <div className="w-full text-sm font-bold text-red-500">Error parsing SVG</div>
              <div className="w-full text-sm">{error}</div>
            </div>
          </>
        )}
        <HorizontalRule />
        <Toolbar className="justify-between">
          <div className="text-label flex gap-x-1 items-center">
            <div className="text-2xl">🔬</div>
            <div className="opacity-70">Inspector</div>
          </div>

          <div className="flex gap-x-2 items-center">
            <div className="text-label text-sm">
              <div className="inline mr-1">{loc}</div>
              <div className="inline opacity-50">LOC</div>
            </div>
            <div className="text-label text-sm">
              <div className="inline mr-1">{kb}</div>
              <div className="inline opacity-50">kb</div>
            </div>
          </div>
        </Toolbar>
      </Pane>

      <VerticalRule />

      <Pane className="items-center h-full">
        <div className="flex w-full h-full items-center justify-center p-8">
          <SVGViewer
            tokenId={tokenId}
            svg={svg}
            debug={debug}
            isLoading={status == NFTStatus.FETCHING}
          />
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
