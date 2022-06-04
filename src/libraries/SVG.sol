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
        string memory _opacity
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
                ">"
            );
    }

    function circle(
        string memory _radius,
        string[2] memory _coords,
        string memory _mixMode,
        string memory _fill,
        string memory _opacity,
        string memory _filter
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
                "filter=",
                Util.quote(string.concat("url(#", _filter, ")")),
                ">"
            );
    }

    function rect(
        string memory _width,
        string memory _height,
        string memory _fill
    ) internal pure returns (string memory) {
        return string.concat("<rect ", "width=", Util.quote(_width), "height=", Util.quote(_height), "fill=", Util.quote(_fill), "/>");
    }

    function defs() internal pure returns (string memory) {
        return
            string.concat(
                "<defs>",
                '<filter id="bibo-blur" x="-50%" y="-50%" width="200%" height="200%" color-interpolation-filters="sRGB">',
                '<feGaussianBlur stdDeviation="15" result="out" />',
                "</filter>",
                '<filter id="bibo-blur-sm" x="-50%" y="-50%" width="200%" height="200%" color-interpolation-filters="sRGB">',
                '<feGaussianBlur stdDeviation="5" result="out" />',
                "</filter>",
                "<!-- Figure Eights -->",
                '<path id="bibo-jitter-sm" d="M10.4485 2.98177C14.4091 4.48135 20 6.52342 20 2.98176C20 -0.548164 14.617 1.40118 10.4485 2.98177ZM10.4485 2.98177C10.4347 2.98703 10.4208 2.99226 10.4069 2.99751C6.23277 4.58084 1 6.5628 1 3.02114C1 -0.520506 6.48798 1.4822 10.4485 2.98177Z" />',
                '<path id="bibo-jitter-lg" d="M11.4431 4.92852C15.8206 9.82815 22 10.2396 22 4.92847C22 -0.382675 16.0504 -0.235806 11.4431 4.92852ZM11.4431 4.92852C11.4278 4.94569 11.4124 4.9628 11.3972 4.97994C6.78359 10.1532 1 10.4969 1 5.05714C1 -0.382663 7.06566 0.0289037 11.4431 4.92852Z" />',
                "</defs>"
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
        return string.concat("<animate ", 'attributeName="opacity" ', 'values="0;1;0" ', "dur=", Util.quote(_dur), 'repeatCount="indefinite" ', "/>");
    }
}
