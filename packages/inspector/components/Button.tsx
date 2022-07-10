import { ButtonProps } from "../types";
import classnames from "classnames";

export function Button(props: ButtonProps) {
  const cns = classnames({
    "bg-primary text-background": props.primary,
    "bg-[#21262d]": !props.primary,
    "shadow-none opacity-50 pointer-events-none": props.disabled,
    "shadow-elevation-low": !props.disabled,
  });
  return (
    <button
      type="button"
      className={`transition-opacity user-select-none px-2 py-0.5 border border-white/10 text-label rounded-lg font-medium ${cns} ${props.className}`}
      onClick={props.onClick}
    >
      {props.children}
    </button>
  );
}

Button.defaultProps = {
  primary: false,
  className: "",
  children: null,
  disabled: false,
};
