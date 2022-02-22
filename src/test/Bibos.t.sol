// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import 'ds-test/test.sol';
import '../Bibos.sol';
import '../Util/console.sol';

interface Cheatcodes {
  // Set block.timestamp
  function warp(uint256) external;

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
    // get random seed
    string[] memory inputs1 = new string[](1);
    inputs1[0] = 'scripts/seed.sh';
    bytes32 seed = keccak256(cheatcodes.ffi(inputs1));

    // set timestamp
    cheatcodes.warp(uint256(seed));

    // mint
    bibos.mint();

    // handle tokenUri
    string[] memory inputs2 = new string[](2);
    inputs2[0] = 'scripts/output.sh';
    inputs2[1] = bibos.tokenURI(0);
    cheatcodes.ffi(inputs2);
  }
}
