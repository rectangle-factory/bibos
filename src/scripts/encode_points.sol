// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";

import {PointsUtil} from "dev/PointsUtil.sol";

contract encode_points is Script {
    function encodeAll()
        public
        pure
        returns (
            bytes memory body,
            bytes memory glints,
            bytes memory motes
        )
    {
        return (PointsUtil.getBody(), PointsUtil.getGlints(), PointsUtil.getMotes());
    }
}
