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

export const useNft = () => {
  const [state, setState] = useState(nftStateDefault);

  const handleFetchNFT = async () => {
    if (state.status == NFTStatus.FETCHING) return;
    setState((state) => ({ ...state, status: NFTStatus.FETCHING }));
    const response = await fetch("/api/render");
    const text = await response.text();
    const metadata = JSON.parse(decodeBase64(text));
    const tokenId = Math.floor(Math.random() * 999);
    const rawSvg = decodeBase64(metadata.image);
    setState({ status: NFTStatus.FETCHED, metadata, tokenId, rawSvg });
  };

  useEffect(() => {
    handleFetchNFT();
  }, []);

  useEffect(() => {
    console.log(state.rawSvg);
  }, [state]);

  return { ...state, handleFetchNFT };
};
