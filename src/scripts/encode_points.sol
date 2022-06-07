// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";

import {PointsUtil} from "src/libraries/PointsUtil.sol";

contract enocode_times is Script {
    function runBody() public pure returns (bytes memory) {
        return PointsUtil.getAllBody();
    }

    function runGlint() public pure returns (bytes memory) {
        return PointsUtil.getAllGlints();
    }
}
