// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test, console2 as console} from "forge-std/Test.sol";

import {Bibos} from "../Bibos.sol";

import {time} from "src/util/time.sol";

contract local_render is Test {
    function run() external returns (string memory tokenURI) {
        Bibos bibos = new Bibos();
        uint256 price = bibos.price();
        uint256 totalSupply = bibos.maxSupply();

        // get current time to use as random seed
        uint256 unixTime = time.getUnixTime();
        // set block.timestamp
        vm.warp(unixTime);

        // compute a random tokenId
        uint256 tokenId = uint256(keccak256(abi.encode(unixTime))) % totalSupply;

        // set the total supply
        // (in storage slot 7)
        vm.store(address(bibos), bytes32(uint256(7)), bytes32(tokenId));

        // mint
        vm.deal(address(this), price);
        bibos.mint{value: price}();
        tokenURI = bibos.tokenURI(tokenId);
    }

    function run(uint256 _amount) external returns (string[] memory tokenURIs) {
        Bibos bibos = new Bibos();
        uint256 price = bibos.price();

        // get current time to use as random seed
        uint256 unixTime = time.getUnixTime();
        // set block.timestamp
        vm.warp(unixTime);

        tokenURIs = new string[](_amount);

        vm.deal(address(this), _amount * price);
        uint256 i;
        for (; i < _amount; ++i) {
            // mint
            bibos.mint{value: price}();
            tokenURIs[i] = bibos.tokenURI(i);
        }
    }
}
