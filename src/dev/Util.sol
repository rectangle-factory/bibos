// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

library Util {
    /// @notice will revert if any characters are not in [0-9]
    function hexStringToUint256(string memory _value) internal pure returns (uint256 result) {
        // 0-9 are 48-57
        // a-f are 61-66
        bytes memory value = bytes(_value);
        if (value.length == 0) return 0;
        uint256 multiplier = 16**(value.length - 1);
        uint256 i;
        while (multiplier != 0) {
            uint8 x = uint8(value[i]);
            x -= 48;
            if (x < 10) {
                result += x * multiplier;
            } else {
                x -= 13;
                if (x < 6) {
                    result += (x + 10) * multiplier;
                } else revert();
            }

            unchecked {
                multiplier /= 16;
                ++i;
            }
        }
    }

    function hexStringToBytes(string memory _value) internal pure returns (bytes memory result) {
        // 0-9 are 48-57
        // a-f are 97-102
        // a-f must be in lowercase !
        bytes memory value = bytes(_value);
        if (value.length == 0) return new bytes(0);
        uint256 bytesLength = value.length / 2;
        result = new bytes(bytesLength);

        uint256 i;
        uint256 j;
        while (j < bytesLength) {
            uint8 x = uint8(value[i]);
            bytes1 z;
            x -= 48;
            if (x < 10) {
                z = bytes1(x);
            } else {
                x -= 49;
                if (x < 6) {
                    z = bytes1(x + 10);
                } else revert();
            }

            if (i % 2 == 0) {
                result[j] |= (z << 4);
            } else {
                result[j] |= z;
                j++;
            }
            ++i;
        }
    }
}
