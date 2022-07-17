// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Traits} from "./Traits.sol";
enum MouthType {
    SMILE,
    MEDIUM_SMILE,
    SMALL_SMILE,
    FLAT,
    OOO,
    GRIN,
    SMOOCH,
    TOOTHY,
    SMIRK
}

library Mouth {
    function render(bytes32 _seed) internal pure returns (string memory) {
        string memory fill = "black";
        MouthType mouthType = Traits.getMouthType(_seed);

        if (mouthType == MouthType.SMILE) return smile(fill);
        if (mouthType == MouthType.MEDIUM_SMILE) return mediumSmile(fill);
        if (mouthType == MouthType.SMALL_SMILE) return smallSmile(fill);
        if (mouthType == MouthType.FLAT) return flat(fill);
        if (mouthType == MouthType.OOO) return ooo(fill);
        if (mouthType == MouthType.GRIN) return grin(fill);
        if (mouthType == MouthType.SMOOCH) return smooch(fill);
        if (mouthType == MouthType.TOOTHY) return toothy(fill);
        return smirk(fill);
    }

    function smile(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                "<path d='M72 116.208C84.2665 140.324 117.641 139.602 130 116' stroke='",
                _fill,
                "' stroke-width='10' stroke-linecap='round'/>"
            );
    }

    function mediumSmile(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                "<path d='M81 116.139C89.4596 132.216 112.476 131.735 121 116' stroke='",
                _fill,
                "' stroke-width='10' stroke-linecap='round'/>"
            );
    }

    function smallSmile(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                "<path d='M91 111.081C95.2298 120.459 106.738 120.179 111 111' stroke='",
                _fill,
                "' stroke-width='10' stroke-linecap='round'/>"
            );
    }

    function ooo(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                "<path d='M109 122.5C109 127.747 105.418 130 101 130C96.5817 130 93 127.747 93 122.5C93 117.253 96.5817 113 101 113C105.418 113 109 117.253 109 122.5Z' fill='",
                _fill,
                "'/>"
            );
    }

    function smooch(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                "<path d='M98 101C119 97 123 117 104.993 120C123 122 120 141.5 99 139' stroke='",
                _fill,
                "' stroke-width='10' stroke-linecap='round' stroke-linejoin='round'/>",
                "<path d='M132.055 125.545C132.141 125.54 132.238 125.505 132.348 125.44C132.462 125.378 132.569 125.309 132.67 125.233C133.713 124.467 134.612 123.675 135.366 122.856C136.124 122.033 136.699 121.199 137.091 120.354C137.484 119.505 137.655 118.664 137.606 117.829C137.574 117.276 137.454 116.776 137.248 116.33C137.042 115.884 136.773 115.505 136.442 115.192C136.11 114.879 135.733 114.647 135.309 114.495C134.885 114.34 134.437 114.277 133.966 114.304C133.381 114.339 132.88 114.517 132.465 114.838C132.049 115.156 131.727 115.563 131.498 116.057C131.209 115.597 130.839 115.231 130.389 114.96C129.942 114.689 129.425 114.571 128.836 114.605C128.364 114.633 127.927 114.749 127.524 114.952C127.125 115.152 126.777 115.427 126.48 115.777C126.184 116.127 125.96 116.535 125.807 117.002C125.658 117.469 125.6 117.979 125.633 118.532C125.682 119.367 125.951 120.183 126.44 120.98C126.928 121.773 127.597 122.533 128.446 123.262C129.295 123.987 130.28 124.669 131.401 125.307C131.514 125.371 131.629 125.427 131.746 125.475C131.866 125.527 131.969 125.55 132.055 125.545Z' fill='",
                _fill,
                "'/>"
            );
    }

    function grin(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                "<path d='M80 120C91.8621 123.983 111.138 124.017 123 120' stroke='",
                _fill,
                "' stroke-width='10' stroke-linecap='round'/>"
            );
    }

    function toothy(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                "<path d='M78 116L81.7008 120.022C82.6943 121.102 83.1911 121.641 83.7943 121.962C84.3276 122.246 84.9183 122.405 85.5219 122.427C86.2046 122.453 86.9053 122.236 88.3066 121.801L89.2251 121.516C90.4224 121.145 91.021 120.959 91.6155 120.955C92.1419 120.952 92.6636 121.053 93.1509 121.252C93.7013 121.477 94.1875 121.873 95.16 122.664L96.4568 123.719C97.8947 124.888 98.6137 125.473 99.4132 125.697C100.118 125.895 100.864 125.896 101.57 125.699C102.369 125.475 103.089 124.891 104.528 123.723L105.84 122.659C106.813 121.869 107.299 121.475 107.849 121.251C108.336 121.052 108.857 120.952 109.383 120.955C109.977 120.959 110.575 121.145 111.771 121.516L112.686 121.8C114.087 122.235 114.787 122.453 115.47 122.427C116.073 122.405 116.664 122.246 117.197 121.963C117.8 121.643 118.297 121.104 119.291 120.025L123 116' stroke='",
                _fill,
                "' stroke-width='10' stroke-miterlimit='10' stroke-linecap='round'/>"
            );
    }

    // function tongue(string memory _fill) internal pure returns (string memory) {
    //     return
    //         string.concat(
    //             "<path d='M72 116.069C84.2665 124.108 117.641 123.867 130 116' stroke='",
    //             _fill,
    //             "' stroke-width='10' stroke-linecap='round'/>",
    //             "<path d='M97.2169 125.829C95.7132 150.357 133.515 146.477 127.034 122.514' stroke='",
    //             _fill,
    //             "' stroke-width='10' stroke-linecap='round'/>",
    //             "<path d='M112.011 122.05L114 142' stroke='",
    //             _fill,
    //             "' stroke-width='4' stroke-linecap='round'/>"
    //         );
    // }

    function flat(string memory _fill) internal pure returns (string memory) {
        return string.concat("<path d='M80 120H123' stroke='", _fill, "' stroke-width='10' stroke-linecap='round'/>");
    }

    function smirk(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                "<path d='M130 116C121.699 131.851 103.919 137.383 89.4211 132' stroke='",
                _fill,
                "' stroke-width='10' stroke-linecap='round'/>"
            );
    }
}
