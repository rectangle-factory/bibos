// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

// paths stores path points as 2^16 scaled by two decimals places
// we always have M x x C x x x C x x x ... C x x x
// in other words, there are always 2 + 3 * k points

library StringUncompressed {
    function string1() internal pure returns (string memory) {
        '<path d="M60.6645 75.0529C62.0054 73.9366 60.3272 70.9131 57.2074 71.5958C54.2108 71.9583 51.279 76.8268 53.9588 81.7586C56.2103 86.6761 64.4411 89.7892 71.0358 85.4242C77.7252 81.5755 80.5444 70.1782 74.0767 61.6407C68.2313 52.9471 53.4557 49.7063 43.3791 57.7675C33.004 65.0877 30.2918 83.0505 40.5466 95.1708" stroke="black" stroke-width="10" stroke-linecap="round"/><path d="M141.459 74.9503C140.143 76.046 141.79 79.0136 144.852 78.3435C147.793 77.9877 150.671 73.2092 148.04 68.3687C145.83 63.542 137.752 60.4865 131.279 64.7708C124.713 68.5484 121.946 79.7349 128.295 88.1145C134.032 96.6473 148.534 99.8282 158.424 91.9161C168.608 84.7313 171.27 67.1006 161.204 55.2045" stroke="black" stroke-width="10" stroke-linecap="round"/>';
    }

    function path1(uint256 _index) internal pure returns (uint16) {
        uint16[38] memory points = [
            6066,
            7505,
            6200,
            7393,
            6032,
            7091,
            5720,
            7159,
            5421,
            7195,
            5127,
            7682,
            5395,
            8175,
            5621,
            8667,
            6444,
            8978,
            7103,
            8542,
            7772,
            8157,
            8054,
            7017,
            7407,
            6164,
            6823,
            5294,
            5345,
            4970,
            4337,
            5776,
            3300,
            6508,
            3029,
            8305,
            4054,
            9517
        ];

        return points[_index];
    }

    function encodeString(string memory _string) internal pure returns (bytes memory) {
        bytes memory str = bytes(_string);
        uint256 length = str.length;
        uint256 i;
        bytes memory result;

        // space is 32
        // z is 122
        // so we need room for 90 < 128
        // 122 is already less than 128 and we only save one bit.
        // Z is 90, so if we only do numbers, ., and capital letters
        // 90 - 32 = 58 < 64, so we save 2 bits
        // maybe we can do better with the path encodings. lots of XX.XXXX which could be encoded very small.
        // assembly {
        //     result := mload(0x40)
        //     for {

        //     } lt(i, length) {

        //     } {
        //         char := mload(str, i)
        //         char := sub(char, 32)
        //         char := shr(90, char)
        //         mstore8(result, i)
        //         i := add(i, 1)
        //     }
        // }

        return result;
    }
}
