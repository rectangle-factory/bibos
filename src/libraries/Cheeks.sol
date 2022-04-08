// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Cheeks {
    enum CheekType {
        NONE,
        CIRCULAR,
        FRECKLES
    }

    function getCheekType(bytes32 _seed) internal pure returns (CheekType) {
        uint256 cheeksSeed = uint256(keccak256(abi.encodePacked(_seed, "cheeks"))) % 100;

        if (cheeksSeed % 100 < 70) return CheekType.NONE;
        if (cheeksSeed % 100 < 95) return CheekType.CIRCULAR;
        if (cheeksSeed % 100 < 100) return CheekType.FRECKLES;

        return 0;
    }
}
