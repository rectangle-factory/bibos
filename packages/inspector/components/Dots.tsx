import {useEffect, useState} from "react";

const Dots = () => {
  const [state, setState] = useState(0);

  useEffect(() => {
    const timeout = setTimeout(() => {
      setState((state) => (state + 1) % 4);
    }, 500);

    return () => clearTimeout(timeout);
  }, [state]);

  return <span className="dots">{new Array(state).fill(".").join("").padEnd(3, " ")}</span>;
};

export {Dots};
