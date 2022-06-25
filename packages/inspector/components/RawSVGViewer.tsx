type RawSVGViewerProps = {
  debug?: boolean;
  className?: string;
  rawSVG: string;
  isLoading?: boolean;
};

export function RawSVGViewer(props: RawSVGViewerProps) {
  return (
    <div
      className={`rounded-3xl shadow-elevation-medium relative h-full w-auto bg-white/5 ${props.className}`}
    >
      <div
        className={`rounded-3xl h-full w-auto overflow-hidden transition-opacity duration-300 ${props.isLoading ? 'opacity-0' : 'opacity-100'} ${props.debug ? "debug-svg" : ""}`}
        dangerouslySetInnerHTML={{ __html: props.rawSVG }}
      />
      <div className="rounded-3xl z-90 absolute content-none top-0 left-0 right-0 bottom-0 inner-shadow-border" />
    </div>
  );
}

RawSVGViewer.defaultProps = {
  debug: false,
  className: "",
};
