// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

<<<<<<< HEAD
import {Palette} from "./Palette.sol";
=======
import {Color} from "./Color.sol";
>>>>>>> main
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Glints {
<<<<<<< HEAD
    uint256 constant GLINT_COUNT = 16;

    enum GlintType {
        NONE,
        FLOATING,
        RISING,
        FALLING
    }

    function render(bytes32 _seed) internal pure returns (string memory) {
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

    function getGlintType(bytes32 _seed) internal pure returns (GlintType) {
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
                SVG.animateMotion(_reverse, _dur, "paced", '<mpath xlink:href="#jitter-sm"/>'),
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

=======
    function render(bytes32 _data) internal pure returns (string memory result) {
        Color.CM cm = Color.CM.DARK;
        string memory mixMode = cm == Color.CM.LIGHT ? "lighten" : "color-burn";
        string memory fill = cm == Color.CM.LIGHT ? "white" : "black";

        bytes1 value = _data[0];
        // string[4] memory glintTypes = ['RISING', 'FLOATING', 'FALLING', 'NONE'];
        // string glintType = glintTypes[value % 4];

        uint8 glintCount = 16;

        for (uint8 index = 0; index < glintCount; index++) {
            // get the next byte in data
            value = _data[index];

            string memory dur = Times.long(value);
            string[2] memory coords = Points.glint(value);
            string memory radius = value & 0x01 == 0 ? "1" : "2";
            string memory rev = value & 0x01 == 0 ? "keyPoints='1;0' keyTimes='0;1'" : "";

            // glintType == RISING
            if (value & 0x11 == 0x00) {
                result = string.concat(
                    result,
                    '<g transform="translate(0,50)">',
                    SVG.circle(radius, coords, mixMode, fill, "0.5"),
                    animateTransform(dur, "-100"),
                    SVG.animate(dur),
                    "</circle>",
                    "</g>"
                );
            }

            // glintType == FLOATING
            if (value & 0x11 == 0x01) {
                result = string.concat(
                    result,
                    SVG.circle(radius, coords, mixMode, fill, "0.75"),
                    SVG.animateMotion(rev, dur, "paced", '<mpath xlink:href="#jitter-sm"/>'),
                    "</circle>"
                );
            }

            // glintType == FALLING
            if (value & 0x11 == 0x10) {
                result = string.concat(
                    result,
                    "<g>",
                    SVG.circle(radius, coords, mixMode, fill, "0.5"),
                    animateTransform(dur, "100"),
                    SVG.animate(dur),
                    "</circle>",
                    "</g>"
                );
            }
        }
    }

>>>>>>> main
    function animateTransform(string memory _dur, string memory _to) internal pure returns (string memory) {
        return
            string.concat(
                "<animateTransform ",
                'attributeType="XML" ',
                'attributeName="transform" ',
                "dur=",
                Util.quote(_dur),
                'repeatCount="indefinite" ',
                'calcMode="paced" ',
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
