// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Glints {
    uint256 constant GLINT_COUNT = 16;

    enum GlintType {
        NONE,
        FLOATING,
        RISING,
        FALLING
    }

    function render(bytes32 _seed) external pure returns (string memory) {
        string memory result = "";
        Palette.Refractivity refractivity = Palette.getRefractivity(_seed);
        string[5] memory opacities = refractivity == Palette.Refractivity.LIGHT
            ? ["0.3", "0.4", "0.5", "0.6", "0.7"]
            : ["0.6", "0.7", "0.8", "0.9", "1.0"];
        string memory mixMode = "lighten";
        string memory fill = "white";

        GlintType glintType = getGlintType(_seed);
        if (glintType == GlintType.NONE) return "";

        for (uint8 i = 0; i < GLINT_COUNT; i++) {
            uint256 glintSeed = uint256(keccak256(abi.encodePacked(_seed, "glint", i)));

            string memory dur = Times.long(glintSeed);
            glintSeed = glintSeed / Times.length;
            string[2] memory coords = Points.glint(glintSeed);
            glintSeed = glintSeed / Points.length;
            string memory radius = glintSeed % 2 == 0 ? "1" : "2";
            glintSeed = glintSeed / 2;
            string memory opacity = opacities[glintSeed % opacities.length];
            glintSeed /= opacities.length;

            if (glintType == GlintType.FLOATING) {
                string memory reverse = glintSeed % 2 == 0 ? "keyPoints='1;0' keyTimes='0;1'" : "";
                result = addFloatingGlint(result, radius, coords, mixMode, fill, opacity, dur, reverse);
            } else if (glintType == GlintType.RISING) result = addRisingGlint(result, radius, coords, mixMode, fill, opacity, dur);
            else if (glintType == GlintType.FALLING) {
                result = addFallingGlint(result, radius, coords, mixMode, fill, opacity, dur);
            }
        }

        return string.concat("<g>", result, "</g>");
    }

    function getGlintType(bytes32 _seed) public pure returns (GlintType) {
        uint256 glintTypeSeed = uint256(keccak256(abi.encodePacked(_seed, "glintType"))) % 100;

        if (glintTypeSeed % 100 < 20) return GlintType.FLOATING;
        if (glintTypeSeed % 100 < 35) return GlintType.RISING;
        if (glintTypeSeed % 100 < 40) return GlintType.FALLING;
        return GlintType.NONE;
    }

    function addRisingGlint(
        string memory _result,
        string memory _radius,
        string[2] memory _coords,
        string memory _mixMode,
        string memory _fill,
        string memory _opacity,
        string memory _dur
    ) internal pure returns (string memory) {
        return
            string.concat(
                _result,
                '<g transform="translate(0,25)">',
                SVG.circle(_radius, _coords, _mixMode, _fill, _opacity),
                animateTransform(_dur, "-100"),
                SVG.animate(_dur),
                "</circle>",
                "</g>"
            );
    }

    function addFloatingGlint(
        string memory _result,
        string memory _radius,
        string[2] memory _coords,
        string memory _mixMode,
        string memory _fill,
        string memory _opacity,
        string memory _dur,
        string memory _reverse
    ) internal pure returns (string memory) {
        return
            string.concat(
                _result,
                SVG.circle(_radius, _coords, _mixMode, _fill, _opacity),
                SVG.animateMotion(_reverse, _dur, "paced", '<mpath xlink:href="#bibo-jitter-sm"/>'),
                "</circle>"
            );
    }

    function addFallingGlint(
        string memory _result,
        string memory _radius,
        string[2] memory _coords,
        string memory _mixMode,
        string memory _fill,
        string memory _opacity,
        string memory _dur
    ) internal pure returns (string memory) {
        return
            string.concat(
                _result,
                '<g transform="translate(0,-25)">',
                SVG.circle(_radius, _coords, _mixMode, _fill, _opacity),
                animateTransform(_dur, "100"),
                SVG.animate(_dur),
                "</circle>",
                "</g>"
            );
    }

    function animateTransform(string memory _dur, string memory _to) internal pure returns (string memory) {
        return
            string.concat(
                "<animateTransform ",
                'attributeName="transform" ',
                "dur=",
                Util.quote(_dur),
                'repeatCount="indefinite" ',
                'type="translate" ',
                'additive="sum" ',
                'from="0 0" ',
                'to="0 ',
                _to,
                '" ',
                "/>"
            );
    }
}
