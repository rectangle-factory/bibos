import { useState, useEffect } from "react";
import { NFTStatus, Token } from "../types";
import { decodeTokenURI } from "../util";

// returns the entire tokenURI
const RENDER_ENDPOINT = "/api/render";

const defaultState = {
  name: "",
  image: "",
  attributes: [],

  tokenId: null,
  svg: null,
};

export const useLocalRender = () => {
  const [token, setToken] = useState<Token>(defaultState);
  const [status, setStatus] = useState<NFTStatus>(NFTStatus.UNFETCHED);

  const handleLocalRender = async () => {
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

    setToken(decodeTokenURI(tokenURI));
    setStatus(NFTStatus.FETCHED);
  };

  useEffect(() => {
    handleLocalRender();
  }, []);

  return { token, status, handleLocalRender };
};
