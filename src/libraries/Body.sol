// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Data} from "./Data.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Body {
    /*//////////////////////////////////////////////////////////////
                                 RENDER
    //////////////////////////////////////////////////////////////*/

    function render(bytes32 _seed) internal pure returns (string memory) {
        string memory result = "";
        string[7] memory radii = ["64", "64", "64", "56", "48", "32", "24"];
        uint256 bodySeed = uint256(keccak256(abi.encodePacked(_seed, "body")));

        string memory background = Palette.background(_seed);
        result = _addBodyBackground(result, background);

        uint256 length = Data.length;
        for (uint8 i = 0; i < 7; i++) {
            string memory radius = radii[i];
            string memory fill = Palette.body(_seed, i);

            string memory dur = Data.shortTimes(bodySeed);
            bodySeed /= length;

            string[2] memory coords = (i == 0) ? ["150", "150"] : Data.bodyPoints(bodySeed);
            bodySeed /= length;

            string memory reverse = bodySeed % 2 == 0 ? 'keyPoints="1;0" keyTimes="0;1" ' : "";
            bodySeed /= 2;

            result = _addBodyCircle(result, radius, coords, fill, dur, reverse);
        }

        return string.concat('<g filter="url(#bibo-blur)" shape-rendering="optimizeSpeed">', result, "</g>");
    }

    /*//////////////////////////////////////////////////////////////
                                INTERNAL
    //////////////////////////////////////////////////////////////*/

    function _addBodyCircle(
        string memory _result,
        string memory _radius,
        string[2] memory _coords,
        string memory _fill,
        string memory _dur,
        string memory _reverse
    ) internal pure returns (string memory) {
        string memory mixMode = "lighten";
        string memory mpath = '<mpath xlink:href="#bibo-jitter-lg"/>';
        string memory opacity = "1";

        return
            string.concat(
                _result,
                SVG.openCircle(_radius, _coords, mixMode, _fill, opacity),
                SVG.animateMotion(_reverse, _dur, "linear", mpath),
                "</circle>"
            );
    }

    function _addBodyBackground(string memory _result, string memory _fill) internal pure returns (string memory) {
        return string.concat(_result, SVG.rect("100%", "100%", _fill));
    }
}
