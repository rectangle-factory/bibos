// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test} from "forge-std/Test.sol";
import {PointsUtil} from "src/libraries/PointsUtil.sol";
import {Points} from "src/libraries/Points.sol";
import {Points2} from "src/libraries/Points2.sol";

contract PointsTest is Test {
    function setUp() public {}

    function testPointsBodyAscii(uint8 _i) public {
        vm.assume(_i < 64);
        string[2] memory body1 = Points.body(_i);
        string[2] memory body2 = Points2.bodyAscii(_i);

        assertEq(body1[0], body2[0]);
        assertEq(body1[1], body2[1]);
    }

    function testPointsBodyUint(uint8 _i) public {
        vm.assume(_i < 64);
        string[2] memory body1 = Points.body(_i);
        string[2] memory body2 = Points2.bodyUint(_i);

        assertEq(body1[0], body2[0]);
        assertEq(body1[1], body2[1]);
    }

    function testPointsGlintsAscii(uint8 _i) public {
        vm.assume(_i < 64);
        string[2] memory glint1 = Points.glint(_i);
        string[2] memory glint2 = Points2.glintAscii(_i);

        assertEq(glint1[0], glint2[0]);
        assertEq(glint1[1], glint2[1]);
    }

    function testPointsGlintsUint(uint8 _i) public {
        vm.assume(_i < 64);
        string[2] memory glint1 = Points.glint(_i);
        string[2] memory glint2 = Points2.glintUint(_i);

        assertEq(glint1[0], glint2[0]);
        assertEq(glint1[1], glint2[1]);
    }

    function testPointsMotesAscii(uint8 _i, uint8 _j) public {
        vm.assume(_i < 64);
        vm.assume(_j < 3);

        string[2][3] memory mote1 = Points.motes(_i);
        string[2][3] memory mote2 = Points2.motesAscii(_i);

        assertEq(mote1[_j][0], mote2[_j][0]);
        assertEq(mote1[_j][1], mote2[_j][1]);
    }

    function testPointsMotesUint(uint8 _i, uint8 _j) public {
        vm.assume(_i < 64);
        uint256 j = _j % 3;
        string[2][3] memory mote1 = Points.motes(_i);
        string[2][3] memory mote2 = Points2.motesUint(_i);

        assertEq(mote1[j][0], mote2[j][0]);
        assertEq(mote1[j][1], mote2[j][1]);
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
