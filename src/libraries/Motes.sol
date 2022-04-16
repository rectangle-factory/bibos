// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Motes {
    function getMoteCount(bytes32 _seed) internal pure returns (uint256) {
        uint256 moteSeed = uint256(keccak256(abi.encodePacked(_seed, "mote"))) % 100;

        if (moteSeed % 100 < 1) return 3;
        if (moteSeed % 100 < 5) return 2;
        if (moteSeed % 100 < 35) return 1;
        return 0;
    }

    function render(bytes32 _seed) internal pure returns (string memory) {
        string memory result = "";
        string memory mixMode = "lighten";
        string memory fill = "white";
        uint256 moteSeed = uint256(keccak256(abi.encodePacked(_seed, "mote"))) % 100;
        string memory reverseRotate = moteSeed % 2 == 0 ? "from='0 0 0' to='360 0 0'" : "from='360 0 0' to='0 0 0'";
        string memory reverse = moteSeed % 2 == 0 ? "keyPoints='1;0' keyTimes='0;1'" : "";
        string memory radius = "10";
        uint256 moteCount = getMoteCount(_seed);
        string memory durationLong = Times.long(moteSeed);
        Palette.Refractivity refractivity = Palette.getRefractivity(_seed);
        string[5] memory opacities = refractivity == Palette.Refractivity.LIGHT
            ? ["0.3", "0.4", "0.5", "0.6", "0.7"]
            : ["0.6", "0.7", "0.8", "0.9", "1.0"];
        string memory opacity = opacities[moteSeed % opacities.length];
        moteSeed /= opacities.length;

        for (uint8 index = 0; index < moteCount; index++) {
            result = addMote(result, radius, mixMode, fill, durationLong, reverseRotate, reverse, opacity);
        }

        return string.concat("<g id='motes'>", result, "</g>");
    }

    function addMote(
        string memory _result,
        string memory _radius,
        string memory _mixMode,
        string memory _fill,
        string memory _durationLong,
        string memory _reverseRotate,
        string memory _reverse,
        string memory _opacity
    ) internal pure returns (string memory) {
        return
            string.concat(
                _result,
                '<g transform="translate(0,50)">',
                "<g>",
                SVG.circle(_radius, ["0", "0"], _mixMode, _fill, "0.5"),
                "</circle>",
                "<path fill-opacity=",
                Util.quote(_opacity),
                'fill="white" style="mix-blend-mode:normal" fill-rule="evenodd" clip-rule="evenodd" d="M2.60676 11.4891C2.49095 12.4964 1.95054 13 0.985526 13C0.580218 13 0.223162 12.8644 -0.0856447 12.5932C-0.39445 12.322 -0.577804 11.9831 -0.635705 11.5763C-0.86731 9.71671 -1.10856 8.28329 -1.35947 7.27603C-1.59107 6.2494 -1.97708 5.47458 -2.51749 4.95157C-3.0386 4.42857 -3.85887 4.02179 -4.97829 3.73123C-6.07841 3.42131 -7.62244 3.05327 -9.61037 2.62712C-10.5368 2.43341 -11 1.89104 -11 0.999999C-11 0.593219 -10.8649 0.234868 -10.5947 -0.0750589C-10.3245 -0.384987 -9.98673 -0.569006 -9.58142 -0.627117C-7.61279 -0.878934 -6.07841 -1.13075 -4.97829 -1.38257C-3.87817 -1.63438 -3.0579 -2.03147 -2.51749 -2.57385C-1.97708 -3.11622 -1.59107 -3.92978 -1.35947 -5.01453C-1.10856 -6.09927 -0.86731 -7.60048 -0.635705 -9.51816C-0.500603 -10.5061 0.0398083 -11 0.985526 -11C1.95054 -11 2.49095 -10.4964 2.60676 -9.4891C2.83836 -7.64891 3.06997 -6.2155 3.30157 -5.18886C3.53317 -4.1816 3.91918 -3.42615 4.45959 -2.92252C5 -2.41889 5.82992 -2.0121 6.94934 -1.70218C8.06876 -1.41162 9.61279 -1.05327 11.5814 -0.627117C12.5271 -0.414042 13 0.128328 13 0.999999C13 1.92978 12.4692 2.47215 11.4077 2.62712C9.47768 2.91767 7.97226 3.19855 6.89144 3.46973C5.81062 3.74092 5 4.1477 4.45959 4.69007C3.91918 5.23244 3.53317 6.03632 3.30157 7.10169C3.06997 8.16707 2.83836 9.62954 2.60676 11.4891Z">',
                '<animateTransform attributeName="transform" attributeType="XML" type="scale" additive="sum" beg="0s" dur="1s" values="0.85; 1.25; 0.85" repeatCount="indefinite" />',
                "</path>",
                // animateTransform(_reverseRotate),
                "</g>",
                SVG.animateMotion(_reverse, _durationLong, "linear", '<mpath href="#jitter-lg" />'),
                "</g>"
            );
    }

    function animateTransform(string memory _reverseRotate) internal pure returns (string memory) {
        return
            string.concat(
                '<animateTransform attributeName="transform" attributeType="XML" type="rotate" ',
                _reverseRotate,
                'dur="1s" ',
                'repeatCount="indefinite" ',
                "/>"
            );
    }
}
