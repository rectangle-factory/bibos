// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test} from "forge-std/Test.sol";
import {Util} from "src/libraries/Util.sol";

contract UtilTest is Test {
    function setUp() public {}

    function testAsciiToUint256() public {
        assertEq(Util.asciiToUint256("1"), 1);
    }

    function testUint256ToAscii(uint256 _x) public {
        string memory str = Util.uint256ToAscii(_x);
        assertEq(Util.asciiToUint256(str), _x);
    }
}
