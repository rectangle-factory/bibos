// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";

import {PointsUtil} from "dev/PointsUtil.sol";

contract encode_points is Script {
    function getBody() public pure returns (bytes memory) {
        return PointsUtil.getBody();
    }

    // function runGlintsAscii() public pure returns (bytes memory) {
    //     return PointsUtil.getAllGlintsAscii();
    // }

    function getGlints() public pure returns (bytes memory) {
        return PointsUtil.getGlints();
    }

    function getMotes() public pure returns (bytes memory) {
        return PointsUtil.getMotes();
    }
}
