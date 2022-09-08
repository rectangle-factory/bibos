// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";

import {PointsUtil} from "dev/PointsUtil.sol";

/// @title encode_points
/// @author Bumblebee Systems
contract encode_points is Script {
    function encodeAll()
        public
        pure
        returns (
            bytes memory body,
            bytes memory motes,
            bytes memory glints
        )
    {
        return (PointsUtil.getBody(), PointsUtil.getMotes(), PointsUtil.getGlints());
    }
}
