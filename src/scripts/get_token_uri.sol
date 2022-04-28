// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {vm} from "../util/vm.sol";
import {io} from "../util/io.sol";
import {time} from "../util/time.sol";

import {Bibos} from "../Bibos.sol";
import {console} from "forge-std/console.sol";

contract get_token_uri {
    string constant TOKEN_URI_OUTPUT_PATH = "./output/token_uri.base64";

    function run() external {
        Bibos bibos = new Bibos();
        // get current time to use as random seed
        time.setToUnixTime();

        // mint
        bibos.mint();
        io.write(TOKEN_URI_OUTPUT_PATH, bibos.tokenURI(0));
    }

    function run2() external {
        Bibos bibos = new Bibos();
        // get current time to use as random seed
        time.setToUnixTime();

        // mint
        bibos.mint();
        console.log(bibos.tokenURI(0));
    }
}
