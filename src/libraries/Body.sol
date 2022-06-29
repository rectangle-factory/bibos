// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette, DensityType, PolarityType} from "./Palette.sol";
import {Traits} from "./Traits.sol";
import {Data} from "./Data.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Body {
    function render(bytes32 _seed) internal pure returns (string memory) {
        string memory result = "";

        string[7] memory radii = ["64", "64", "64", "56", "48", "32", "24"];

        uint256 bodySeed = uint256(keccak256(abi.encodePacked(_seed, "body")));

        string memory backgroundFill = Palette.getBackgroundFill(_seed);
        result = addBodyBackground(result, backgroundFill);
        uint256 length = Data.length;
        for (uint8 i = 0; i < 7; i++) {
            string memory radius = radii[i];
            string memory fill = Palette.getBodyFill(_seed, i);

            string memory dur = Data.shortTimes(bodySeed);
            bodySeed /= length;

            string[2] memory coords = (i == 0) ? ["150", "150"] : Data.bodyPoints(bodySeed);
            bodySeed /= length;

            string memory reverse = bodySeed % 2 == 0 ? 'keyPoints="1;0" keyTimes="0;1" ' : "";
            bodySeed /= 2;

            string memory mixBlendMode = Traits.getPolarityType(_seed) == PolarityType.POSITIVE
                ? "lighten"
                : "multiply";

            result = addBodyCircle(result, radius, coords, fill, dur, reverse, mixBlendMode);
        }

        return string.concat('<g filter="url(#bibo-blur)" shape-rendering="optimizeSpeed">', result, "</g>");
    }

    function addBodyCircle(
        string memory _result,
        string memory _radius,
        string[2] memory _coords,
        string memory _fill,
        string memory _dur,
        string memory _reverse,
        string memory _mixBlendMode
    ) internal pure returns (string memory) {
        string memory mpath = '<mpath xlink:href="#bibo-jitter-lg"/>';
        string memory opacity = "1";

        return
            string.concat(
                _result,
                SVG.circle(_radius, _coords, _mixBlendMode, _fill, opacity),
                SVG.animateMotion(_reverse, _dur, "linear", mpath),
                "</circle>"
            );
    }

    function addBodyBackground(string memory _result, string memory _fill) internal pure returns (string memory) {
        return string.concat(_result, SVG.rect("100%", "100%", _fill));
    }
}
