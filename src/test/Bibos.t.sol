// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../Bibos.sol";

contract BibosTest is DSTest {
  Bibos bibos;

  function setUp() public {
    bibos = new Bibos();
  }

  function testMint() public {
    bibos.mint();
    assertEq(bibos.totalSupply(), 1);
  }
}
