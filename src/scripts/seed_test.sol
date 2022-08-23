// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";
import {Json} from "util/Json.sol";
import {Palette, DensityType, PolarityType} from "libraries/Palette.sol";
import {Traits} from "libraries/Traits.sol";
import {Data} from "libraries/Data.sol";

/// @title get_seeds
/// @notice gets all the Bibos bytes32 seeds sequentially
/// @author Bumblebee Systems
contract seeds_test is Script {
    string constant SEEDS_PATH = "seeds.json";
    uint256 constant circlesCount = 7;

    function run() external returns (string memory) {
        return bibosData(0);
    }

    function bibosData(uint256 _tokenId) internal returns (string memory) {
        bytes32 seed = abi.decode(Json.readData(SEEDS_PATH, ".[0]"), (bytes32));

        string memory backgroundFill = Palette.backgroundFill(seed, _tokenId);
        string memory mixBlendMode = Traits.polarityType(seed, _tokenId) == PolarityType.POSITIVE
            ? "lighten"
            : "multiply";
        string memory result = "[";
        for (uint8 index = 0; index < circlesCount; ++index) {
            result = string.concat(result, _bodyCircle(seed, index, 0));
            if (index < circlesCount - 1) result = string.concat(result, ",");
        }
        result = string.concat(result, "]");

        console.log(result);
        return result;
    }

    function _background() internal {
        Palette.backgroundFill(_seed, _tokenId);
    }

    function _motes() {}

    /// @notice colors
    function _glints() {}

    /// @notice coords
    function _circles() {}

    function _circle(
        bytes32 _seed,
        uint256 _index,
        uint256 _tokenId
    ) internal returns (string memory) {
        uint256 bodySeed = uint256(keccak256(abi.encodePacked(_seed, "body", _index)));
        string memory bodyFill1 = Palette.bodyFill(_seed, _index, _tokenId);
        string memory bodyFill2 = Palette.bodyFill(_seed, _index + circlesCount, _tokenId);
        bodySeed /= Data.length;
        string[2] memory coords = (_index == 0) ? ["150", "150"] : Data.bodyPoints(bodySeed /= 2);

        string memory result = string.concat("{", "fill:", '"', bodyFill1, ",");
        if (_tokenId == 0) result = string.concat(result, "fill2:", '"', bodyFill2, '"', ",");
        result = string.concat("coords:", "[", '"', coords[0], '"', ",", '"', coords[1], '"', "]", "}");
    }

    // function keyValue(string memory _key, string memory _value) internal returns (string memory) {
    //     return string.concat(_key, ":", '"', _value, '"');
    // }
}
