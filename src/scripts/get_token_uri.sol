// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {vm} from "../util/vm.sol";
import {io} from "../util/io.sol";
import {time} from "../util/time.sol";

import {Bibos} from "../Bibos.sol";
import {Test, console2 as console} from "forge-std/Test.sol";

contract get_token_uri is Test {
    string constant TOKEN_URI_OUTPUT_PATH = "./output/token_uri.base64";

    function run() external {
        Bibos bibos = new Bibos();
        // get current time to use as random seed
        uint256 unixTime = time.setToUnixTime();

        // compute a random tokenId
        uint256 tokenId = unixTime % 999;

        // set the total supply
        vm.store(address(bibos), bytes32(uint256(7)), bytes32(tokenId));

        // mint
        bibos.mint();
        console.log(bibos.tokenURI(tokenId));
    }
}
