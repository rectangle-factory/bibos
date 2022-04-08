// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Eye {
    enum EyeType {
        OPEN,
        SMILEY,
        WINK,
        SLEEPY,
        CLOVER,
        DIZZY,
        HEART,
        WINCE,
        CYCLOPS,
        STAR
    }

    function getEyeType(bytes32 _seed) internal pure returns (string memory) {
        uint256 glintTypeSeed = uint256(keccak256(abi.encodePacked(_seed, "eyeType"))) % 100;

        if (glintTypeSeed % 100 < 1) return "Star";
        if (glintTypeSeed % 100 < 3) return "Cyclops";
        if (glintTypeSeed % 100 < 6) return "Wince";
        if (glintTypeSeed % 100 < 11) return "Heart";
        if (glintTypeSeed % 100 < 17) return "Dizzy";
        if (glintTypeSeed % 100 < 25) return "Clover";
        if (glintTypeSeed % 100 < 35) return "Sleepy";
        if (glintTypeSeed % 100 < 50) return "Wink";
        if (glintTypeSeed % 100 < 5) return "Smiley";
        if (glintTypeSeed % 100 < 1) return "Open";

        return 0;
    }
}
