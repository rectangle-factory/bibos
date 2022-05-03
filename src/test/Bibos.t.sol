// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {console} from "forge-std/console.sol";
import {DSTest} from "ds-test/test.sol";
import {vm} from "../util/vm.sol";

import {Bibos} from "../Bibos.sol";

contract BibosTest is DSTest {
    Bibos bibos;

    function setUp() public {
        bibos = new Bibos();
    }

    function testMint() public {
        // bibos.mint();
        assertEq(bibos.totalSupply(), 0);
    }

    function testGetTokenURI() public {
        bibos.mint();
        string memory tokenURI = bibos.tokenURI(0);

        assertGt(bytes(tokenURI).length, 0);
    }
}
