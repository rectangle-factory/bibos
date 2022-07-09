import { GenericComponentProps } from "../types";

export function Toolbar(props: GenericComponentProps) {
  return (
    <span
      className={`w-full bg-[#161b22] flex h-14 min-h-12 items-center px-3 flex-shrink-0 gap-x-2 ${props.className}`}
    >
      {props.children}
    </span>
  );
}

Toolbar.defaultProps = {
  className: "",
  children: null,
};
