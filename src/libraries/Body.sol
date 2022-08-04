// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette, DensityType, PolarityType} from "./Palette.sol";
import {Traits} from "./Traits.sol";
import {Data} from "./Data.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Body {
    /*//////////////////////////////////////////////////////////////
                                 RENDER
    //////////////////////////////////////////////////////////////*/

    function render(bytes32 _seed, uint256 _tokenId) internal pure returns (string memory) {
        string memory bodyGroupChildren;
        string[7] memory radii = ["64", "64", "64", "56", "48", "32", "24"];

        string memory backgroundFill = Palette.backgroundFill(_seed, _tokenId);
        string memory mixBlendMode = Traits.polarityType(_seed) == PolarityType.POSITIVE ? "lighten" : "multiply";

        bodyGroupChildren = string.concat(bodyGroupChildren, _bodyBackground(backgroundFill));

        uint256 length = Data.length;
        // uint256 circlesCount = 7;

        for (uint8 i = 0; i < 7; i++) {
            uint256 bodySeed = uint256(keccak256(abi.encodePacked(_seed, "body", i)));
            string memory bodyFill = Palette.bodyFill(_seed, i, _tokenId);
            string memory bodyFill2 = Palette.bodyFill(_seed, i + 7, _tokenId);

            string memory radius = radii[i];

            string memory dur = Data.shortTimes(bodySeed);
            bodySeed /= length;

            string[2] memory coords = (i == 0) ? ["150", "150"] : Data.bodyPoints(bodySeed);
            bodySeed /= length;

            bool reverse = bodySeed % 2 == 0;
            bodySeed /= 2;

            string memory maybeGenesis = _tokenId == 0
                ? string.concat(
                    '<animate attributeName="fill" repeatCount="indefinite" values="',
                    bodyFill,
                    ";",
                    bodyFill2,
                    ";",
                    bodyFill,
                    '" dur="',
                    dur,
                    '"/>'
                )
                : "";

            bodyGroupChildren = string.concat(
                bodyGroupChildren,
                '<circle fill="',
                bodyFill,
                '" r="',
                radius,
                '" cx="',
                coords[0],
                '" cy="',
                coords[1],
                '" style="mix-blend-mode: ',
                mixBlendMode,
                '">',
                SVG.element("animateMotion", SVG.animateMotionAttributes(reverse, dur, ""), Data.mpathJitterLg()),
                maybeGenesis,
                "</circle>"
            );
        }
        return
            SVG.element(
                "g",
                string.concat(SVG.filterAttribute("bibo-blur"), 'shape-rendering="optimizeSpeed"'),
                bodyGroupChildren
            );
    }

    function _bodyBackground(string memory _fill) internal pure returns (string memory) {
        return
            SVG.element("rect", SVG.rectAttributes({_width: "100%", _height: "100%", _fill: _fill, _attributes: ""}));
    }
}
