// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Util} from "libraries/Util.sol";
import {TimesUncompressed} from "dev/TimesUncompressed.sol";

/// @title TimesUtil
/// @author Bumblebee Systems
library TimesUtil {
    uint256 constant length = 64;

    function getShorter() internal pure returns (bytes memory) {
        bytes memory result;
        uint256 i;
        for (; i < 64; ) {
            bytes memory str = bytes(TimesUncompressed.shorter(i));
            bytes1 a = str[0];
            bytes1 b = str[2];
            string memory x = string(bytes.concat(a, b));
            bytes1 v = Util.stringToBytes1(x);
            result = bytes.concat(result, v);
            ++i;
        }
        return result;
    }

    function getShort() internal pure returns (bytes memory) {
        // all in format XXX.XX
        // numbers less than 256

        bytes memory result;
        uint256 i;
        for (; i < 64; ) {
            bytes memory str = bytes(TimesUncompressed.short(i));
            bytes1 a = str[0];
            bytes1 b = str[2];
            string memory x = string(bytes.concat(a, b));
            bytes1 v = Util.stringToBytes1(x);
            result = bytes.concat(result, v);
            ++i;
        }
        return result;
    }

    function getLong() internal pure returns (bytes memory) {
        // all in format X.XX

        uint256 i;
        bytes memory result;
        for (; i < 64; ) {
            bytes memory str = bytes(TimesUncompressed.short(i));
            bytes1 a = str[0];
            bytes1 b = str[1];
            bytes1 c = str[3];
            string memory x = string(bytes.concat(a, b, c));
            bytes1 v = Util.stringToBytes1(x);
            result = bytes.concat(result, v);
            ++i;
        }
        return result;
    }
}
