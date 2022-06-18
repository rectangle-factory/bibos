// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test} from "forge-std/Test.sol";
import {Util} from "src/libraries/Util.sol";
import {Util as DevUtil} from "src/dev/Util.sol";
import {PaletteUtil} from "src/dev/PaletteUtil.sol";

contract UtilTest is Test {
    function setUp() public {}

    function testStringToUint256() public {
        assertEq(Util.stringToUint256("1"), 1);
    }

    function testUint256ToString(uint256 _x) public {
        string memory str = Util.uint256ToString(_x);
        assertEq(Util.stringToUint256(str), _x);
    }

    function testHexStringToUint256() public {
        string memory str = "01";
        assertEq(DevUtil.hexStringToUint256(str), 1);
        str = "10";
        assertEq(DevUtil.hexStringToUint256(str), 16);
    }

    function testHexStringToBytes() public {
        bytes memory result = hex"aa";
        assertEq(DevUtil.hexStringToBytes("aa"), result);
    }

    function testSlice7CharColor() public {
        string memory str = "#010101";
        assertEq(PaletteUtil.slice7CharColor(str), "010101");
    }
}
