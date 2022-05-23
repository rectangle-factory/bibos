import { useState, useEffect } from "react";
import { ethers, Contract } from "ethers";

import { decodeBase64 } from "../util";
import { NFTStatus, trait } from "../types";

import bibosABI from "../../../out/Bibos.sol/Bibos.json";
import deployments from "../../../deployment/deployments.json";

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

const LOCAL_RPC_URI = "http://localhost:8545";
export const useLocalNft = () => {
  const [bibosContract, setBibosContract] = useState<Contract>(null);
  const [state, setState] = useState(nftStateDefault);

  useEffect(() => {
    const provider = new ethers.providers.JsonRpcProvider(LOCAL_RPC_URI);
    const signer = provider.getSigner();
    const bibosContract = new ethers.Contract(deployments.Bibos, bibosABI.abi, signer);
    setBibosContract(bibosContract);

    handleFetchNFT();
  }, []);

  useEffect(() => {
    handleFetchNFT();
  }, [bibosContract]);

  const handleFetchNFT = async () => {
    if (bibosContract == null) return;
    if (state.status == NFTStatus.FETCHING) return;

    setState((state) => ({ ...state, status: NFTStatus.FETCHING }));

    const tx = await bibosContract.mint();
    tx.wait();
    const totalSupply = await bibosContract.totalSupply();
    if (totalSupply == 0) return;
    const tokenURI = await bibosContract.tokenURI(totalSupply - 1);

    // decode and parse metadata
    const metadata = JSON.parse(decodeBase64(tokenURI));

    // random token id
    const tokenId = metadata.tokenId;

    // decode svg
    const rawSvg = decodeBase64(metadata.image);
    setState({ status: NFTStatus.FETCHED, metadata, tokenId, rawSvg });
  };

  return { ...state, handleFetchNFT };
};
