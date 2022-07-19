import { useState, useEffect } from "react";
import { NFTStatus, Token } from "../types";
import { decodeTokenURI } from "../util";

const MULTI_RENDER_ENDPOINT = "/api/multirender";

export const useMultiRender = (quantity: number) => {
  const [tokens, setTokens] = useState<Token[]>(null);
  const [status, setStatus] = useState<NFTStatus>(NFTStatus.UNFETCHED);

  const handleMultiRender = async () => {
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

    const tokenURIs = await response.json();
    setTokens(tokenURIs.map((tokenURI) => decodeTokenURI(tokenURI)));
    setStatus(NFTStatus.FETCHED);
  };

  useEffect(() => {
    handleMultiRender();
  }, []);

  return { tokens, status, handleMultiRender };
};
