// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../Color.sol";

contract ColorTest is DSTest {
  function setUp() public {}

  function testBodyLight() public {
    assertEq(Color.getBodyLight(0), "#d5a8bf");
    assertEq(Color.getBodyLight(bytes1(uint8(63))), "#cc8880");
  }

  function testGetBodyDark() public {
    assertEq(Color.getBodyDark(0), "#5b301c");
    assertEq(Color.getBodyDark(63), "#9d4910");
  }

  function testGetBgLight() public {
    assertEq(Color.getBgLight(0), "#020406");
    assertEq(Color.getBgLight(63), "#100126");
  }

  function testGetBgDark() public {
    assertEq(Color.getBgDark(0), "#f1f0fe");
    assertEq(Color.getBgDark(63), "#e4e5fd");
  }
}
