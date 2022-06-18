// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {RefractivityType} from "./Palette.sol";
import {GlintType} from "./Glints.sol";
import {EyeType} from "./Eyes.sol";
import {CheekType} from "./Cheeks.sol";
import {MouthType} from "./Mouth.sol";
import {Motes} from "./Motes.sol";
import {Util} from "./Util.sol";

library Traits {
    /*//////////////////////////////////////////////////////////////
                                 TRAITS
    //////////////////////////////////////////////////////////////*/

    function attributes(bytes32 _seed) internal pure returns (string memory) {
        string memory result = "[";

        result = string.concat(result, _attribute("Refractivity", refractivityTrait(_seed)));
        result = string.concat(result, ",", _attribute("Glint", glintTrait(_seed)));
        result = string.concat(result, ",", _attribute("Eyes", eyeTrait(_seed)));
        result = string.concat(result, ",", _attribute("Eyes", mouthTrait(_seed)));
        result = string.concat(result, ",", _attribute("Cheeks", cheekTrait(_seed)));
        result = string.concat(result, ",", _attribute("Motes", moteTrait(_seed)));
        return string.concat(result, "]");
    }

    function _attribute(string memory _traitType, string memory _value) internal pure returns (string memory) {
        return string.concat("{", Util.keyValue("trait_type", _traitType), ",", Util.keyValue("value", _value), "}");
    }

    /*//////////////////////////////////////////////////////////////
                              REFRACTIVITY
    //////////////////////////////////////////////////////////////*/

    function refractivityTrait(bytes32 _seed) internal pure returns (string memory) {
        RefractivityType type_ = refractivityType(_seed);
        return type_ == RefractivityType.LIGHT ? "Light" : "Dark";
    }

    function refractivityType(bytes32 _seed) internal pure returns (RefractivityType) {
        uint256 refractivitySeed = uint256(keccak256(abi.encodePacked(_seed, "refractivity"))) % 100;

        if (refractivitySeed < 80) return RefractivityType.LIGHT;
        return RefractivityType.DARK;
    }

    /*//////////////////////////////////////////////////////////////
                                  GLINT
    //////////////////////////////////////////////////////////////*/

    function glintTrait(bytes32 _seed) internal pure returns (string memory) {
        GlintType type_ = glintType(_seed);
        if (type_ == GlintType.FLOATING) return "Floating";
        if (type_ == GlintType.RISING) return "Rising";
        if (type_ == GlintType.FALLING) return "Falling";
        return "None";
    }

    function glintType(bytes32 _seed) internal pure returns (GlintType) {
        uint256 glintTypeSeed = uint256(keccak256(abi.encodePacked(_seed, "glintType"))) % 100;

        if (glintTypeSeed % 100 < 20) return GlintType.FLOATING;
        if (glintTypeSeed % 100 < 35) return GlintType.RISING;
        if (glintTypeSeed % 100 < 40) return GlintType.FALLING;
        return GlintType.NONE;
    }

    /*//////////////////////////////////////////////////////////////
                                   EYE
    //////////////////////////////////////////////////////////////*/

    function eyeTrait(bytes32 _seed) internal pure returns (string memory) {
        EyeType type_ = eyeType(_seed);
        if (type_ == EyeType.OPEN) return "Open";
        if (type_ == EyeType.SMILEY) return "Smiley";
        if (type_ == EyeType.WINK) return "Wink";
        if (type_ == EyeType.SLEEPY) return "Sleepy";
        if (type_ == EyeType.CLOVER) return "Clover";
        if (type_ == EyeType.DIZZY) return "Dizzy";
        if (type_ == EyeType.HEART) return "Heart";
        if (type_ == EyeType.WINCE) return "Wince";
        if (type_ == EyeType.CYCLOPS) return "Cyclops";
        return "Star";
    }

    function eyeType(bytes32 _seed) internal pure returns (EyeType) {
        uint256 eyeSeed = uint256(keccak256(abi.encodePacked(_seed, "eye"))) % 100;

        if (eyeSeed % 100 < 25) return EyeType.OPEN;
        if (eyeSeed % 100 < 50) return EyeType.SMILEY;
        if (eyeSeed % 100 < 65) return EyeType.WINK;
        if (eyeSeed % 100 < 75) return EyeType.SLEEPY;
        if (eyeSeed % 100 < 83) return EyeType.CLOVER;
        if (eyeSeed % 100 < 89) return EyeType.DIZZY;
        if (eyeSeed % 100 < 94) return EyeType.HEART;
        if (eyeSeed % 100 < 97) return EyeType.WINCE;
        if (eyeSeed % 100 < 99) return EyeType.CYCLOPS;
        return EyeType.STAR;
    }

    /*//////////////////////////////////////////////////////////////
                                  MOUTH
    //////////////////////////////////////////////////////////////*/

    function mouthTrait(bytes32 _seed) internal pure returns (string memory) {
        MouthType type_ = mouthType(_seed);
        if (type_ == MouthType.SMILE) return "Smile";
        if (type_ == MouthType.MEDIUM_SMILE) return "Medium Smile";
        if (type_ == MouthType.SMALL_SMILE) return "Small Smile";
        if (type_ == MouthType.FLAT) return "Flat";
        if (type_ == MouthType.FROWN) return "Frown";
        if (type_ == MouthType.GRIN) return "Grin";
        return "Smooch";
    }

    function mouthType(bytes32 _seed) internal pure returns (MouthType) {
        uint256 mouthTypeSeed = uint256(keccak256(abi.encodePacked(_seed, "mouthType"))) % 100;

        if (mouthTypeSeed % 100 < 30) return MouthType.SMILE;
        if (mouthTypeSeed % 100 < 60) return MouthType.MEDIUM_SMILE;
        if (mouthTypeSeed % 100 < 80) return MouthType.SMALL_SMILE;
        if (mouthTypeSeed % 100 < 90) return MouthType.FLAT;
        if (mouthTypeSeed % 100 < 94) return MouthType.FROWN;
        if (mouthTypeSeed % 100 < 97) return MouthType.GRIN;
        if (mouthTypeSeed % 100 < 99) return MouthType.SMOOCH;
        return MouthType.SMIRK;
    }

    /*//////////////////////////////////////////////////////////////
                                 CHEEKS
    //////////////////////////////////////////////////////////////*/

    function cheekTrait(bytes32 _seed) internal pure returns (string memory) {
        CheekType type_ = cheekType(_seed);
        if (type_ == CheekType.NONE) return "None";
        if (type_ == CheekType.CIRCULAR) return "Circular";
        return "Freckles";
    }

    function cheekType(bytes32 _seed) internal pure returns (CheekType) {
        uint256 cheeksSeed = uint256(keccak256(abi.encodePacked(_seed, "cheeks"))) % 100;

        if (cheeksSeed % 100 < 70) return CheekType.NONE;
        if (cheeksSeed % 100 < 95) return CheekType.CIRCULAR;
        return CheekType.FRECKLES;
    }

    /*//////////////////////////////////////////////////////////////
                                  MOTES
    //////////////////////////////////////////////////////////////*/

    function moteTrait(bytes32 _seed) internal pure returns (string memory) {
        uint256 count_ = moteCount(_seed);
        return Util.uint256ToString(count_);
    }

    function moteCount(bytes32 _seed) internal pure returns (uint256) {
        uint256 moteSeed = uint256(keccak256(abi.encodePacked(_seed, "mote"))) % 100;

        if (moteSeed % 100 < 1) return 3;
        if (moteSeed % 100 < 5) return 2;
        if (moteSeed % 100 < 35) return 1;
        return 0;
    }
}
