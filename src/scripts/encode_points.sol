// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";

import {PointsUtil} from "src/libraries/PointsUtil.sol";

contract encode_points is Script {
    function runBodyAscii() public pure returns (bytes memory) {
        return PointsUtil.getAllBodyAscii();
    }

    function runBodyNumeric() public pure returns (bytes memory) {
        return PointsUtil.getAllBodyNumeric();
    }

    // function runGlintsAscii() public pure returns (bytes memory) {
    //     return PointsUtil.getAllGlintsAscii();
    // }

    function runGlintsNumeric() public pure returns (bytes memory) {
        return PointsUtil.getAllGlintsNumeric();
    }

    function runMotesAscii() public pure returns (bytes memory) {
        return PointsUtil.getAllMotesAscii();
    }

    function runMotesNumeric() public pure returns (bytes memory) {
        return PointsUtil.getAllMotesNumeric();
    }
}
