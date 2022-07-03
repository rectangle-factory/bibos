// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;
import {Traits} from "libraries/Traits.sol";
import {Data} from "libraries/Data.sol";
enum RefractivityType {
    LIGHT,
    DARK
}

library Palette {
    uint256 public constant opacityLength = 5;

    function getOpacity(uint256 _glintSeed, bytes32 _seed) internal pure returns (string memory) {
        return
            (
                Traits.getRefractivityType(_seed) == RefractivityType.LIGHT
                    ? ["0.3", "0.4", "0.5", "0.6", "0.7"]
                    : ["0.6", "0.7", "0.8", "0.9", "1.0"]
            )[_glintSeed % opacityLength];
    }

    function getBodyFill(bytes32 _seed, uint256 _i) internal pure returns (string memory) {
        uint256 bodyFillValue = uint256(keccak256(abi.encodePacked(_seed, "bodyFill", _i)));

        if (Traits.getRefractivityType(_seed) == RefractivityType.LIGHT) return lightPalette(bodyFillValue);
        else return lightestPalette(bodyFillValue);
    }

    function getBackgroundFill(bytes32 _seed) internal pure returns (string memory) {
        uint256 backgroundFillValue = uint256(keccak256(abi.encodePacked(_seed, "backgroundFill")));

        if (Traits.getRefractivityType(_seed) == RefractivityType.LIGHT) return darkestPalette(backgroundFillValue);
        else return darkestPalette(backgroundFillValue);
    }

    function lightestPalette(uint256 _value) internal pure returns (string memory) {
        return Data.lightestPalette(_value);
    }

    function lightPalette(uint256 _value) internal pure returns (string memory) {
        return Data.lightPalette(_value);
    }

    function darkestPalette(uint256 _value) internal pure returns (string memory) {
        return Data.darkestPalette(_value);
    }
}
