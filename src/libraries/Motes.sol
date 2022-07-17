// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Data} from "./Data.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";
import {Traits} from "./Traits.sol";

enum MoteType {
    NONE,
    FLOATING,
    RISING,
    FALLING,
    GLISTENING
}

library Motes {
    uint256 constant GLINT_COUNT = 20;

    function render(bytes32 _seed) internal pure returns (string memory) {
        string memory result;

        string memory mixMode = "lighten";
        string memory fill = "white";

        MoteType moteType = Traits.getMoteType(_seed);
        if (moteType == MoteType.NONE) return "";

        for (uint8 i = 0; i < GLINT_COUNT; i++) {
            uint256 moteSeed = uint256(keccak256(abi.encodePacked(_seed, "mote", i)));

            string memory dur = Data.longTimes(moteSeed);
            moteSeed = moteSeed / Data.length;
            string memory delay = Data.shorterTimes(moteSeed);
            moteSeed = moteSeed / Data.length;
            string[2] memory coords = Data.motePoints(moteSeed);
            moteSeed = moteSeed / Data.length;
            string memory radius = moteSeed % 2 == 0 ? "1" : "2";
            moteSeed = moteSeed / 2;
            string memory opacity = Palette.getOpacity(moteSeed, _seed);
            moteSeed /= Palette.opacityLength;
            string memory reverse = moteSeed % 2 == 0 ? "keyPoints='1;0' keyTimes='0;1'" : "";

            if (moteType == MoteType.FLOATING) {
                result = addFloatingMote(result, radius, coords, mixMode, fill, opacity, dur, reverse);
            } else if (moteType == MoteType.RISING)
                result = addRisingMote(result, radius, coords, mixMode, fill, opacity, dur);
            else if (moteType == MoteType.FALLING)
                result = addFallingMote(result, radius, coords, mixMode, fill, opacity, dur);
            else if (moteType == MoteType.GLISTENING)
                result = addGlisteningMote(result, radius, coords, mixMode, fill, opacity, dur, reverse, delay);
        }

        return string.concat("<g>", result, "</g>");
    }

    function addRisingMote(
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

    function addFloatingMote(
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

    function addFallingMote(
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

    function addGlisteningMote(
        string memory _result,
        string memory _radius,
        string[2] memory _coords,
        string memory _mixMode,
        string memory _fill,
        string memory _opacity,
        string memory _dur,
        string memory _reverse,
        string memory _delay
    ) internal pure returns (string memory) {
        return
            string.concat(
                _result,
                '<g opacity="0">',
                '<animate calcMode="spline" keyTimes="0; 0.5; 1" keySplines="0.4 0 0.4 1; 0.4 0 0.4 1" attributeName="opacity" values="0;1;0" dur="1.5s" begin="',
                _delay,
                '" repeatCount="indefinite" />',
                SVG.circle(_radius, _coords, _mixMode, _fill, _opacity),
                SVG.animateMotion(_reverse, _dur, "paced", '<mpath xlink:href="#bibo-jitter-sm"/>'),
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
