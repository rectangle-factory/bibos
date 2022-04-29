import { useState, useEffect } from "react";
import { decodeBase64 } from "../util";
import { NFTStatus, trait } from "../types";

type NFTState = {
  status: NFTStatus;
  metadata: {
    image: string;
    attributes: trait[];
  };
  tokenId: number;
  rawSvg: string;
};

const nftStateDefault: NFTState = {
  status: NFTStatus.UNFETCHED,
  metadata: {
    image: "",
    attributes: [],
  },
  tokenId: -1,
  rawSvg: "",
};

// returns the entire tokenURI
const RENDER_ENDPOINT = "/api/render";

export const useNft = () => {
  const [state, setState] = useState(nftStateDefault);

  const handleFetchNFT = async () => {
    if (state.status == NFTStatus.FETCHING) return;

    setState((state) => ({ ...state, status: NFTStatus.FETCHING }));

    const response = await fetch(RENDER_ENDPOINT);

    // handle fetch error
    if (response.status != 200) {
      console.log("fetch error: ", response.status);
      return setState(nftStateDefault);
    }

    const text = await response.text();

    // decode and parse metadata
    const metadata = JSON.parse(decodeBase64(text));

    // random token id
    const tokenId = Math.floor(Math.random() * 999);

    // decode svg
    const rawSvg = decodeBase64(metadata.image);
    setState({ status: NFTStatus.FETCHED, metadata, tokenId, rawSvg });
  };

  useEffect(() => {
    handleFetchNFT();
  }, []);

  return { ...state, handleFetchNFT };
};
