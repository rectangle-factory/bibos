// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Mote {
    function getMoteCount(bytes32 _seed) internal pure returns (uint256) {
        uint256 glintTypeSeed = uint256(keccak256(abi.encodePacked(_seed, "moteCount"))) % 100;

        if (glintTypeSeed % 100 < 1) return 3;
        if (glintTypeSeed % 100 < 5) return 2;
        if (glintTypeSeed % 100 < 35) return 1;
        return 0;
    }
}
