import { useState } from "react";
import { xml } from "@codemirror/lang-xml";
import { EditorView } from "@codemirror/view";
import CodeMirror from "@uiw/react-codemirror";
import { syntaxHighlighting, foldGutter, codeFolding } from "@codemirror/language";
import { highlightDark, themeDark } from "../components/CodeMirrorTheme";

import { FetchStatus } from "../types";
import { useLocalRender } from "../hooks/useLocalRender";

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
  const { token, status, handleLocalRender } = useLocalRender();

  const [debug, setDebug] = useState(false);
  const { formattedSvg, error } = useFormattedSvg(token.svg);

  const loc = formattedSvg.split(/\r\n|\r|\n/).length;
  const kb = (new TextEncoder().encode(token.svg).length * 0.001).toFixed(3);

  return (
    <Container>
      <Pane>
        <div className="flex h-full overflow-y-scroll">
          <CodeMirror
            className="w-full h-full border-none scrollbar-none"
            value={formattedSvg}
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
            <div className="border-t border-t-orange-500/50 flex flex-col w-full px-4 py-2 bg-orange-500/10 text-label">
              <div className="w-full text-sm font-bold text-orange-500">Error parsing SVG</div>
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
            tokenId={token.tokenId}
            svg={token.svg}
            debug={debug}
            isLoading={status == FetchStatus.FETCHING}
          />
        </div>

        <TraitsTable name={token.name} attributes={token.attributes} />
        <HorizontalRule />
        <Toolbar>
          <Button
            disabled={status == FetchStatus.FETCHING}
            primary
            onClick={() => handleLocalRender()}
          >
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
