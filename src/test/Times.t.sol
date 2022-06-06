// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test} from "forge-std/test.sol";
import {TimesUtil} from "src/libraries/TimesUtil.sol";
import {Times} from "src/libraries/Times.sol";
import {Times2} from "src/libraries/Times2.sol";

contract TimesTest is Test {
    function setUp() public {}

    function testTimes2Short(uint8 _i) public {
        vm.assume(_i < 64);
        assertEq(Times2.short(_i), Times.short(_i));
    }

    function testTimes2Long(uint8 _i) public {
        vm.assume(_i < 64);
        string memory timesLong = Times.long(_i);
        if (bytes(timesLong).length < 5) timesLong = string.concat("0", timesLong);
        assertEq(Times2.long(_i), timesLong);
    }

    // function testBodyDark() public {
    //     assertEq(Color.bodyDark(0), "#5b301c");
    //     assertEq(Color.bodyDark(BYTES_1_SIXTY_THREE), "#9d4910");
    // }

    // function testBgLight() public {
    //     assertEq(Color.bgLight(0), "#020406");
    //     assertEq(Color.bgLight(BYTES_1_SIXTY_THREE), "#100126");
    // }

    // function testBgDark() public {
    //     assertEq(Color.bgDark(0), "#f1f0fe");
    //     assertEq(Color.bgDark(BYTES_1_SIXTY_THREE), "#e4e5fd");
    // }
}
