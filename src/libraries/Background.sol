// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {SVG} from "./SVG.sol";

library Background {
    function render(bytes32 _seed) internal pure returns (string memory) {
        string memory fill = Palette.getBackgroundFill(_seed);
        return SVG.rect("100%", "100%", fill);
    }
}
