// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Eyes {
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
        uint256 eyeSeed = uint256(keccak256(abi.encodePacked(_seed, "eye"))) % 100;

        if (eyeSeed % 100 < 25) return EyeType.OPEN;
        if (eyeSeed % 100 < 50) return EyeType.SMILEY;
        if (eyeSeed % 100 < 65) return EyeType.WINK;
        if (eyeSeed % 100 < 75) return EyeType.SLEEPY;
        if (eyeSeed % 100 < 83) return EyeType.CLOVER;
        if (eyeSeed % 100 < 89) return EyeType.DIZZY;
        if (eyeSeed % 100 < 94) return EyeType.HEART;
        if (eyeSeed % 100 < 97) return EyeType.WINCE;
        if (eyeSeed % 100 < 99) return EyeType.CYCLOPS;
        return EyeType.STAR;
    }
}
