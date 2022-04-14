import { Dots } from "./Dots";
import { IndexView } from "../types";
import { IoCode, IoEye } from "react-icons/io5";

export const RenderButton = ({ fetching, handleClick }) => (
  <button className="render-button" disabled={fetching} onClick={handleClick}>
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

export const ViewButton = ({ view, handleClick }) => (
  <button className="view-button" onClick={handleClick}>
    {view == IndexView.IMAGE ? <IoCode /> : <IoEye />}
  </button>
);
