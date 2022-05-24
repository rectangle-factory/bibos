import { useState, useEffect } from "react";
import { decodeBase64 } from "../util";
import { trait } from "../types";

type NFTState = {
  metadata: {
    name: string;
    image: string;
    attributes: trait[];
  };
  tokenId: number;
  rawSVG: string;
};

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
