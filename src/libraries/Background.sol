// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "libraries/Palette.sol";
import {SVG} from "libraries/SVG.sol";

/// @title Background
/// @author Bumblebee Systems
library Background {
    /*//////////////////////////////////////////////////////////////
                                 RENDER
    //////////////////////////////////////////////////////////////*/

    function render(bytes32 _seed, uint256 _tokenId) internal pure returns (string memory) {
        return
            SVG.element(
                "rect",
                SVG.rectAttributes({
                    _width: "100%",
                    _height: "100%",
                    _fill: Palette.backgroundFill(_seed, _tokenId),
                    _attributes: ""
                })
            );
    }
}
