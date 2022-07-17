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
                "<path d='M72 115L80.1589 126L90.3296 120L100.488 130L110.659 120L120.83 126L129 115' stroke='",
                _fill,
                "' stroke-width='10' stroke-miterlimit='10' stroke-linecap='round'/>"
            );
    }

    function tongue(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                "<path d='M72 116.069C84.2665 124.108 117.641 123.867 130 116' stroke='",
                _fill,
                "' stroke-width='10' stroke-linecap='round'/>",
                "<path d='M97.2169 125.829C95.7132 150.357 133.515 146.477 127.034 122.514' stroke='",
                _fill,
                "' stroke-width='10' stroke-linecap='round'/>",
                "<path d='M112.011 122.05L114 142' stroke='",
                _fill,
                "' stroke-width='4' stroke-linecap='round'/>"
            );
    }

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
