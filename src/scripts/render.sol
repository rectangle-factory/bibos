// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {vm} from "../util/vm.sol";
import {io} from "../util/io.sol";
import {time} from "../util/time.sol";

import {Bibos} from "../Bibos.sol";
import {Traits} from "../libraries/Traits.sol";
import {console} from "forge-std/console.sol";

contract render {
    string constant HANDLE_TOKEN_URI_PATH = "scripts/handle_token_uri.sh";
    string constant TOKEN_URI_OUTPUT_PATH = "./output/token_uri.base64";
    string constant TRAITS_PATH = "./output/traits.json";

    function run() public returns (bool) {
        Bibos bibos = new Bibos();
        // get current time to use as random seed
        time.setToUnixTime();

        // mint
        bibos.mint();

        // write base64 token uri to output path
        io.write(TOKEN_URI_OUTPUT_PATH, bibos.tokenURI(0));
        bytes32 seed = bibos.getSeed(0);
        console.logBytes32(seed);
        string memory traits = Traits.getTraits(seed);
        io.write(TRAITS_PATH, traits);

        return true;
    }
}
