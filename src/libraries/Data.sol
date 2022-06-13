// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Util} from "src/libraries/Util.sol";

library Data {
    /*//////////////////////////////////////////////////////////////
                                  DATA
    //////////////////////////////////////////////////////////////*/

    uint256 constant length = 64;
    bytes constant bodyPointsBytes =
        hex"baa5aa77ae9687808197acaf777db9baa57c73978183a58189b887a7b5939bba99aba47f9c7c8aa49c71ae9685a1779984788aa1b6ba90af7aada9a6b1bba89695a2a3859da79db37b748cbca6707baca5ad93749b8d82b3aca27e75b5847c7d95b69b8b9b947d7071a98683a97db580aa90ad82b978977a83b187ae9da68298";
    bytes constant glintsPointsBytes =
        hex"8d78a6d585a7e3a6b075b2537aceb3d8b692d2a69cd4b79b919759838692637d989e7476a68c9694807dd75f86698b70bf6ac8ba4cb57cbb7a59e068aacfc4b38a969ca59a8d5e6a8bacaac2419c41879c96a0b1a26f80c866c696969589c6936c9871c48f8b9a4b7760714ab4dd92a188c7956165829b9589ab6c8899b2aacd";
    bytes constant motePointsBytes =
        hex"ad5e6bc1ce7f6bc196d2c1c1adce5e7f96d25e7fc16b6b6b965ac1c16bc16bc15ead5a96ce7fcead96d2965a5e7fce7fc16b5a9696d2ad5e6b6bc1c17f5e5ead7fcece7f5eadd296d296c1c17f5e6b6b5ead7f5eadcecead5a965a9696d26b6b965aadce5a96ceadadce6b6b965a5a967f5e5e7f7f5ecead7f5ec1c1ce7f7f5e7fce96d25e7f7f5e96d2d2965a96965aad5e6bc1ce7f6bc196d2c1c1adce5e7f96d25e7fc16b6b6b965ac1c16bc16bc15ead5a96ce7fcead96d2965a5e7fce7fc16b5a9696d2ad5e6b6bc1c17f5e5ead7fcece7f5eadd296d296c1c17f5e6b6b5ead7f5eadcecead5a965a9696d26b6b965aadce5a96ceadadce6b6b965a5a967f5e5e7f7f5ecead7f5ec1c1ce7f7f5e7fce96d25e7f7f5e96d2d2965a96965aad5e6bc1ce7f6bc196d2c1c1adce5e7f96d25e7fc16b6b6b965ac1c16bc16bc15ead5a96ce7fcead96d2965a5e7fce7fc16b5a9696d2ad5e6b6bc1c17f5e5ead7fcece7f5eadd296d296c1c17f5e6b6b5ead7f5eadcecead5a965a9696d26b6b";
    bytes public constant shortTimesBytes =
        hex"59614460553a60493b505f3753543e3a6163343849473e333c325e53483b624d34343e48505c595562364d4f4e5d515d53384457604c5a5b4454534148586063";
    bytes public constant longTimesBytes =
        hex"70927d8856956369837b55785486625886664f4f4d78875460754c7c785c7f4e709074877c6c788e5f63636478597586777a85746c82799271746d698c4f9288";

    /*//////////////////////////////////////////////////////////////
                                 POINTS
    //////////////////////////////////////////////////////////////*/

    function bodyPoints(uint256 _i) external pure returns (string[2] memory) {
        uint256 pos = (_i % length) * 2;
        string memory x = Util.bytes1ToString(bodyPointsBytes[pos]);
        string memory y = Util.bytes1ToString(bodyPointsBytes[pos + 1]);
        return [x, y];
    }

    function glintPoints(uint256 _i) external pure returns (string[2] memory) {
        uint256 pos = (_i % length) * 2;
        string memory x = Util.bytes1ToString(glintsPointsBytes[pos]);
        string memory y = Util.bytes1ToString(glintsPointsBytes[pos + 1]);
        return [x, y];
    }

    function motePoints(uint256 _i) external pure returns (string[2][3] memory) {
        uint256 pos = (_i % length) * 6;
        string[2][3] memory result;
        uint256 i;
        for (; i < 3; ) {
            string memory x = Util.bytes1ToString(motePointsBytes[pos + 2 * i]);
            string memory y = Util.bytes1ToString(motePointsBytes[pos + 2 * i + 1]);
            result[i] = [x, y];
            ++i;
        }
        return result;
    }

    /*//////////////////////////////////////////////////////////////
                                  TIMES
    //////////////////////////////////////////////////////////////*/

    function shortTimes(uint256 _i) external pure returns (string memory) {
        uint256 val = uint256(uint8(shortTimesBytes[_i % length]));
        return string.concat(Util.uint256ToString(val / 10), ".", Util.uint256ToString(val % 10));
    }

    function longTimes(uint256 _i) external pure returns (string memory) {
        uint256 val = uint256(uint8(longTimesBytes[_i % length]));
        return string.concat(Util.uint256ToString(val / 10), ".", Util.uint256ToString(val % 10));
    }
}
