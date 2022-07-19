import { useState, useEffect } from "react";
import { NFTStatus } from "../types";

const MULTI_RENDER_ENDPOINT = "/api/multirender";

export const useMultiRender = (quantity: number) => {
  const [tokenURIs, setTokenURIs] = useState<string[]>(null);
  const [status, setStatus] = useState<NFTStatus>(NFTStatus.UNFETCHED);

  const handleFetchNFT = async () => {
    if (status == NFTStatus.FETCHING) return;

    setStatus(NFTStatus.FETCHING);

    const response = await fetch(MULTI_RENDER_ENDPOINT, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ quantity }),
    });

    // handle fetch error
    if (response.status != 200) {
      console.log("fetch error: ", response.status);
      return setStatus(NFTStatus.UNFETCHED);
    }

    // const text = await response.text();
    // console.log("tokentext multirender text", text);
    const json = await response.json();

    setTokenURIs(json);
    setStatus(NFTStatus.FETCHED);
  };

  useEffect(() => {
    handleFetchNFT();
  }, []);

  return { tokenURIs, status, handleFetchNFT };
};
