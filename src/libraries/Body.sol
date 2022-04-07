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

library Body {
<<<<<<< HEAD
    function render(bytes32 _seed) internal pure returns (string memory) {
        string memory result = "";

        string[7] memory radii = ["64", "64", "64", "56", "48", "32", "24"];

        uint256 bodySeed = uint256(keccak256(abi.encodePacked(_seed, "body")));

        string memory backgroundFill = Palette.getBackgroundFill(_seed);
        result = addBodyBackground(result, backgroundFill);

        for (uint8 i = 0; i < 7; i++) {
            string memory radius = radii[i];
            string memory fill = Palette.getBodyFill(_seed, i);

            string memory dur = Times.short(bodySeed);
            bodySeed /= Times.length;

            string[2] memory coords = (i == 0) ? ["150", "150"] : Points.body(bodySeed);
            bodySeed /= Points.length;

            string memory reverse = bodySeed % 2 == 0 ? 'keyPoints="1;0" keyTimes="0;1" ' : "";
            bodySeed /= 2;

            result = addBodyCircle(result, radius, coords, fill, dur, reverse);
        }

        return string.concat('<g filter="url(#blur)">', result, "</g>");
    }

    function addBodyCircle(
        string memory _result,
        string memory _radius,
        string[2] memory _coords,
        string memory _fill,
        string memory _dur,
        string memory _reverse
    ) internal pure returns (string memory) {
        string memory mixMode = "lighten";
        string memory mpath = '<mpath xlink:href="#jitter-lg"/>';
        string memory calcMode = "linear";
        string memory opacity = "1";

        return
            string.concat(
                _result,
                SVG.circle(_radius, _coords, mixMode, _fill, opacity),
                SVG.animateMotion(_reverse, _dur, calcMode, mpath),
                "</circle>"
            );
    }

    function addBodyBackground(string memory _result, string memory _fill) internal pure returns (string memory) {
        return string.concat(_result, SVG.rect("100%", "100%", _fill));
=======
    function render(bytes32 data) internal pure returns (string memory) {
        Color.CM cm = Color.CM.LIGHT;
        return
            string.concat(
                bodyBackground(cm, data[0]),
                " <!-- BODY --> ",
                '<g filter="url(#blur)">',
                bodyBackground(cm, data[0]),
                bodyCircle(cm, "64", data[1]),
                bodyCircle(cm, "56", data[2]),
                bodyCircle(cm, "48", data[3]),
                bodyCircle(cm, "48", data[4]),
                bodyCircle(cm, "32", data[5]),
                bodyCircle(cm, "32", data[6]),
                "</g>"
            );
    }

    function bodyCircle(
        Color.CM cm,
        string memory radius,
        bytes1 value
    ) internal pure returns (string memory) {
        string memory mixMode = cm == Color.CM.LIGHT ? "overlay" : "color-burn";
        string memory fill = cm == Color.CM.LIGHT ? Color.bodyLight(value) : Color.bodyDark(value);

        string memory dur = Times.short(value);
        string[2] memory coords = Points.body(value);

        // switch on first byte of val
        // equiv to val % 2 == 0
        string memory rev = value & 0x01 == 0 ? 'keyPoints="1;0" keyTimes="0;1" ' : "";

        return
            string.concat(
                SVG.circle(radius, coords, mixMode, fill, "1"),
                SVG.animateMotion(rev, dur, "linear", '<mpath xlink:href="#jitter-lg"/>'),
                "</circle>"
            );
    }

    function bodyBackground(Color.CM cm, bytes1 value) internal pure returns (string memory) {
        string memory bg = cm == Color.CM.LIGHT ? Color.bgLight(value) : Color.bgDark(value);
        return SVG.rect("300", "300", bg);
>>>>>>> main
    }
}
