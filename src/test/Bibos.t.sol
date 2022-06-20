// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Bibos} from "../Bibos.sol";

contract BibosTest is Test {
    Bibos bibos;

    function setUp() public {
        bibos = new Bibos();
    }

    function testMint() public {
        bibos.mint();
        assertEq(bibos.totalSupply(), 1);
    }

    function testMintMultiple(uint8 _amount) public {
        vm.assume(_amount <= 10);
        bibos.mint(_amount);
        assertEq(bibos.totalSupply(), _amount);
    }

    function testGetTokenURI() public {
        bibos.mint();
        string memory tokenURI = bibos.tokenURI(0);

        assertGt(bytes(tokenURI).length, 0);
    }
}
