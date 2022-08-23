// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";

import {Bibos} from "../Bibos.sol";

// usage:
// forge script --rpc-url $RPC_URL get_seeds

/// @title get_seeds
/// @notice gets all the Bibos bytes32 seeds sequentially
/// @author Bumblebee Systems
contract get_seeds is Script {
    address constant BIBOS_ADDRESS = 0xF528e3381372c43F5e8a55b3E6c252E32F1a26e4;

    function run() external view returns (bytes32[] memory) {
        Bibos bibos = Bibos(BIBOS_ADDRESS);

        uint256 totalSupply = bibos.totalSupply();
        bytes32[] memory seeds = new bytes32[](totalSupply);

        uint256 i;
        for (; i < totalSupply; ++i) {
            seeds[i] = Bibos(BIBOS_ADDRESS).seeds(i);
        }

        return seeds;
    }
}
