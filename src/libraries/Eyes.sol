// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Eyes {
    enum EyeType {
        OPEN,
        SMILEY,
        WINK,
        SLEEPY,
        CLOVER,
        DIZZY,
        HEART,
        WINCE,
        CYCLOPS,
        STAR
    }

    function render(bytes32 _seed) public pure returns (string memory) {
        string memory fill = Palette.getBackgroundFill(_seed);
        EyeType eyeType = getEyeType(_seed);

        if (eyeType == EyeType.OPEN) return open(fill);
        if (eyeType == EyeType.SMILEY) return smiley(fill);
        if (eyeType == EyeType.WINK) return wink(fill);
        if (eyeType == EyeType.SLEEPY) return sleepy(fill);
        if (eyeType == EyeType.CLOVER) return clover(fill);
        if (eyeType == EyeType.DIZZY) return dizzy(fill);
        if (eyeType == EyeType.HEART) return heart(fill);
        if (eyeType == EyeType.WINCE) return wince(fill);
        if (eyeType == EyeType.CYCLOPS) return cyclops(fill);
        return star(fill);
    }

    function getEyeType(bytes32 _seed) public pure returns (EyeType) {
        uint256 eyeSeed = uint256(keccak256(abi.encodePacked(_seed, "eye"))) % 100;

        if (eyeSeed % 100 < 25) return EyeType.OPEN;
        if (eyeSeed % 100 < 50) return EyeType.SMILEY;
        if (eyeSeed % 100 < 65) return EyeType.WINK;
        if (eyeSeed % 100 < 75) return EyeType.SLEEPY;
        if (eyeSeed % 100 < 83) return EyeType.CLOVER;
        if (eyeSeed % 100 < 89) return EyeType.DIZZY;
        if (eyeSeed % 100 < 94) return EyeType.HEART;
        if (eyeSeed % 100 < 97) return EyeType.WINCE;
        if (eyeSeed % 100 < 99) return EyeType.CYCLOPS;
        return EyeType.STAR;
    }

    function open(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<ellipse cx="59" cy="80" rx="18" ry="20" fill="',
                _fill,
                '"/>',
                '<ellipse cx="143" cy="80" rx="18" ry="20" fill="',
                _fill,
                '"/>',
                '<ellipse cx="66" cy="76.5" rx="6" ry="6.5" fill="white"/>',
                '<ellipse cx="150" cy="76.5" rx="6" ry="6.5" fill="white"/>'
            );
    }

    function clover(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M51 70L67 86M51 86L67 70" stroke="',
                _fill,
                '" stroke-width="24" stroke-linecap="round"/>',
                '<path d="M135 70L151 86M135 86L151 70" stroke="',
                _fill,
                '" stroke-width="24" stroke-linecap="round"/>',
                '<circle cx="150" cy="73" r="6" fill="white"/>',
                '<circle cx="66" cy="73" r="6" fill="white"/>'
            );
    }

    function dizzy(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M60.6645 75.0529C62.0054 73.9366 60.3272 70.9131 57.2074 71.5958C54.2108 71.9583 51.279 76.8268 53.9588 81.7586C56.2103 86.6761 64.4411 89.7892 71.0358 85.4242C77.7252 81.5755 80.5444 70.1782 74.0767 61.6407C68.2313 52.9471 53.4557 49.7063 43.3791 57.7675C33.004 65.0877 30.2918 83.0505 40.5466 95.1708" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>',
                '<path d="M141.459 74.9503C140.143 76.046 141.79 79.0136 144.852 78.3435C147.793 77.9877 150.671 73.2092 148.04 68.3687C145.83 63.542 137.752 60.4865 131.279 64.7708C124.713 68.5484 121.946 79.7349 128.295 88.1145C134.032 96.6473 148.534 99.8282 158.424 91.9161C168.608 84.7313 171.27 67.1006 161.204 55.2045" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>'
            );
    }

    function cyclops(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<ellipse cx="101" cy="70" rx="18" ry="20" fill="',
                _fill,
                '"/>',
                '<ellipse cx="108" cy="66.5" rx="6" ry="6.5" fill="white"/>'
            );
    }

    function scallop(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M59 65L59.0029 79.9852L64.7403 66.1418L59.0083 79.9875L69.6066 69.3934L59.0125 79.9917L72.8582 74.2597L59.0148 79.9971L74 80L59.0148 80.0029L72.8582 85.7403L59.0125 80.0083L69.6066 90.6066L59.0083 80.0125L64.7403 93.8582L59.0029 80.0148L59 95L58.9971 80.0148L53.2597 93.8582L58.9917 80.0125L48.3934 90.6066L58.9875 80.0083L45.1418 85.7403L58.9852 80.0029L44 80L58.9852 79.9971L45.1418 74.2597L58.9875 79.9917L48.3934 69.3934L58.9917 79.9875L53.2597 66.1418L58.9971 79.9852L59 65Z" fill="#F0C3D2" stroke="',
                _fill,
                '" stroke-width="10" stroke-linejoin="round"/>',
                '<path d="M143 65L143.003 79.9852L148.74 66.1418L143.008 79.9875L153.607 69.3934L143.012 79.9917L156.858 74.2597L143.015 79.9971L158 80L143.015 80.0029L156.858 85.7403L143.012 80.0083L153.607 90.6066L143.008 80.0125L148.74 93.8582L143.003 80.0148L143 95L142.997 80.0148L137.26 93.8582L142.992 80.0125L132.393 90.6066L142.988 80.0083L129.142 85.7403L142.985 80.0029L128 80L142.985 79.9971L129.142 74.2597L142.988 79.9917L132.393 69.3934L142.992 79.9875L137.26 66.1418L142.997 79.9852L143 65Z" fill="#F0C3D2" stroke="',
                _fill,
                '" stroke-width="10" stroke-linejoin="round"/>',
                '<circle cx="150" cy="76" r="6" fill="white"/>',
                '<circle cx="66" cy="76" r="6" fill="white"/>'
            );
    }

    //   `,
    //   "Nervous":`
    function nervous(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M40 66C37.3333 69.9763 36 74.6706 36 80.0828C36 85.3846 37.3333 90.0237 40 94" stroke="',
                _fill,
                '" stroke-width="4" stroke-linecap="round"/>',
                '<path d="M162 94C164.667 90.0237 166 85.3294 166 79.9172C166 74.6154 164.667 69.9763 162 66" stroke="',
                _fill,
                '" stroke-width="4" stroke-linecap="round"/>',
                '<ellipse cx="59" cy="80" rx="18" ry="20" fill="',
                _fill,
                '"/>',
                '<ellipse cx="143" cy="80" rx="18" ry="20" fill="',
                _fill,
                '"/>',
                '<ellipse cx="66" cy="76.5" rx="6" ry="6.5" fill="white"/>',
                '<ellipse cx="150" cy="76.5" rx="6" ry="6.5" fill="white"/>'
            );
    }

    //   `,
    //   "Angry":`
    function angry(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M126 60L154 49" stroke="',
                _fill,
                '" stroke-width="6" stroke-linecap="round"/>',
                '<path d="M77 60L49 49" stroke="',
                _fill,
                '" stroke-width="6" stroke-linecap="round"/>',
                '<ellipse cx="59" cy="80" rx="18" ry="20" fill="',
                _fill,
                '"/>',
                '<ellipse cx="143" cy="80" rx="18" ry="20" fill="',
                _fill,
                '"/>',
                '<ellipse cx="66" cy="76.5" rx="6" ry="6.5" fill="white"/>',
                '<ellipse cx="150" cy="76.5" rx="6" ry="6.5" fill="white"/>'
            );
    }

    //   `,
    //   "Hexagon": `
    function hexagon(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M64.905 62C67.7504 62 70.3816 63.5113 71.8153 65.969L77.6486 75.969C79.1016 78.4599 79.1016 81.5401 77.6486 84.031L71.8153 94.031C70.3816 96.4887 67.7504 98 64.905 98H53.095C50.2496 98 47.6184 96.4887 46.1847 94.031L40.3514 84.031C38.8984 81.5401 38.8984 78.4599 40.3514 75.969L46.1847 65.969C47.6184 63.5113 50.2496 62 53.095 62L64.905 62Z" fill="',
                _fill,
                '"/>',
                '<path d="M69.5 70L73 76L69.5 82H62.5L59 76L62.5 70L69.5 70Z" fill="white"/>',
                '<path d="M148.905 62C151.75 62 154.382 63.5113 155.815 65.969L161.649 75.969C163.102 78.4599 163.102 81.5401 161.649 84.031L155.815 94.031C154.382 96.4887 151.75 98 148.905 98H137.095C134.25 98 131.618 96.4887 130.185 94.031L124.351 84.031C122.898 81.5401 122.898 78.4599 124.351 75.969L130.185 65.969C131.618 63.5113 134.25 62 137.095 62L148.905 62Z" fill="',
                _fill,
                '"/>',
                '<path d="M153.5 70L157 76L153.5 82H146.5L143 76L146.5 70L153.5 70Z" fill="white"/>'
            );
    }

    //   `,
    //   "Heart":`
    function heart(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M59.0103 100C59.3112 100 59.66 99.8972 60.0567 99.6915C60.467 99.4995 60.8569 99.2801 61.2262 99.0332C65.0288 96.5649 68.3322 93.9731 71.1363 91.2579C73.9541 88.529 76.1358 85.7247 77.6815 82.8449C79.2272 79.9515 80 77.0374 80 74.1028C80 72.1556 79.6854 70.3797 79.0562 68.7753C78.427 67.1709 77.5652 65.7859 76.4709 64.6203C75.3767 63.4546 74.1045 62.5633 72.6546 61.9462C71.2047 61.3154 69.6522 61 67.9971 61C65.9453 61 64.1602 61.5211 62.6419 62.5633C61.1236 63.5918 59.913 64.9494 59.0103 66.6361C58.0938 64.9631 56.8764 63.6055 55.3581 62.5633C53.8534 61.5211 52.0684 61 50.0029 61C48.3478 61 46.7953 61.3154 45.3454 61.9462C43.9091 62.5633 42.637 63.4546 41.5291 64.6203C40.4211 65.7859 39.5525 67.1709 38.9233 68.7753C38.3078 70.3797 38 72.1556 38 74.1028C38 77.0374 38.7728 79.9515 40.3185 82.8449C41.8642 85.7247 44.0459 88.529 46.8637 91.2579C49.6815 93.9731 52.9849 96.5649 56.7738 99.0332C57.1568 99.2801 57.5467 99.4995 57.9433 99.6915C58.3537 99.8972 58.7093 100 59.0103 100Z" fill="',
                _fill,
                '"/>',
                '<path d="M143.01 100C143.311 100 143.66 99.8972 144.057 99.6915C144.467 99.4995 144.857 99.2801 145.226 99.0332C149.029 96.5649 152.332 93.9731 155.136 91.2579C157.954 88.529 160.136 85.7247 161.681 82.8449C163.227 79.9515 164 77.0374 164 74.1028C164 72.1556 163.685 70.3797 163.056 68.7753C162.427 67.1709 161.565 65.7859 160.471 64.6203C159.377 63.4546 158.105 62.5633 156.655 61.9462C155.205 61.3154 153.652 61 151.997 61C149.945 61 148.16 61.5211 146.642 62.5633C145.124 63.5918 143.913 64.9494 143.01 66.6361C142.094 64.9631 140.876 63.6055 139.358 62.5633C137.853 61.5211 136.068 61 134.003 61C132.348 61 130.795 61.3154 129.345 61.9462C127.909 62.5633 126.637 63.4546 125.529 64.6203C124.421 65.7859 123.553 67.1709 122.923 68.7753C122.308 70.3797 122 72.1556 122 74.1028C122 77.0374 122.773 79.9515 124.319 82.8449C125.864 85.7247 128.046 88.529 130.864 91.2579C133.681 93.9731 136.985 96.5649 140.774 99.0332C141.157 99.2801 141.547 99.4995 141.943 99.6915C142.354 99.8972 142.709 100 143.01 100Z" fill="',
                _fill,
                '"/>',
                '<circle cx="153" cy="75" r="6" fill="white"/>',
                '<circle cx="69" cy="75" r="6" fill="white"/>'
            );
    }

    //   `,
    //   "Smiley": `
    function smiley(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M41 78.5C47 72.8333 62.6 65.6 77 82" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>',
                '<path d="M161 78.5C155 72.8333 139.4 65.6 125 82" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>'
            );
    }

    //   `,
    //   "Sleepy": `
    function sleepy(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M75.9877 70.8113C71.6588 77.8378 58.4625 88.8622 40.3086 76.748" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>',
                '<path d="M126.012 70.8113C130.341 77.8378 143.537 88.8622 161.691 76.748" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>'
            );
    }

    //   `,
    //   "Star": `
    function star(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<circle cx="59" cy="80" r="19" fill="',
                _fill,
                '"/>',
                '<circle cx="143" cy="80" r="19" fill="',
                _fill,
                '"/>',
                '<path d="M140.363 82.896C140.608 83.1408 140.896 83.2614 141.227 83.2578C141.562 83.2598 141.919 83.1597 142.298 82.9575L146.25 80.8609L149.457 83.9636C149.77 84.2632 150.086 84.4578 150.403 84.5475C150.725 84.6428 151.038 84.6066 151.341 84.4388C151.638 84.2752 151.837 84.0376 151.936 83.7261C152.041 83.4152 152.053 83.0563 151.973 82.6494L151.135 78.3092L155.103 76.2673C155.486 76.0707 155.77 75.8376 155.956 75.5681C156.141 75.2987 156.199 74.9962 156.129 74.6609C156.064 74.3262 155.898 74.0624 155.63 73.8695C155.363 73.6767 155.019 73.5533 154.6 73.4994L150.171 72.9145L149.413 68.548C149.34 68.127 149.2 67.7892 148.992 67.5346C148.789 67.2806 148.52 67.1302 148.187 67.0833C147.848 67.0357 147.543 67.1056 147.273 67.293C147.008 67.4812 146.782 67.7675 146.596 68.1521L144.664 72.1405L140.238 71.4809C139.825 71.4179 139.464 71.4422 139.153 71.5538C138.843 71.6655 138.611 71.8708 138.457 72.1697C138.298 72.4729 138.269 72.782 138.372 73.097C138.481 73.4078 138.69 73.7102 138.999 74.004L142.25 77.0605L140.249 81.0016C140.06 81.3707 139.973 81.7191 139.987 82.0468C140.002 82.3745 140.128 82.6575 140.363 82.896Z" fill="white"/>',
                '<path d="M56.431 81.9157C56.6777 82.1484 56.9662 82.2643 57.2965 82.2636C57.6312 82.2682 57.9869 82.1768 58.3638 81.9893L62.2947 80.0456L65.5226 82.9954C65.8382 83.2802 66.1549 83.4662 66.4729 83.5533C66.7952 83.6457 67.107 83.6141 67.4083 83.4585C67.7039 83.3067 67.9003 83.0845 67.9973 82.7917C68.0993 82.4996 68.1087 82.1615 68.0256 81.7774L67.1535 77.6808L71.0999 75.7888C71.4811 75.6067 71.7631 75.3894 71.9459 75.1369C72.1287 74.8845 72.184 74.6 72.1116 74.2834C72.0443 73.9675 71.8762 73.7176 71.6074 73.5337C71.3386 73.3497 70.9946 73.2307 70.5755 73.1765L66.1468 72.5895L65.3543 68.4687C65.2781 68.0714 65.135 67.7519 64.9251 67.5103C64.7202 67.2694 64.4509 67.1255 64.1171 67.0785C63.7783 67.0309 63.4748 67.0943 63.2064 67.2688C62.943 67.4439 62.7199 67.7119 62.5371 68.0728L60.6395 71.8154L56.2131 71.158C55.8002 71.0953 55.4393 71.1153 55.1302 71.218C54.8211 71.3207 54.591 71.5122 54.4398 71.7927C54.283 72.0771 54.2573 72.3681 54.3628 72.6658C54.474 72.9595 54.6851 73.2461 54.9964 73.5256L58.2685 76.4321L56.301 80.1296C56.1152 80.4759 56.031 80.8035 56.0486 81.1124C56.0661 81.4213 56.1936 81.6891 56.431 81.9157Z" fill="white"/>'
            );
    }

    //   `,
    //   "Wink":`
    function wink(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M161 78.5C155 72.8333 139.4 65.6 125 82" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>',
                '<path d="M58.8269 100C63.7885 100 68.0577 98.0083 71.6346 94.0249C75.2115 90.0415 77 85.3942 77 80.083C77 74.6611 75.2115 69.9585 71.6346 65.9751C68.0577 61.9917 63.7885 60 58.8269 60C53.9808 60 49.7692 61.9917 46.1923 65.9751C42.7308 69.9585 41 74.6611 41 80.083C41 85.3942 42.7308 90.0415 46.1923 94.0249C49.7692 98.0083 53.9808 100 58.8269 100Z" fill="',
                _fill,
                '"/>',
                '<path d="M65.9423 83C67.5962 83 69.0192 82.3527 70.2115 81.0581C71.4038 79.7635 72 78.2531 72 76.527C72 74.7649 71.4038 73.2365 70.2115 71.9419C69.0192 70.6473 67.5962 70 65.9423 70C64.3269 70 62.9231 70.6473 61.7308 71.9419C60.5769 73.2365 60 74.7649 60 76.527C60 78.2531 60.5769 79.7635 61.7308 81.0581C62.9231 82.3527 64.3269 83 65.9423 83Z" fill="white"/>'
            );
    }

    //   `,
    //   "Wince": `
    function wince(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M75 81.5L45 78.5833M75 81.5L58.8571 62M75 81.5L53.8571 95" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round" stroke-linejoin="round"/>',
                '<path d="M127 81.5L157 78.5833M127 81.5L143.143 62M127 81.5L148.143 95" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round" stroke-linejoin="round"/>'
            );
    }
}
