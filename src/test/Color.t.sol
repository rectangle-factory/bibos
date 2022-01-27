// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../Libraries/Color.sol";

contract ColorTest is DSTest {
  bytes1 constant BYTES_1_SIXTY_THREE = bytes1(uint8(63));

  function setUp() public {}

  function testBodyLight() public {
    assertEq(Color.getBodyLight(0), "#d5a8bf");
    assertEq(Color.getBodyLight(BYTES_1_SIXTY_THREE), "#cc8880");
  }

  function testGetBodyDark() public {
    assertEq(Color.getBodyDark(0), "#5b301c");
    assertEq(Color.getBodyDark(BYTES_1_SIXTY_THREE), "#9d4910");
  }

  function testGetBgLight() public {
    assertEq(Color.getBgLight(0), "#020406");
    assertEq(Color.getBgLight(BYTES_1_SIXTY_THREE), "#100126");
  }

  function testGetBgDark() public {
    assertEq(Color.getBgDark(0), "#f1f0fe");
    assertEq(Color.getBgDark(BYTES_1_SIXTY_THREE), "#e4e5fd");
  }
}
