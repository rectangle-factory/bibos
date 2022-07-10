// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette, DensityType, PolarityType} from "./Palette.sol";
import {Traits} from "./Traits.sol";
import {Data} from "./Data.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Body {
    function render(bytes32 _seed) internal pure returns (string memory) {
        string memory bodyGroupChildren;
        string[7] memory radii = ["64", "64", "64", "56", "48", "32", "24"];

        string memory backgroundFill = Palette.backgroundFill(_seed);
        string memory mixBlendMode = Traits.polarityType(_seed) == PolarityType.POSITIVE ? "lighten" : "multiply";

        bodyGroupChildren = string.concat(bodyGroupChildren, _bodyBackground(backgroundFill));

        uint256 length = Data.length;
        // uint256 circlesCount = 7;

        for (uint8 i = 0; i < 7; i++) {
            uint256 bodySeed = uint256(keccak256(abi.encodePacked(_seed, "body", i)));
            string memory bodyFill = Palette.bodyFill(_seed, i);
            string memory radius = radii[i];

            string memory dur = Data.shortTimes(bodySeed);
            bodySeed /= length;

            string[2] memory coords = (i == 0) ? ["150", "150"] : Data.bodyPoints(bodySeed);
            bodySeed /= length;

            bool reverse = bodySeed % 2 == 0;
            bodySeed /= 2;

            bodyGroupChildren = string.concat(
                bodyGroupChildren,
                _bodyCircle(radius, coords, bodyFill, dur, reverse, mixBlendMode)
            );
        }
        return
            SVG.element(
                "g",
                string.concat(SVG.filterAttribute("bibo-blur"), 'shape-rendering="optimizeSpeed"'),
                bodyGroupChildren
            );
    }

    function _bodyCircle(
        string memory _radius,
        string[2] memory _coords,
        string memory _fill,
        string memory _dur,
        bool _reverse,
        string memory _mixBlendMode
    ) internal pure returns (string memory) {
        string memory opacity = "1";
        return
            SVG.element(
                "circle",
                SVG.circleAttributes(_radius, _coords, _mixBlendMode, _fill, opacity, ""),
                SVG.animateMotion(_reverse, _dur, "linear", Data.mpathJitterLg())
            );
    }

    function _bodyBackground(string memory _fill) internal pure returns (string memory) {
        return
            SVG.element("rect", SVG.rectAttributes({_width: "100%", _height: "100%", _fill: _fill, _attributes: ""}));
    }
}
