import { useState } from "react";
import { NFTStatus, IndexView } from "../types";
import { SVGPanel, TraitsPanel, ImagePanel } from "../components/Panels";
import { RenderButton, ViewButton } from "../components/Buttons";
import { useLocalRender } from "../hooks/useLocalRender";
import { useNFT } from "../hooks/useNFT";
import { Container } from "../components/Container";
import { useSvg } from "../hooks/useSVG";
import SyntaxHighlighter from "react-syntax-highlighter";

// const syntaxStyle = {
//   "hljs-comment": {
//     "color": "#7195a8"
//   },
//   "hljs-quote": {
//     "color": "#7195a8"
//   },
//   "hljs-variable": {
//     "color": "#f472b6"
//   },
//   "hljs-template-variable": {
//     "color": "#f472b6"
//   },
//   "hljs-attribute": {
//     "color": "#f472b6"
//   },
//   "hljs-tag": {
//     "color": "#CC9767"
//   },
//   "hljs-name": {
//     "color": "#f472b6"
//   },
//   "hljs-regexp": {
//     "color": "#f472b6"
//   },
//   "hljs-link": {
//     "color": "#f472b6"
//   },
//   "hljs-selector-id": {
//     "color": "#f472b6"
//   },
//   "hljs-selector-class": {
//     "color": "#f472b6"
//   },
//   "hljs-number": {
//     "color": "#935c25"
//   },
//   "hljs-meta": {
//     "color": "#935c25"
//   },
//   "hljs-built_in": {
//     "color": "#935c25"
//   },
//   "hljs-builtin-name": {
//     "color": "#935c25"
//   },
//   "hljs-literal": {
//     "color": "#935c25"
//   },
//   "hljs-type": {
//     "color": "#935c25"
//   },
//   "hljs-params": {
//     "color": "#935c25"
//   },
//   "hljs-string": {
//     "color": "#FE7763"
//   },
//   "hljs-symbol": {
//     "color": "#FE7763"
//   },
//   "hljs-bullet": {
//     "color": "#FE7763"
//   },
//   "hljs-title": {
//     "color": "#257fad"
//   },
//   "hljs-section": {
//     "color": "#257fad"
//   },
//   "hljs-keyword": {
//     "color": "#6b6bb8"
//   },
//   "hljs-selector-tag": {
//     "color": "#6b6bb8"
//   },
//   "hljs": {
//     "display": "block",
//     "overflowX": "auto",
//     "background": "transparent",
//     "color": "#7ea2b4",
//     "padding": "0.5em",
//     "fontFamily": "Source Code Pro"
//   },
//   "hljs-emphasis": {
//     "fontStyle": "italic"
//   },
//   "hljs-strong": {
//     "fontWeight": "bold"
//   }
// }

function Button(props) {
  return (
    <button
      className="px-2 py-0.5 bg-primary border border-white/10 text-white rounded-lg"
      onClick={props.onClick}
    >
      {props.children}
    </button>
  );
}

function Pane(props) {
  return (
    <section
      className={`bg-background w-full h-full flex flex-col overflow-y-scroll overflow-x-hidden ${props.className}`}
    >
      {props.children}
    </section>
  );
}

Pane.defaultProps = {
  className: "",
};

function Toolbar(props) {
  return <span className="w-full bg-white/10 flex h-12 min-h-12 items-center px-2 flex-shrink-0">{props.children}</span>;
}

Toolbar.defaultProps = {
  className: "",
};

function VerticalRule(props) {
  return <div className={`border-l border-l-black ${props.className}`} />;
}

VerticalRule.defaultProps = {
  className: "",
};

function HorizontalRule(props) {
  return <div className={`w-full border-t border-t-black ${props.className}`} />;
}

HorizontalRule.defaultProps = {
  className: "",
};

function isOdd(num) {
  return num % 2;
}

export const TraitsTable = ({
  name,
  loading,
  tokenId,
  attributes,
}: {
  name: string;
  loading: boolean;
  tokenId: number;
  attributes: trait[];
}) => {
  const Loading = () => "loading";
  return (
    <div className="flex w-full flex-col">
      <span className="w-full px-4 py-2 text-white font-bold bg-white/5">{name}</span>

      {attributes.map(({ trait_type, value }, i) => (
        <span className={`w-full flex ${isOdd(i) ? "bg-white/5" : "bg-white/10"}`}>
          <span className="w-full px-4 py-1 text-white text-sm">{trait_type}</span>
          <span className="w-full px-4 py-1 text-primary text-sm font-medium">{value}</span>
        </span>
      ))}
    </div>
  );
};

const BibosInspectorIndex = () => {
  const { tokenURI, status, handleFetchNFT } = useLocalRender();
  const { metadata, tokenId, rawSVG } = useNFT(tokenURI);
  const [ debug, setDebug] = useState(false)

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
            customStyle={{ fontSize: "1rem" }}
            language="xml"
          >
            {formatted}
          </SyntaxHighlighter>
        </div>
        <HorizontalRule />
        <Toolbar>
          <div className="text-white flex gap-x-1 items-center">
            <div className="text-3xl">🔬</div>
            <div>Inspector</div>
          </div>
        </Toolbar>
      </Pane>

      <VerticalRule />

      <Pane className="items-center h-full">
        <div className="flex h-full w-full items-center justify-center">
          <div className="rounded-3xl shadow-elevation-medium relative w-full max-w-lg xl:max-w-2xl m-8">
            <img src={metadata.image} className="rounded-3xl w-full h-auto" />
            <div className="rounded-3xl z-10 absolute content-none top-0 left-0 right-0 bottom-0 border border-white/10" />
          </div>
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
          <Button onClick={() => handleFetchNFT()}>Render</Button>
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
};

export default BibosInspectorIndex;
