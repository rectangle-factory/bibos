import { useState, useEffect } from "react";
import { decodeBase64 } from "../util";

import {Dots} from '../components/Dots';

enum Status {
  UNFETCHED,
  FETCHING,
  FETCHED,
  ERROR,
}

const Main = () => {
  const [tokenURI, setTokenURI] = useState("");
  const [base64SVG, setBase64SVG] = useState("data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");
  const [status, setStatus] = useState(Status.UNFETCHED);

  const handleFetchTokenURI = async (e) => {
    setStatus(Status.FETCHING);
    const response = await fetch("http://localhost:3001");
    const text = await response.text();

    setTokenURI(text);
    setStatus(Status.FETCHED);
  };

  useEffect(() => {
    if (tokenURI.length == 0) return;
    const metadata = JSON.parse(decodeBase64(tokenURI));
    setBase64SVG(metadata.image);
  }, [tokenURI]);

  return (
    <>
      <section className="content">
        <div className="svg-holder">
          <img src={base64SVG} />
          </div>
        <button disabled={status == Status.FETCHING ? true : false} onClick={handleFetchTokenURI}>
          {status == Status.FETCHING ? <span className="rendering">rendering<Dots/></span> : "render"}
        </button>
      </section>
      <span className="copyright">© BibosCorp Research Group, 2022</span>
    </>
  );
};

export default Main;
