// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Color} from "./Color.sol";
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Body {
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
    }
}
