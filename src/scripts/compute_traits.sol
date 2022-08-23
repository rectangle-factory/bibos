// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";
import {Json} from "util/Json.sol";
import {Palette, DensityType, PolarityType} from "libraries/Palette.sol";
import {Traits} from "libraries/Traits.sol";
import {Data} from "libraries/Data.sol";
import {Util} from "libraries/Util.sol";
import {MoteType} from "libraries/Motes.sol";

// usage:
// forge script compute_traits -s "run(uint256)" $TOKEN_ID

/// @title compute_traits
/// @notice Computes Bibos extended attributes
/// @dev Seeds need to have already have been obtained on-chain
/// @author Bumblebee Systems
contract compute_traits is Script {
    string constant SEEDS_PATH = "seeds.json";
    uint256 constant CIRCLES_COUNT = 7;
    uint256 constant MOTE_COUNT = 20;

    function run(uint256 _tokenId) external {
        console.log(bibosData(_tokenId));
    }

    function bibosData(uint256 _tokenId) internal returns (string memory) {
        string memory filter = string.concat(".[", Util.uint256ToString(_tokenId), "]");
        bytes32 seed = abi.decode(Json.readData(SEEDS_PATH, filter), (bytes32));

        string memory result = string.concat(
            "{",
            _keyValue("traits", _traits(seed, _tokenId)),
            ",",
            _keyValue("background", _background(seed, _tokenId)),
            ",",
            _keyValue("body", _body(seed, _tokenId)),
            ",",
            _keyValue("motes", _motes(seed, _tokenId)),
            ",",
            _keyValue("glints", _glints(seed)),
            "}"
        );

        return result;
    }

    function _traits(bytes32 _seed, uint256 _tokenId) internal pure returns (string memory) {
        string memory result = "{";
        // density
        result = string.concat(result, _quote("density"));
        result = string.concat(result, ":");
        result = string.concat(result, _quote(Traits.densityTrait(_seed, _tokenId)));
        result = string.concat(result, ",");
        // polarity
        result = string.concat(result, _quote("polarity"));
        result = string.concat(result, ":");
        result = string.concat(result, _quote(Traits.polarityTrait(_seed, _tokenId)));
        result = string.concat(result, ",");
        // glints
        result = string.concat(result, _quote("glints"));
        result = string.concat(result, ":");
        result = string.concat(result, _quote(Traits.glintTrait(_seed)));
        result = string.concat(result, ",");
        // motes
        result = string.concat(result, _quote("motes"));
        result = string.concat(result, ":");
        result = string.concat(result, _quote(Traits.moteTrait(_seed)));
        result = string.concat(result, ",");
        // eyes
        result = string.concat(result, _quote("eyes"));
        result = string.concat(result, ":");
        result = string.concat(result, _quote(Traits.eyeTrait(_seed)));
        result = string.concat(result, ",");
        // mouth
        result = string.concat(result, _quote("mouth"));
        result = string.concat(result, ":");
        result = string.concat(result, _quote(Traits.mouthTrait(_seed)));
        result = string.concat(result, ",");
        // cheeks
        result = string.concat(result, _quote("cheeks"));
        result = string.concat(result, ":");
        result = string.concat(result, _quote(Traits.cheekTrait(_seed)));
        result = string.concat(result, ",");
        // virtue
        result = string.concat(result, _quote("virtue"));
        result = string.concat(result, ":");
        result = string.concat(result, _quote(Traits.virtueTrait(_seed)));

        result = string.concat(result, "}");
        return result;
    }

    function _background(bytes32 _seed, uint256 _tokenId) internal pure returns (string memory) {
        return _quote(Palette.backgroundFill(_seed, _tokenId));
    }

    function _motes(bytes32 _seed, uint256 _tokenId) internal pure returns (string memory) {
        if (Traits.moteType(_seed) == MoteType.NONE) return "[]";

        string memory result = "[";
        for (uint8 i = 0; i < MOTE_COUNT; ++i) {
            uint256 moteSeed = uint256(keccak256(abi.encodePacked(_seed, "mote", i)));

            moteSeed /= Data.length; // dur
            moteSeed /= Data.length; // delay
            string[2] memory coords = Data.motePoints(moteSeed /= Data.length);
            string memory radius = (moteSeed /= 2) % 2 == 0 ? "1" : "2";
            string memory opacity = Palette.opacity(moteSeed /= Palette.opacityLength, _seed, _tokenId);
            // reverse

            string memory mote = "{";
            mote = string.concat(mote, _quote("coords"), ":", _coords(coords));
            mote = string.concat(mote, ",");
            mote = string.concat(mote, _quote("radius"), ":", _quote(radius));
            mote = string.concat(mote, ",");
            mote = string.concat(mote, _quote("opacity"), ":", _quote(opacity));
            mote = string.concat(mote, "}");

            if (i > 0) mote = string.concat(",", mote);
            result = string.concat(result, mote);
        }

        result = string.concat(result, "]");

        return result;
    }

    function _glints(bytes32 _seed) internal pure returns (string memory) {
        uint256 glintCount = Traits.glintCount(_seed);

        uint256 glintSeed = uint256(keccak256(abi.encodePacked(_seed, "glint")));
        glintSeed /= 2; // reverseRotate
        glintSeed /= 2; // reverse
        string[2][3] memory coords = Data.glintPoints(glintSeed);

        string memory result = "[";
        for (uint8 index = 0; index < glintCount; ++index) {
            result = string.concat(result, _coords(coords[index]));
            if (index < glintCount - 1) result = string.concat(result, ",");
        }
        result = string.concat(result, "]");
        return result;
    }

    function _body(bytes32 _seed, uint256 _tokenId) internal pure returns (string memory) {
        string memory result = "[";
        for (uint8 index = 0; index < CIRCLES_COUNT; ++index) {
            result = string.concat(result, _bodyCircle(_seed, index, _tokenId));
            if (index < CIRCLES_COUNT - 1) result = string.concat(result, ",");
        }
        result = string.concat(result, "]");

        return result;
    }

    function _bodyCircle(
        bytes32 _seed,
        uint256 _index,
        uint256 _tokenId
    ) internal pure returns (string memory) {
        string[7] memory radii = ["64", "64", "64", "56", "48", "32", "24"];

        uint256 bodySeed = uint256(keccak256(abi.encodePacked(_seed, "body", _index)));
        string memory bodyFill1 = Palette.bodyFill(_seed, _index, _tokenId);
        string memory bodyFill2 = Palette.bodyFill(_seed, _index + CIRCLES_COUNT, _tokenId);
        bodySeed /= Data.length;
        string[2] memory coords = (_index == 0) ? ["150", "150"] : Data.bodyPoints(bodySeed /= 2);

        string memory result = "{";
        result = string.concat(result, _quote("fill"), ":", _quote(bodyFill1));
        result = string.concat(result, ",");
        if (_tokenId == 0) {
            result = string.concat(result, _quote("fill2"), ":", _quote(bodyFill2));
            result = string.concat(result, ",");
        }
        result = string.concat(result, _quote("coords"), ":", _coords(coords));
        result = string.concat(result, ",");
        result = string.concat(result, _quote("radius"), ":", _quote(radii[_index]));
        result = string.concat(result, "}");
        return result;
    }

    function _keyValue(string memory _key, string memory _value) internal pure returns (string memory) {
        return string.concat(_quote(_key), ":", _value);
    }

    function _quote(string memory _value) internal pure returns (string memory) {
        return string.concat('"', _value, '"');
    }

    function _coords(string[2] memory __coords) internal pure returns (string memory) {
        return
            string.concat("{", _quote("x"), ":", _quote(__coords[0]), ",", _quote("y"), ":", _quote(__coords[1]), "}");
    }
}
