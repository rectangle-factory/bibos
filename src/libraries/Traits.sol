// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {DensityType, PolarityType} from "./Palette.sol";
import {MoteType} from "./Motes.sol";
import {EyeType} from "./Eyes.sol";
import {CheekType} from "./Cheeks.sol";
import {MouthType} from "./Mouth.sol";
import {Glints} from "./Glints.sol";
import {Util} from "./Util.sol";

library Traits {
    /*//////////////////////////////////////////////////////////////
                                 TRAITS
    //////////////////////////////////////////////////////////////*/

    function attributes(bytes32 _seed) internal pure returns (string memory) {
        string memory result = "[";
        result = string.concat(result, _attribute("Density", densityTrait(_seed)));
        result = string.concat(result, ",", _attribute("Polarity", polarityTrait(_seed)));
        result = string.concat(result, ",", _attribute("Glints", glintTrait(_seed)));
        result = string.concat(result, ",", _attribute("Motes", moteTrait(_seed)));
        result = string.concat(result, ",", _attribute("Eyes", eyeTrait(_seed)));
        result = string.concat(result, ",", _attribute("Mouth", mouthTrait(_seed)));
        result = string.concat(result, ",", _attribute("Cheeks", cheekTrait(_seed)));
        return string.concat(result, "]");
    }

    function _attribute(string memory _traitType, string memory _value) internal pure returns (string memory) {
        return string.concat("{", Util.keyValue("trait_type", _traitType), ",", Util.keyValue("value", _value), "}");
    }

    function _computeSeed(bytes32 _seed, string memory _salt) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(_seed, _salt))) % 100;
    }

    /*//////////////////////////////////////////////////////////////
                              DENSITY
    //////////////////////////////////////////////////////////////*/

    function densityTrait(bytes32 _seed) internal pure returns (string memory) {
        DensityType type_ = densityType(_seed);
        return type_ == DensityType.HIGH ? "High" : "Low";
    }

    function densityType(bytes32 _seed) internal pure returns (DensityType) {
        uint256 densitySeed = _computeSeed(_seed, "density");

        if (densitySeed < 80) return DensityType.HIGH;
        return DensityType.LOW;
    }

    /*//////////////////////////////////////////////////////////////
                              POLARITY
    //////////////////////////////////////////////////////////////*/

    function polarityTrait(bytes32 _seed) internal pure returns (string memory) {
        PolarityType polarityType_ = polarityType(_seed);
        return polarityType_ == PolarityType.POSITIVE ? "Positive" : "Negative";
    }

    function polarityType(bytes32 _seed) internal pure returns (PolarityType) {
        uint256 polaritySeed = _computeSeed(_seed, "polarity");

        if (polaritySeed < 80) return PolarityType.POSITIVE;
        return PolarityType.NEGATIVE;
    }

    /*//////////////////////////////////////////////////////////////
                                  MOTE
    //////////////////////////////////////////////////////////////*/

    function moteTrait(bytes32 _seed) internal pure returns (string memory) {
        MoteType type_ = moteType(_seed);

        if (type_ == MoteType.FLOATING) return "Floating";
        if (type_ == MoteType.RISING) return "Rising";
        if (type_ == MoteType.FALLING) return "Falling";
        if (type_ == MoteType.GLISTENING) return "Glistening";
        return "None";
    }

    function moteType(bytes32 _seed) internal pure returns (MoteType) {
        uint256 moteSeed = _computeSeed(_seed, "mote");

        if (moteSeed < 20) return MoteType.FLOATING;
        if (moteSeed < 35) return MoteType.RISING;
        if (moteSeed < 40) return MoteType.FALLING;
        if (moteSeed < 50) return MoteType.GLISTENING;
        return MoteType.NONE;
    }

    /*//////////////////////////////////////////////////////////////
                                   EYE
    //////////////////////////////////////////////////////////////*/

    function eyeTrait(bytes32 _seed) internal pure returns (string memory) {
        EyeType type_ = eyeType(_seed);

        if (type_ == EyeType.OPEN) return "Open";
        if (type_ == EyeType.SMILEY) return "Smiley";
        if (type_ == EyeType.WINK) return "Wink";
        if (type_ == EyeType.ROUND) return "Round";
        if (type_ == EyeType.SLEEPY) return "Sleepy";
        if (type_ == EyeType.CLOVER) return "Clover";
        if (type_ == EyeType.STAR) return "Star";
        if (type_ == EyeType.DIZZY) return "Dizzy";
        if (type_ == EyeType.HEART) return "Heart";
        if (type_ == EyeType.HAHA) return "Haha";
        if (type_ == EyeType.CYCLOPS) return "Cyclops";
        return "Opal";
    }

    function eyeType(bytes32 _seed) internal pure returns (EyeType) {
        uint256 eyeSeed = uint256(keccak256(abi.encodePacked(_seed, "eye"))) % 100;

        if (eyeSeed % 100 < 25) return EyeType.OPEN;
        if (eyeSeed % 100 < 50) return EyeType.SMILEY;
        if (eyeSeed % 100 < 65) return EyeType.WINK;
        if (eyeSeed % 100 < 70) return EyeType.ROUND;
        if (eyeSeed % 100 < 75) return EyeType.SLEEPY;
        if (eyeSeed % 100 < 83) return EyeType.CLOVER;
        if (eyeSeed % 100 < 85) return EyeType.STAR;
        if (eyeSeed % 100 < 89) return EyeType.DIZZY;
        if (eyeSeed % 100 < 94) return EyeType.HEART;
        if (eyeSeed % 100 < 97) return EyeType.HAHA;
        if (eyeSeed % 100 < 99) return EyeType.CYCLOPS;
        return EyeType.OPAL;
    }

    /*//////////////////////////////////////////////////////////////
                                  MOUTH
    //////////////////////////////////////////////////////////////*/

    function mouthTrait(bytes32 _seed) internal pure returns (string memory) {
        MouthType type_ = mouthType(_seed);
        if (type_ == MouthType.SMILE) return "Smile";
        if (type_ == MouthType.SMIRK) return "Smirk";
        if (type_ == MouthType.MEDIUM_SMILE) return "Medium Smile";
        if (type_ == MouthType.SMALL_SMILE) return "Small Smile";
        if (type_ == MouthType.FLAT) return "Flat";
        if (type_ == MouthType.OOO) return "Ooo";
        if (type_ == MouthType.TOOTHY) return "Toothy";
        if (type_ == MouthType.VEE) return "Vee";
        if (type_ == MouthType.GRIN) return "Grin";
        return "Smooch";
    }

    function mouthType(bytes32 _seed) internal pure returns (MouthType) {
        uint256 mouthSeed = _computeSeed(_seed, "mouth");

        if (mouthSeed % 100 < 30) return MouthType.SMILE;
        if (mouthSeed % 100 < 50) return MouthType.MEDIUM_SMILE;
        if (mouthSeed % 100 < 60) return MouthType.SMIRK;
        if (mouthSeed % 100 < 80) return MouthType.SMALL_SMILE;
        if (mouthSeed % 100 < 90) return MouthType.GRIN;
        if (mouthSeed % 100 < 92) return MouthType.VEE;
        if (mouthSeed % 100 < 94) return MouthType.OOO;
        if (mouthSeed % 100 < 97) return MouthType.FLAT;
        if (mouthSeed % 100 < 98) return MouthType.TOOTHY;
        if (mouthSeed % 100 < 99) return MouthType.SMOOCH;
        return MouthType.CAT;
    }

    /*//////////////////////////////////////////////////////////////
                                 CHEEKS
    //////////////////////////////////////////////////////////////*/

    function cheekTrait(bytes32 _seed) internal pure returns (string memory) {
        CheekType type_ = cheekType(_seed);
        if (type_ == CheekType.NONE) return "None";
        if (type_ == CheekType.CIRCULAR) return "Circular";
        if (type_ == CheekType.BIG) return "Big";
        return "Freckles";
    }

    function cheekType(bytes32 _seed) internal pure returns (CheekType) {
        uint256 cheeksSeed = _computeSeed(_seed, "cheeks");

        if (cheeksSeed % 100 < 70) return CheekType.NONE;
        if (cheeksSeed % 100 < 85) return CheekType.CIRCULAR;
        if (cheeksSeed % 100 < 95) return CheekType.BIG;
        return CheekType.FRECKLES;
    }

    /*//////////////////////////////////////////////////////////////
                                  GLINT
    //////////////////////////////////////////////////////////////*/

    function glintTrait(bytes32 _seed) internal pure returns (string memory) {
        uint256 count_ = glintCount(_seed);
        return Util.uint256ToString(count_);
    }

    function glintCount(bytes32 _seed) internal pure returns (uint256) {
        uint256 glintSeed = _computeSeed(_seed, "glint");

        if (glintSeed < 1) return 3;
        if (glintSeed < 5) return 2;
        if (glintSeed < 35) return 1;
        return 0;
    }
}
