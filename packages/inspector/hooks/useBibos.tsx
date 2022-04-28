import { useState, useEffect } from "react";
import { decodeBase64 } from "../util";
import { BibosStatus, trait } from "../types";

type BibosState = {
  status: BibosStatus;
  metadata: {
    image: string;
    attributes: trait[];
  };
  tokenId: number;
  rawSvg: string;
};

const BibosStateDefault: BibosState = {
  status: BibosStatus.UNFETCHED,
  metadata: {
    image: "",
    attributes: [],
  },
  tokenId: -1,
  rawSvg: "",
};

export const useBibos = () => {
  const [state, setState] = useState(BibosStateDefault);

  const handleFetchBibos = async () => {
    if (state.status == BibosStatus.FETCHING) return;
    setState((state) => ({ ...state, status: BibosStatus.FETCHING }));
    const response = await fetch("http://localhost:3001");
    const text = await response.text();
    const metadata = JSON.parse(decodeBase64(text));
    const tokenId = Math.floor(Math.random() * 999);
    const rawSvg = decodeBase64(metadata.image);
    setState({ status: BibosStatus.FETCHED, metadata, tokenId, rawSvg });
  };

  useEffect(() => {
    handleFetchBibos();
  }, []);

  return { ...state, handleFetchBibos };
};
