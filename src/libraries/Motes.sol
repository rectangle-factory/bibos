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
    FALLING
}

library Motes {
    uint256 constant GLINT_COUNT = 16;

    function render(bytes32 _seed) internal pure returns (string memory) {
        string memory motesChildren;

        string memory mixMode = "lighten";
        string memory fill = "white";

        MoteType moteType = Traits.moteType(_seed);
        if (moteType == MoteType.NONE) return "";

        for (uint8 i = 0; i < GLINT_COUNT; i++) {
            uint256 moteSeed = uint256(keccak256(abi.encodePacked(_seed, "mote", i)));

            string memory dur = Data.longTimes(moteSeed);
            moteSeed = moteSeed / Data.length;
            string[2] memory coords = Data.motePoints(moteSeed);
            moteSeed = moteSeed / Data.length;
            string memory radius = moteSeed % 2 == 0 ? "1" : "2";
            moteSeed = moteSeed / 2;
            string memory opacity = Palette.opacity(moteSeed, _seed);
            moteSeed /= Palette.opacityLength;

            if (moteType == MoteType.FLOATING) {
                bool reverse = moteSeed % 2 == 0;
                motesChildren = string.concat(
                    motesChildren,
                    _floatingMote(radius, coords, fill, opacity, mixMode, dur, reverse)
                );
            } else if (moteType == MoteType.RISING)
                motesChildren = string.concat(motesChildren, _risingMote(radius, coords, fill, opacity, mixMode, dur));
            else if (moteType == MoteType.FALLING) {
                motesChildren = string.concat(motesChildren, _fallingMote(radius, coords, fill, opacity, mixMode, dur));
            }
        }

        return SVG.element({_type: "g", _attributes: "", _children: motesChildren});
    }

    function _risingMote(
        string memory _radius,
        string[2] memory _coords,
        string memory _fill,
        string memory _opacity,
        string memory _mixMode,
        string memory _dur
    ) internal pure returns (string memory) {
        return
            SVG.element({
                _type: "g",
                _attributes: 'transform="translate(0,25)"',
                _children: SVG.element(
                    "circle",
                    SVG.circleAttributes(_radius, _coords, _fill, _opacity, _mixMode, ""),
                    _animateTransform(_dur, "-100"),
                    _animate(_dur)
                )
            });
    }

    function _floatingMote(
        string memory _radius,
        string[2] memory _coords,
        string memory _fill,
        string memory _opacity,
        string memory _mixMode,
        string memory _dur,
        bool _reverse
    ) internal pure returns (string memory) {
        return
            SVG.element(
                "circle",
                SVG.circleAttributes(_radius, _coords, _fill, _opacity, _mixMode, ""),
                SVG.element("animateMotion", SVG.animateMotionAttributes(_reverse, _dur, "paced"), Data.mpathJitterSm())
            );
    }

    function _fallingMote(
        string memory _radius,
        string[2] memory _coords,
        string memory _mixMode,
        string memory _fill,
        string memory _opacity,
        string memory _dur
    ) internal pure returns (string memory) {
        return
            SVG.element(
                "g",
                'transform="translate(0,-25)">',
                SVG.element(
                    "circle",
                    SVG.circleAttributes(_radius, _coords, _fill, _opacity, _mixMode, ""),
                    _animateTransform(_dur, "100"),
                    _animate(_dur)
                )
            );
    }

    function _animateTransform(string memory _dur, string memory _to) internal pure returns (string memory) {
        string memory attributes = string.concat(
            'attributeName="transform" ',
            "dur=",
            Util.quote(_dur),
            'repeatCount="indefinite" ',
            'type="translate" ',
            'additive="sum" ',
            'from="0 0" ',
            'to="0 ',
            _to,
            '"'
        );

        return SVG.element("animateTransform", attributes);
    }

    function _animate(string memory _dur) internal pure returns (string memory) {
        return
            SVG.element(
                "animate",
                string.concat(
                    'attributeName="opacity" ',
                    'values="0;1;0" ',
                    "dur=",
                    Util.quote(_dur),
                    'repeatCount="indefinite" '
                )
            );
    }
}
