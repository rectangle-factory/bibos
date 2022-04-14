import { useState, useEffect } from "react";
import { decodeBase64 } from "../util";
import { BibosStatus } from "../types";

export const useBibos = () => {
  const [status, setStatus] = useState(BibosStatus.UNFETCHED);
  const [metadata, setMetadata] = useState({ image: "", attributes: [] });
  const [tokenId, setTokenId] = useState(-1);
  const [rawSvg, setRawSvg] = useState("");

  const handleFetchBibo = async () => {
    if (status == BibosStatus.FETCHING) return;
    setStatus(BibosStatus.FETCHING);
    const response = await fetch("http://localhost:3001");
    const text = await response.text();
    const metadata = JSON.parse(decodeBase64(text));
    setMetadata(metadata);
    setTokenId(Math.floor(Math.random() * 999));
    setRawSvg(decodeBase64(metadata.image));
    setStatus(BibosStatus.FETCHED);
  };

  useEffect(() => {
    handleFetchBibo();
  }, []);

  return { status, metadata, tokenId, rawSvg, handleFetchBibo };
};
