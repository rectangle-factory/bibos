// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Util} from "libraries/Util.sol";
import {PointsUncompressed} from "dev/PointsUncompressed.sol";

library PointsUtil {
    uint256 constant length = 64;

    function getBody() internal pure returns (bytes memory) {
        bytes memory result;
        uint256 i;
        for (; i < 64; ) {
            string[2] memory pair = PointsUncompressed.body(i);
            result = _concatPair(result, pair[0], pair[1]);
            ++i;
        }
        return result;
    }

    function getGlints() internal pure returns (bytes memory) {
        // all in format XXX.XX
        // numbers less than 256

        bytes memory result;
        uint256 i;
        for (; i < 64; ) {
            string[2] memory pair = PointsUncompressed.glint(i);
            result = _concatPair(result, pair[0], pair[1]);
            ++i;
        }
        return result;
    }

    function getMotes() internal pure returns (bytes memory) {
        // all in format XXX

        uint256 i;
        bytes memory result;
        for (; i < 64; ) {
            string[2][3] memory pair = PointsUncompressed.motes(i);
            uint256 j;
            for (; j < 3; ) {
                result = _concatPair(result, pair[j][0], pair[j][1]);
                ++j;
            }
            ++i;
        }
        return result;
    }

    function _concatPair(
        bytes memory _result,
        string memory _str1,
        string memory _str2
    ) internal pure returns (bytes memory) {
        return bytes.concat(_result, Util.stringToBytes1(_str1), Util.stringToBytes1(_str2));
    }
}
