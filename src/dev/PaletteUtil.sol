// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Util} from "libraries/Util.sol";
import {PaletteUncompressed} from "dev/PaletteUncompressed.sol";

library PaletteUtil {
    uint256 constant length = 64;

    function getLightest() internal pure returns (string memory) {
        string memory result;
        uint256 i;
        for (; i < 64; ) {
            string memory strHex = slice7CharColor(PaletteUncompressed.lightest(i));
            result = string.concat(result, strHex);
            ++i;
        }
        return result;
    }

    function getLight() internal pure returns (string memory) {
        string memory result;
        uint256 i;
        for (; i < 64; ) {
            string memory strHex = slice7CharColor(PaletteUncompressed.light(i));
            result = string.concat(result, strHex);
            ++i;
        }
        return result;
    }

    function getDarkest() internal pure returns (string memory) {
        string memory result;
        uint256 i;
        for (; i < 64; ) {
            string memory strHex = slice7CharColor(PaletteUncompressed.darkest(i));
            result = string.concat(result, strHex);
            ++i;
        }
        return result;
    }

    function slice7CharColor(string memory _rgb) internal pure returns (string memory result) {
        assembly {
            result := add(_rgb, 1)
            mstore(result, 6)
        }
    }
}
