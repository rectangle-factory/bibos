// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Util} from "src/libraries/Util.sol";

library Points3 {
    uint256 constant length = 64;
    bytes constant bodyHexUint =
        hex"baa5aa77ae9687808197acaf777db9baa57c73978183a58189b887a7b5939bba99aba47f9c7c8aa49c71ae9685a1779984788aa1b6ba90af7aada9a6b1bba89695a2a3859da79db37b748cbca6707baca5ad93749b8d82b3aca27e75b5847c7d95b69b8b9b947d7071a98683a97db580aa90ad82b978977a83b187ae9da68298";
    bytes constant glintsHexUint =
        hex"37752f3141255347344b418458b0410544de2dda45b320c62ff5507c461854b14756395a521e41183cfd52f147a83c9038b63b2a2307336234873939270231203b8b3df62d702e5840fd36f13ad939e5323a3117544e25403494295836512bc44ae729764e5548ed1dd646b7308b493e2fe722c9578d28b1426e50ea4cec4613361e3ab73d3440b83c74375c24e229c836994385426b4bfc19833d0e197135093d293a9c3e8c45463f8a2ba132444e7f28264da23adc3ab03a3c359c4da339932a743b8e2c834ccc380536533c861d6c2eb725c72c371cea4652565e395e3ef135344e133a3d264227cd33243caf3a3d359443232a8635713c0345d942ba505f";
    bytes constant motesHexUint =
        hex"ad5e6bc1ce7f6bc196d2c1c1adce5e7f96d25e7fc16b6b6b965ac1c16bc16bc15ead5a96ce7fcead96d2965a5e7fce7fc16b5a9696d2ad5e6b6bc1c17f5e5ead7fcece7f5eadd296d296c1c17f5e6b6b5ead7f5eadcecead5a965a9696d26b6b965aadce5a96ceadadce6b6b965a5a967f5e5e7f7f5ecead7f5ec1c1ce7f7f5e7fce96d25e7f7f5e96d2d2965a96965aad5e6bc1ce7f6bc196d2c1c1adce5e7f96d25e7fc16b6b6b965ac1c16bc16bc15ead5a96ce7fcead96d2965a5e7fce7fc16b5a9696d2ad5e6b6bc1c17f5e5ead7fcece7f5eadd296d296c1c17f5e6b6b5ead7f5eadcecead5a965a9696d26b6b965aadce5a96ceadadce6b6b965a5a967f5e5e7f7f5ecead7f5ec1c1ce7f7f5e7fce96d25e7f7f5e96d2d2965a96965aad5e6bc1ce7f6bc196d2c1c1adce5e7f96d25e7fc16b6b6b965ac1c16bc16bc15ead5a96ce7fcead96d2965a5e7fce7fc16b5a9696d2ad5e6b6bc1c17f5e5ead7fcece7f5eadd296d296c1c17f5e6b6b5ead7f5eadcecead5a965a9696d26b6b";

    function bodyUint(uint256 _i) external pure returns (string[2] memory) {
        uint256 pos = _i * 2;

        string memory x = Util.uint256ToAscii(uint8(bodyHexUint[pos]));
        string memory y = Util.uint256ToAscii(uint8(bodyHexUint[pos + 1]));
        return [x, y];
    }

    function glintUint(uint256 _i) external pure returns (string[2] memory) {
        uint256 pos = _i * 4;
        uint256 xUint = uint8(glintsHexUint[pos]) * 256;
        xUint += uint8(glintsHexUint[pos + 1]);
        string memory x1 = _pad(Util.uint256ToAscii(xUint / 100), 3);
        string memory x2 = _pad(Util.uint256ToAscii(xUint % 100), 2);
        string memory x = string.concat(x1, ".", x2);

        uint256 yUint = uint8(glintsHexUint[pos + 2]) * 256;
        yUint += uint8(glintsHexUint[pos + 3]);
        string memory y1 = _pad(Util.uint256ToAscii(yUint / 100), 3);
        string memory y2 = _pad(Util.uint256ToAscii(yUint % 100), 2);
        string memory y = string.concat(y1, ".", y2);
        return [x, y];
    }

    function motesUint(uint256 _i) external pure returns (string[2][3] memory) {
        uint256 pos = _i * 6;
        string[2][3] memory result;
        uint256 i;
        for (; i < 3; ) {
            string memory x = _pad(Util.uint256ToAscii(uint8(motesHexUint[pos + 2 * i])), 3);
            string memory y = _pad(Util.uint256ToAscii(uint8(motesHexUint[pos + 2 * i + 1])), 3);
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
