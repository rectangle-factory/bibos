import { useState, useEffect } from "react";

const Main = () => {
  const [tokenURI, setTokenURI] = useState("");

  const handleFetchTokenURI = () => {
    fetch("localhost:3001")
      .then((response) => response.body.toString())
      .then((uri) => setTokenURI(uri));
  };
  return (
    <section>
      <span>{tokenURI}</span>
      <button onClick={handleFetchTokenURI}>fetch token uri</button>
    </section>
  );
};

export default Main;
