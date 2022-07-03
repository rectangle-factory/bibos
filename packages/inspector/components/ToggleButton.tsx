import { ButtonProps } from "../types";

export function ToggleButton(props: ButtonProps & { isOn: boolean }) {
  return (
    <button
      type="button"
      className="px-2 py-0.5 bg-white/20 border border-white/5 text-white rounded-lg flex items-center justify-center gap-x-1.5 shadow-elevation-low "
      onClick={props.onClick}
    >
      <div className={`transition-all user-select-none w-2 h-2 rounded-full ${props.isOn ? "bg-white shadow-glow" : "bg-white/20 shadow-none"}`} />
      {props.children}
    </button>
  );
}

ToggleButton.defaultProps = {
  primary: false,
  className: "",
  children: null,
  isOn: false,
};
