import { useState, useEffect } from "react";
import { decodeBase64 } from "../util";
import { trait } from "../types";

type NFTState = {
  metadata: {
    image: string;
    attributes: trait[];
  };
  tokenId: number;
  rawSvg: string;
};

export const useNft = (tokenURI: string) => {
  const [state, setState] = useState<NFTState>(null);

  useEffect(() => {
    // decode and parse metadata
    const metadata = JSON.parse(decodeBase64(tokenURI));

    // random token id
    const tokenId = metadata.tokenId;

    // decode svg
    const rawSvg = decodeBase64(metadata.image);
    setState({ metadata, tokenId, rawSvg });
  }, [tokenURI]);

  return { ...state };
};
