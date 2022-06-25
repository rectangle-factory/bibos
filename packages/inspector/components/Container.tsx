import Div100vh from "react-div-100vh";
import { GenericComponentProps } from "../types";

export function Container(props: GenericComponentProps) {
  return (
    <Div100vh className={`relative w-full flex h-full ${props.className}`}>
      {props.children}
    </Div100vh>
  );
}

Container.defaultProps = {
  className: "",
  children: null,
};
