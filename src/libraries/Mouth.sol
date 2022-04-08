// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Mouth {
    function getGlintType(bytes32 _seed) internal pure returns (GlintType) {
        uint256 glintTypeSeed = uint256(keccak256(abi.encodePacked(_seed, "glintType"))) % 100;

        if (glintTypeSeed % 100 < 20) return GlintType.FLOATING;
        if (glintTypeSeed % 100 < 35) return GlintType.RISING;
        if (glintTypeSeed % 100 < 40) return GlintType.FALLING;
        return GlintType.NONE;
    }
}
