import { useState, useEffect } from "react";
import { NFTStatus, trait } from "../types";

// returns the entire tokenURI
const RENDER_ENDPOINT = "/api/render";

export const useLocalRender = () => {
  const [tokenURI, setTokenURI] = useState<string>(null);
  const [status, setStatus] = useState<NFTStatus>(NFTStatus.UNFETCHED);

  const handleFetchNFT = async () => {
    if (status == NFTStatus.FETCHING) return;

    setStatus(NFTStatus.FETCHING);

    const response = await fetch(RENDER_ENDPOINT);

    // handle fetch error
    if (response.status != 200) {
      console.log("fetch error: ", response.status);
      return setStatus(NFTStatus.UNFETCHED);
    }

    const tokenURI = await response.text();
    console.log("tokenURI", tokenURI);
    setTokenURI(tokenURI);
    setStatus(NFTStatus.FETCHED);
  };

  useEffect(() => {
    handleFetchNFT();
  }, []);

  return { tokenURI, status, handleFetchNFT };
};
