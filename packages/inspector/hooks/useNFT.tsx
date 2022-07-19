import { useState, useEffect } from "react";
import { decodeBase64 } from "../util";
import { FetchStatus } from "../types";

const defaultState = {
  metadata: {
    name: "",
    image: "",
    attributes: [],
  },
  tokenId: null,
  svg: null,
};

export const useNFT = (tokenURI: string) => {
  const [state, setState] = useState<FetchStatus>(defaultState);

  useEffect(() => {
    if (tokenURI == null) return;
    // decode and parse metadata

    const metadata = JSON.parse(decodeBase64(tokenURI));

    const tokenId = metadata.tokenId;

    // decode svg
    const svg = decodeBase64(metadata.image);
    setState({ metadata, tokenId, svg });
  }, [tokenURI]);

  return { ...state };
};
