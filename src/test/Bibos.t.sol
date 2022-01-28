// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../Bibos.sol";

interface Cheatcodes {
  function ffi(string[] calldata) external returns (bytes memory);
}

contract BibosTest is DSTest {
  Bibos bibos;
  Cheatcodes cheatcodes =
    Cheatcodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

  function setUp() public {
    bibos = new Bibos();
  }

  function testMint() public {
    bibos.mint();
    assertEq(bibos.totalSupply(), 1);
  }

  function testOutputSvg() public {
    bibos.mint();
    string[] memory inputs = new string[](2);
    inputs[0] = "scripts/output.sh";
    inputs[1] = bibos.tokenURI(0);
    cheatcodes.ffi(inputs);
  }
}
