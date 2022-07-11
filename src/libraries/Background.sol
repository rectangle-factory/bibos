// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {SVG} from "./SVG.sol";

library Background {
    function render(bytes32 _seed) internal pure returns (string memory) {
        return
            SVG.element(
                "rect",
                SVG.rectAttributes({
                    _width: "100%",
                    _height: "100%",
                    _fill: Palette.backgroundFill(_seed),
                    _attributes: ""
                })
            );
    }
}
