// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Util} from "./Util.sol";

library SVG {
    function circle(
        string memory radius,
        string[2] memory coords,
        string memory mixMode,
        string memory fill,
        string memory opacity
    ) internal pure returns (string memory) {
        return
            string.concat(
                "<circle r=",
                Util.quote(radius),
                "cx=",
                Util.quote(coords[0]),
                "cy=",
                Util.quote(coords[1]),
                "style=",
                Util.quote(string.concat("mix-blend-mode:", mixMode)),
                'shape-rendering="optimizeSpeed" ',
                "fill=",
                Util.quote(fill),
                "opacity=",
                Util.quote(opacity),
                ">"
            );
    }

    function rect(
        string memory width,
        string memory height,
        string memory bg
    ) internal pure returns (string memory) {
        return string.concat("<rect ", "width=", Util.quote(width), "height=", Util.quote(height), "fill=", Util.quote(bg), "/>");
    }

    function animateMotion(
        string memory rev,
        string memory dur,
        string memory calcMode,
        string memory mpath
    ) internal pure returns (string memory) {
        return
            string.concat(
                "<animateMotion ",
                rev,
                "dur=",
                Util.quote(dur),
                'repeatCount="indefinite" ',
                "calcMode=",
                Util.quote(calcMode),
                ">",
                mpath,
                "</animateMotion>"
            );
    }

    function animate(string memory dur) internal pure returns (string memory) {
        return string.concat("<animate ", 'attributeName="opacity" ', 'values="0;1;0" ', "dur=", Util.quote(dur), 'repeatCount="indefinite" ', "/>");
    }
}
