import { NFTState } from "../types";

type ImageViewerProps = {
  debug?: boolean;
  className?: string;
  rawSVG: string;
  metadata: NFTState["metadata"];
};

export function ImageViewer(props: ImageViewerProps) {
  return (
    <div
      className={`rounded-3xl shadow-elevation-medium relative h-full w-auto overflow-hidden ${props.className}`}
    >
      <img
        src={props.metadata.image}
        className={`rounded-3xl w-full h-auto ${props.debug ? "debug-svg" : ""}`}
      />
      <div className="rounded-3xl z-10 absolute content-none top-0 left-0 right-0 bottom-0 border border-white/10" />
    </div>
  );
}

ImageViewer.defaultProps = {
  debug: false,
  className: "",
};
