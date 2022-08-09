import { useState, useEffect } from "react";
import { ethers, Contract } from "ethers";

import { FetchStatus, Trait } from "../types";

import bibosABI from "../../../out/Bibos.sol/Bibos.json";
import deployments from "../../../deployment/deployments.json";

type NFTState = {
  status: FetchStatus;
  metadata: {
    image: string;
    attributes: Trait[];
  };
  tokenId: number;
  rawSvg: string;
};

const LOCAL_RPC_URI = "http://localhost:8545";
export const useLocalRPC = () => {
  const [bibosContract, setBibosContract] = useState<Contract>(null);
  const [tokenURI, setTokenURI] = useState<string>(null);
  const [status, setStatus] = useState<FetchStatus>(FetchStatus.UNFETCHED);

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
    if (status == FetchStatus.FETCHING) return;

    setStatus(FetchStatus.FETCHING);

    const tx = await bibosContract.mint();
    tx.wait();
    const totalSupply = await bibosContract.totalSupply();
    if (totalSupply == 0) return;
    const tokenURI = await bibosContract.tokenURI(totalSupply - 1);

    setTokenURI(tokenURI);
    setStatus(FetchStatus.FETCHED);
  };

  return { tokenURI, status, handleFetchNFT };
};
