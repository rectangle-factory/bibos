import { useState, useEffect } from "react";
import { decodeBase64 } from "../util";
import { trait, NFTState } from "../types";

const defaultState = {
  metadata: {
    name: "",
    image: "",
    attributes: [],
  },
  tokenId: null,
  rawSVG: null,
};

export const useNFT = (tokenURI: string) => {
  const [state, setState] = useState<NFTState>(defaultState);

  useEffect(() => {
    if (tokenURI == null) return;
    // decode and parse metadata
    const metadata = JSON.parse(decodeBase64(tokenURI));

    const tokenId = metadata.tokenId;

    // decode svg
    const rawSVG = decodeBase64(metadata.image);
    setState({ metadata, tokenId, rawSVG });
  }, [tokenURI]);

  return { ...state };
};
