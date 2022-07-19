import { useEffect, useRef } from "react";
import { downloadSVG, downloadPNG, scaleCanvas } from "../util/index";

type SVGViewerProps = {
  debug?: boolean;
  className?: string;
  svg: string;
  isLoading?: boolean;
  tokenId: number;
};

const WIDTH = 1200;
const HEIGHT = 1200;

export function SVGViewer(props: SVGViewerProps) {
  const canvasRef = useRef(null);

  useEffect(() => {
    scaleCanvas(canvasRef);
  }, []);

  return (
    <div
      className={`rounded-3xl shadow-elevation-medium relative h-full max-h-[600px] max-w-[600px] w-auto bg-white/5 ${props.className}`}
    >
      <canvas
        ref={canvasRef}
        width={WIDTH}
        height={HEIGHT}
        className="fixed top-[-10000px] left-[-10000px] invisible"
      />

      <div
        className={`rounded-3xl h-full w-auto overflow-hidden transition-opacity duration-300 ${
          props.isLoading ? "opacity-0" : "opacity-100"
        } ${props.debug ? "debug-svg" : ""}`}
        dangerouslySetInnerHTML={{ __html: props.svg }}
      />
      <div
        className={`rounded-3xl z-90 absolute content-none top-0 left-0 right-0 bottom-0 ${
          props.debug ? "inner-shadow-border-debug" : "inner-shadow-border"
        }`}
      />
      <div className="absolute top-0 left-0 right-0 bottom-0 rounded-3xl opacity-0 hover:opacity-100">
        <div className="absolute right-0 bottom-0 p-4 flex gap-x-2">
          <button
            className="text-sm exclusion bg-white/10 border border-white/10 rounded-lg px-2 py-0.5 text-label"
            onClick={() => downloadSVG(props.svg, "bibo" + props.tokenId)}
          >
            ↓ SVG
          </button>

          <button
            className="text-sm exclusion bg-white/10 border border-white/10 rounded-lg px-2 py-0.5 text-label"
            onClick={() => downloadPNG(canvasRef, props.svg, "bibo" + props.tokenId, WIDTH, HEIGHT)}
          >
            ↓ PNG
          </button>
        </div>
      </div>
    </div>
  );
}

SVGViewer.defaultProps = {
  debug: false,
  className: "",
};
