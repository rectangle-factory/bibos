// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test} from "forge-std/Test.sol";
import {PointsUtil} from "dev/PointsUtil.sol";
import {Data} from "libraries/Data.sol";
import {PaletteUncompressed} from "dev/PaletteUncompressed.sol";
import {Palette} from "libraries/Palette.sol";

contract PaletteTest is Test {
    function setUp() public {}

    function testLightestPalette(uint8 _i) public {
        vm.assume(_i < 64);
        string memory palette1 = Palette._lightest(_i);
        string memory palette2 = PaletteUncompressed.lightest(_i);

        assertEq(palette1, palette2);
    }

    function testLightPalette(uint8 _i) public {
        vm.assume(_i < 64);
        string memory palette1 = Palette._light(_i);
        string memory palette2 = PaletteUncompressed.light(_i);

        assertEq(palette1, palette2);
    }

    function testDarkestPalette(uint8 _i) public {
        vm.assume(_i < 64);
        string memory palette1 = Palette._darkest(_i);
        string memory palette2 = PaletteUncompressed.darkest(_i);

        assertEq(palette1, palette2);
    }
}
