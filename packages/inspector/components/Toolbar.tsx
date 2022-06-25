import { GenericComponentProps } from "../types";

export function Toolbar(props: GenericComponentProps) {
  return (
    <span className="w-full bg-white/10 flex h-12 min-h-12 items-center px-2 flex-shrink-0 gap-x-2">
      {props.children}
    </span>
  );
}

Toolbar.defaultProps = {
  className: "",
  children: null,
};
