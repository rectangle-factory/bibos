// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test} from "forge-std/Test.sol";
import {TimesUncompressed} from "dev/TimesUncompressed.sol";
import {Data} from "libraries/Data.sol";

contract TimesTest is Test {
    function setUp() public {}

    function testTimesShort(uint8 _i) public {
        vm.assume(_i < 64);
        assertEq(TimesUncompressed.short(_i), Data.shortTimes(_i));
    }

    function testTimesLong(uint8 _i) public {
        vm.assume(_i < 64);
        assertEq(TimesUncompressed.long(_i), Data.longTimes(_i));
    }
}
