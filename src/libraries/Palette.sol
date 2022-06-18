// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;
import {Traits} from "libraries/Traits.sol";
import {Data} from "libraries/Data.sol";
enum RefractivityType {
    LIGHT,
    DARK
}

library Palette {
    uint256 constant length = 256;
    uint256 constant opacityLength = 5;

    function opacity(uint256 _seed) internal pure returns (string memory) {
        return
            (
                Traits.refractivityType(bytes32(_seed)) == RefractivityType.LIGHT
                    ? ["0.3", "0.4", "0.5", "0.6", "0.7"]
                    : ["0.6", "0.7", "0.8", "0.9", "1.0"]
            )[_seed % opacityLength];
    }

    function body(bytes32 _seed, uint256 _i) internal pure returns (string memory) {
        uint256 i = uint256(keccak256(abi.encodePacked(_seed, "bodyFill", _i))) % length;

        if (Traits.refractivityType(_seed) == RefractivityType.LIGHT) return _light(i);
        else return _lightest(i);
    }

    function background(bytes32 _seed) internal pure returns (string memory) {
        uint256 i = uint256(keccak256(abi.encodePacked(_seed, "backgroundFill"))) % length;

        if (Traits.refractivityType(_seed) == RefractivityType.LIGHT) return _light(i);
        else return _darkest(i);
    }

    function _lightest(uint256 _i) internal pure returns (string memory) {
        return Data.lightestPalette(_i % length);
    }

    function _light(uint256 _i) internal pure returns (string memory) {
        return Data.lightPalette(_i % length);
    }

    function _darkest(uint256 _i) internal pure returns (string memory) {
        return Data.darkestPalette(_i % length);
    }
}
