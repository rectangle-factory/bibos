// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test} from "forge-std/Test.sol";
import {PointsUtil} from "dev/PointsUtil.sol";
import {Data} from "libraries/Data.sol";
import {PointsUncompressed} from "dev/PointsUncompressed.sol";

contract PointsTest is Test {
    function setUp() public {}

    function testPointsBody(uint8 _i) public {
        vm.assume(_i < 64);
        string[2] memory body1 = Data.bodyPoints(_i);
        string[2] memory body2 = PointsUncompressed.body(_i);

        assertEq(body1[0], body2[0]);
        assertEq(body1[1], body2[1]);
    }

    function testPointsMotes(uint8 _i) public {
        vm.assume(_i < 64);
        string[2] memory mote1 = Data.motePoints(_i);
        string[2] memory mote2 = PointsUncompressed.mote(_i);

        assertEq(mote1[0], mote2[0]);
        assertEq(mote1[1], mote2[1]);
    }

    function testPointsGlints(uint8 _i, uint8 _j) public {
        vm.assume(_i < 64);
        uint256 j = _j % 3;
        string[2][3] memory glint1 = Data.glintPoints(_i);
        string[2][3] memory glint2 = PointsUncompressed.glints(_i);

        assertEq(glint1[j][0], glint2[j][0]);
        assertEq(glint1[j][1], glint2[j][1]);
    }
}
