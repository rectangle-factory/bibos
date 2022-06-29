// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;
import {Traits} from "libraries/Traits.sol";
import {Data} from "libraries/Data.sol";
enum DensityType {
    HIGH,
    LOW
}

enum PolarityType {
    POSITIVE,
    NEGATIVE
}

library Palette {
    uint256 public constant opacityLength = 5;

    function getOpacity(uint256 _moteSeed, bytes32 _seed) internal pure returns (string memory) {
        return
            (
                Traits.getDensityType(_seed) == DensityType.HIGH
                    ? ["0.3", "0.4", "0.5", "0.6", "0.7"]
                    : ["0.6", "0.7", "0.8", "0.9", "1.0"]
            )[_moteSeed % opacityLength];
    }

    function getBodyFill(bytes32 _seed, uint256 _i) internal pure returns (string memory) {
        uint256 bodyFillValue = uint256(keccak256(abi.encodePacked(_seed, "bodyFill", _i)));

        if (Traits.getDensityType(_seed) == DensityType.HIGH) {
            if (Traits.getPolarityType(_seed) == PolarityType.POSITIVE) {
                return lightPalette(bodyFillValue);
            } else {
                return invertedLightPalette(bodyFillValue);
            }
        } else {
            if (Traits.getPolarityType(_seed) == PolarityType.POSITIVE) {
                return lightestPalette(bodyFillValue);
            } else {
                return invertedLightestPalette(bodyFillValue);
            }
        }
    }

    function getBackgroundFill(bytes32 _seed) internal pure returns (string memory) {
        uint256 backgroundFillValue = uint256(keccak256(abi.encodePacked(_seed, "backgroundFill")));

        if (Traits.getDensityType(_seed) == DensityType.HIGH) {
            if (Traits.getPolarityType(_seed) == PolarityType.POSITIVE) {
                return darkestPalette(backgroundFillValue);
            } else {
                return invertedDarkestPalette(backgroundFillValue);
            }
        } else {
            if (Traits.getPolarityType(_seed) == PolarityType.POSITIVE) {
                return darkestPalette(backgroundFillValue);
            } else {
                return invertedDarkestPalette(backgroundFillValue);
            }
        }
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

    function invertedLightestPalette(uint256 _value) internal pure returns (string memory) {
        return Data.invertedLightestPalette(_value);
    }

    function invertedLightPalette(uint256 _value) internal pure returns (string memory) {
        return Data.invertedLightPalette(_value);
    }

    function invertedDarkestPalette(uint256 _value) internal pure returns (string memory) {
        return Data.invertedDarkestPalette(_value);
    }
}
