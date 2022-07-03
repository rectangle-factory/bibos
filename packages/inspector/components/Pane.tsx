import { GenericComponentProps } from "../types";

export function Pane(props: GenericComponentProps) {
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
  children: null,
};
