import { useState, useEffect } from "react";
import { FetchStatus, Token } from "../types";
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
  const [status, setStatus] = useState<FetchStatus>(FetchStatus.UNFETCHED);

  const handleLocalRender = async () => {
    if (status == FetchStatus.FETCHING) return;

    setStatus(FetchStatus.FETCHING);

    const response = await fetch(RENDER_ENDPOINT);

    // handle fetch error
    if (response.status != 200) {
      console.log("fetch error: ", response.status);
      return setStatus(FetchStatus.UNFETCHED);
    }

    const tokenURI = await response.json();

    setToken(decodeTokenURI(tokenURI));
    setStatus(FetchStatus.FETCHED);
  };

  useEffect(() => {
    handleLocalRender();
  }, []);

  return { token, status, handleLocalRender };
};
