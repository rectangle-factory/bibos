import { useState, useEffect } from "react";
import {ethers } from "ethers"

import bibosAPI from "../../../out/Bibos.sol/Bibos.json"
import deployments from "../../../deployment/deployments.json"

export const useBibosContract = (svg: string) => {
  const [bibosContract, setBibosContract] = useState("");

  useEffect(() => {
    const provider = new ethers.providers.JsonRpcProvider( "http://localhost:8545" );
    const signer = provider.getSigner();  
    const bibosContract = new ethers.Contract( "0x5067457698fd6fa1c6964e416b3f42713513b3dd" , deployments.Bibos , signer )
}, []);

  return { bibosContract };
};
