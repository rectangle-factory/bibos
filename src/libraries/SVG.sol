// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Util} from "./Util.sol";

library SVG {
    function svg(string memory _children) internal pure returns (string memory) {
        return
            string.concat(
                "<svg ",
                'xmlns="http://www.w3.org/2000/svg" '
                'xmlns:xlink="http://www.w3.org/1999/xlink" '
                'width="100%" '
                'height="100%" '
                'viewBox="0 0 300 300" ',
                'preserveAspectRatio="xMidYMid meet" ',
                'fill="none" '
                ">",
                _children,
                "</svg>"
            );
    }

    function circle(
        string memory _radius,
        string[2] memory _coords,
        string memory _mixMode,
        string memory _fill,
        string memory _opacity,
        string memory _params
    ) internal pure returns (string memory) {
        return
            string.concat(
                "<circle r=",
                Util.quote(_radius),
                "cx=",
                Util.quote(_coords[0]),
                "cy=",
                Util.quote(_coords[1]),
                "style=",
                Util.quote(string.concat("mix-blend-mode:", _mixMode)),
                "fill=",
                Util.quote(_fill),
                "opacity=",
                Util.quote(_opacity),
                " ",
                _params,
                ">"
            );
    }

    function circle(
        string memory _radius,
        string[2] memory _coords,
        string memory _mixMode,
        string memory _fill,
        string memory _opacity
    ) internal pure returns (string memory) {
        return circle(_radius, _coords, _mixMode, _fill, _opacity, "");
    }

    function circleFilter(
        string memory _radius,
        string[2] memory _coords,
        string memory _mixMode,
        string memory _fill,
        string memory _opacity,
        string memory _filter
    ) internal pure returns (string memory) {
        return
            circle(
                _radius,
                _coords,
                _mixMode,
                _fill,
                _opacity,
                string.concat("filter=", Util.quote(string.concat("url(#", _filter, ")")))
            );
    }

    function rect(
        string memory _width,
        string memory _height,
        string memory _fill
    ) internal pure returns (string memory) {
        return
            string.concat(
                "<rect ",
                "width=",
                Util.quote(_width),
                "height=",
                Util.quote(_height),
                "fill=",
                Util.quote(_fill),
                "/>"
            );
    }

    function animateMotion(
        string memory _rev,
        string memory _dur,
        string memory _calcMode,
        string memory _mpath
    ) internal pure returns (string memory) {
        return
            string.concat(
                "<animateMotion ",
                _rev,
                " ",
                "dur=",
                Util.quote(_dur),
                'repeatCount="indefinite" ',
                "calcMode=",
                Util.quote(_calcMode),
                ">",
                _mpath,
                "</animateMotion>"
            );
    }

    function animate(string memory _dur) internal pure returns (string memory) {
        return
            string.concat(
                "<animate ",
                'attributeName="opacity" ',
                'values="0;1;0" ',
                "dur=",
                Util.quote(_dur),
                'repeatCount="indefinite" ',
                "/>"
            );
    }
}
