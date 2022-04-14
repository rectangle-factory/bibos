import { Dots } from "./Dots";
import { MouseEventHandler } from "react";

export const RenderButton = ({
  fetching,
  handleClick,
}: {
  fetching: boolean;
  handleClick: MouseEventHandler<HTMLButtonElement>;
}) => (
  <button disabled={fetching} onClick={handleClick}>
    {fetching ? (
      <span className="rendering">
        rendering
        <Dots />
      </span>
    ) : (
      "render"
    )}
  </button>
);
