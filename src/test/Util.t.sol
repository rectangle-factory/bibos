// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test} from "forge-std/Test.sol";
import {Util} from "src/libraries/Util.sol";

contract UtilTest is Test {
    function setUp() public {}

    function testStringToUint256() public {
        assertEq(Util.stringToUint256("1"), 1);
    }

    function testUint256ToString(uint256 _x) public {
        string memory str = Util.uint256ToString(_x);
        assertEq(Util.stringToUint256(str), _x);
    }
}
