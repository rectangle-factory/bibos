// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test, console2 as console} from "forge-std/Test.sol";

import {Bibos} from "../Bibos.sol";
import {deploy} from "src/scripts/deploy.sol";
import {time} from "src/util/time.sol";

contract get_token_uri is Test {
    function run() external {
        vm.startPrank(0xa0Ee7A142d267C1f36714E4a8F75612F20a79720);
        address d = address(new deploy());

        // bibos needs to have all libraries linked
        Bibos bibos = new Bibos();

        // get current time to use as random seed
        uint256 unixTime = time.getUnixTime();
        // set block.timestamp
        vm.warp(unixTime);

        // compute a random tokenId
        uint256 tokenId = unixTime % 999;

        // set the total supply
        // (in storage slot 7)
        vm.store(address(bibos), bytes32(uint256(7)), bytes32(tokenId));

        // mint
        bibos.mint();
        console.log(bibos.tokenURI(tokenId));
    }
}
