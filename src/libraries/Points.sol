// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Util} from "src/libraries/Util.sol";

library Points {
    uint256 constant length = 64;
    bytes constant bodyHex =
        hex"baa5aa77ae9687808197acaf777db9baa57c73978183a58189b887a7b5939bba99aba47f9c7c8aa49c71ae9685a1779984788aa1b6ba90af7aada9a6b1bba89695a2a3859da79db37b748cbca6707baca5ad93749b8d82b3aca27e75b5847c7d95b69b8b9b947d7071a98683a97db580aa90ad82b978977a83b187ae9da68298";
    bytes constant glintsHex =
        hex"8d617851a64dd5138557a748e304a62db01e7526b22b535a7a4dce04b32cd851b63e9252d216a6409c0dd421b72c9b049112972e59438336862f923163567d4c982b9e3e74207640a6258c4196419415803a7d43d7525f24863c69548b057004bf4b6a0ec835ba454c26b5037c1bbb327a3f5905e00d6811aa06cf0ec45cb3278a36961f9c44a5449a4c8d485e2a6a608b4dac55aa03c234411f9c1e410d874d9c399604a00cb122a2426f458044c85f664ec64a9644961895088918c64b93276c44982e715fc43c8f298b079a5e4b20773b604771134a02b402dd0a9256a10d8814c7579509615e6559825c9b2395098910ab576c568851993fb251aa52cd4b";
    bytes constant motesHex =
        hex"ad5e6bc1ce7f6bc196d2c1c1adce5e7f96d25e7fc16b6b6b965ac1c16bc16bc15ead5a96ce7fcead96d2965a5e7fce7fc16b5a9696d2ad5e6b6bc1c17f5e5ead7fcece7f5eadd296d296c1c17f5e6b6b5ead7f5eadcecead5a965a9696d26b6b965aadce5a96ceadadce6b6b965a5a967f5e5e7f7f5ecead7f5ec1c1ce7f7f5e7fce96d25e7f7f5e96d2d2965a96965aad5e6bc1ce7f6bc196d2c1c1adce5e7f96d25e7fc16b6b6b965ac1c16bc16bc15ead5a96ce7fcead96d2965a5e7fce7fc16b5a9696d2ad5e6b6bc1c17f5e5ead7fcece7f5eadd296d296c1c17f5e6b6b5ead7f5eadcecead5a965a9696d26b6b965aadce5a96ceadadce6b6b965a5a967f5e5e7f7f5ecead7f5ec1c1ce7f7f5e7fce96d25e7f7f5e96d2d2965a96965aad5e6bc1ce7f6bc196d2c1c1adce5e7f96d25e7fc16b6b6b965ac1c16bc16bc15ead5a96ce7fcead96d2965a5e7fce7fc16b5a9696d2ad5e6b6bc1c17f5e5ead7fcece7f5eadd296d296c1c17f5e6b6b5ead7f5eadcecead5a965a9696d26b6b";

    function body(uint256 _i) external pure returns (string[2] memory) {
        uint256 pos = (_i % 64) * 2;

        string memory x = Util.uint256ToAscii(uint8(bodyHex[pos]));
        string memory y = Util.uint256ToAscii(uint8(bodyHex[pos + 1]));
        return [x, y];
    }

    function glint(uint256 _i) external pure returns (string[2] memory) {
        uint256 pos = (_i % 64) * 4;
        uint256 xIntegralPart = uint8(glintsHex[pos]);
        uint256 xFractionalPart = uint8(glintsHex[pos + 1]);
        string memory x1 = _pad(Util.uint256ToAscii(xIntegralPart), 3);
        string memory x2 = _pad(Util.uint256ToAscii(xFractionalPart), 2);
        string memory x = string.concat(x1, ".", x2);

        uint256 yIntegralPart = uint8(glintsHex[pos + 2]);
        uint256 yFractionalPart = uint8(glintsHex[pos + 3]);
        string memory y1 = _pad(Util.uint256ToAscii(yIntegralPart), 3);
        string memory y2 = _pad(Util.uint256ToAscii(yFractionalPart), 2);
        string memory y = string.concat(y1, ".", y2);
        return [x, y];
    }

    function motes(uint256 _i) external pure returns (string[2][3] memory) {
        uint256 pos = (_i % 64) * 6;
        string[2][3] memory result;
        uint256 i;
        for (; i < 3; ) {
            string memory x = _pad(Util.uint256ToAscii(uint8(motesHex[pos + 2 * i])), 3);
            string memory y = _pad(Util.uint256ToAscii(uint8(motesHex[pos + 2 * i + 1])), 3);
            result[i] = [x, y];
            ++i;
        }
        return result;
    }

    function _pad(string memory _value, uint256 _length) internal pure returns (string memory) {
        uint256 paddingLength = _length - bytes(_value).length;
        string memory padding;
        uint256 i;
        for (; i < paddingLength; ) {
            padding = string.concat(padding, "0");
            unchecked {
                ++i;
            }
        }
        return string.concat(padding, _value);
    }
}
