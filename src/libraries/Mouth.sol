// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Mouth {
    enum MouthType {
        SMILE,
        MEDIUM_SMILE,
        SMALL_SMILE,
        FLAT,
        FROWN,
        GRIN,
        SMOOCH,
        SMIRK
    }

    function getMouthType(bytes32 _seed) internal pure returns (MouthType) {
        uint256 mouthTypeSeed = uint256(keccak256(abi.encodePacked(_seed, "mouthType"))) % 100;

        if (mouthTypeSeed % 100 < 30) return MouthType.SMILE;
        if (mouthTypeSeed % 100 < 60) return MouthType.MEDIUM_SMILE;
        if (mouthTypeSeed % 100 < 80) return MouthType.SMALL_SMILE;
        if (mouthTypeSeed % 100 < 90) return MouthType.FLAT;
        if (mouthTypeSeed % 100 < 94) return MouthType.FROWN;
        if (mouthTypeSeed % 100 < 97) return MouthType.GRIN;
        if (mouthTypeSeed % 100 < 99) return MouthType.SMOOCH;
        return MouthType.SMIRK;
    }
}
