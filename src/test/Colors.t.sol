// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../Libraries/Colors.sol";

contract ColorsTest is DSTest {
  function setUp() public {}

  function testBodyLight() public {
    assertEq(Colors.getBodyLight(0), "#d5a8bf");
    assertEq(Colors.getBodyLight(63), "#cc8880");
  }

  function testGetBodyDark() public {
    assertEq(Colors.getBodyDark(0), "#5b301c");
    assertEq(Colors.getBodyDark(63), "#9d4910");
  }

  function testGetBgLight() public {
    assertEq(Colors.getBgLight(0), "#020406");
    assertEq(Colors.getBgLight(63), "#100126");
  }

  function testGetBgDark() public {
    assertEq(Colors.getBgDark(0), "#f1f0fe");
    assertEq(Colors.getBgDark(63), "#e4e5fd");
  }
}
