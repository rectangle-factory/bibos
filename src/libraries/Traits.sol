// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Glints, GlintType} from "./Glints.sol";
import {Eyes, EyeType} from "./Eyes.sol";
import {Cheeks, CheekType} from "./Cheeks.sol";
import {Mouth, MouthType} from "./Mouth.sol";
import {Motes} from "./Motes.sol";
import {Util} from "./Util.sol";

library Traits {
    /*//////////////////////////////////////////////////////////////
                                 TRAITS
    //////////////////////////////////////////////////////////////*/

    function getTraits(bytes32 _seed) internal pure returns (string memory) {
        string memory result = "[";

        // refractivity
        Palette.Refractivity refractivity = Palette.getRefractivity(_seed);
        string memory refractivityTrait = getRefractivityTrait(refractivity);
        result = string.concat(result, trait("Refractivity", refractivityTrait));

        // glints
        GlintType glintType = getGlintType(_seed);
        string memory glintTrait = getGlintTrait(glintType);
        result = string.concat(result, ",", trait("Glint", glintTrait));

        // eyes
        EyeType eyeType = getEyeType(_seed);
        string memory eyeTrait = getEyeTrait(eyeType);
        result = string.concat(result, ",", trait("Eyes", eyeTrait));

        // mouth
        MouthType mouthType = getMouthType(_seed);
        string memory mouthTrait = getMouthTrait(mouthType);
        result = string.concat(result, ",", trait("Mouth", mouthTrait));

        // cheeks
        CheekType cheekType = getCheekType(_seed);
        string memory cheekTrait = getCheekTrait(cheekType);
        result = string.concat(result, ",", trait("Cheeks", cheekTrait));

        // motes
        uint256 moteCount = Motes.getMoteCount(_seed);
        string memory moteTrait = getMoteTrait(moteCount);
        result = string.concat(result, ",", trait("Motes", moteTrait));

        return string.concat(result, "]");
    }

    /*//////////////////////////////////////////////////////////////
                              REFRACTIVITY
    //////////////////////////////////////////////////////////////*/

    function getRefractivityTrait(Palette.Refractivity _refractivity) internal pure returns (string memory) {
        return _refractivity == Palette.Refractivity.LIGHT ? "Light" : "Dark";
    }

    /*//////////////////////////////////////////////////////////////
                                  GLINT
    //////////////////////////////////////////////////////////////*/

    function getGlintTrait(GlintType _glintType) internal pure returns (string memory) {
        if (_glintType == GlintType.FLOATING) return "Floating";
        if (_glintType == GlintType.RISING) return "Rising";
        if (_glintType == GlintType.FALLING) return "Falling";
        return "None";
    }

    function getGlintType(bytes32 _seed) internal pure returns (GlintType) {
        uint256 glintTypeSeed = uint256(keccak256(abi.encodePacked(_seed, "glintType"))) % 100;

        if (glintTypeSeed % 100 < 20) return GlintType.FLOATING;
        if (glintTypeSeed % 100 < 35) return GlintType.RISING;
        if (glintTypeSeed % 100 < 40) return GlintType.FALLING;
        return GlintType.NONE;
    }

    /*//////////////////////////////////////////////////////////////
                                   EYE
    //////////////////////////////////////////////////////////////*/

    function getEyeTrait(EyeType _eyeType) internal pure returns (string memory) {
        if (_eyeType == EyeType.OPEN) return "Open";
        if (_eyeType == EyeType.SMILEY) return "Smiley";
        if (_eyeType == EyeType.WINK) return "Wink";
        if (_eyeType == EyeType.SLEEPY) return "Sleepy";
        if (_eyeType == EyeType.CLOVER) return "Clover";
        if (_eyeType == EyeType.DIZZY) return "Dizzy";
        if (_eyeType == EyeType.HEART) return "Heart";
        if (_eyeType == EyeType.WINCE) return "Wince";
        if (_eyeType == EyeType.CYCLOPS) return "Cyclops";
        return "Star";
    }

    function getEyeType(bytes32 _seed) internal pure returns (EyeType) {
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

    function getMouthTrait(MouthType _mouthType) internal pure returns (string memory) {
        if (_mouthType == MouthType.SMILE) return "Smile";
        if (_mouthType == MouthType.MEDIUM_SMILE) return "Medium Smile";
        if (_mouthType == MouthType.SMALL_SMILE) return "Small Smile";
        if (_mouthType == MouthType.FLAT) return "Flat";
        if (_mouthType == MouthType.FROWN) return "Frown";
        if (_mouthType == MouthType.GRIN) return "Grin";
        return "Smooch";
    }

    function getMouthType(bytes32 _seed) internal pure returns (MouthType) {
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

    function getCheekTrait(CheekType _cheekType) internal pure returns (string memory) {
        if (_cheekType == CheekType.NONE) return "None";
        if (_cheekType == CheekType.CIRCULAR) return "Circular";
        return "Freckles";
    }

    function getCheekType(bytes32 _seed) internal pure returns (CheekType) {
        uint256 cheeksSeed = uint256(keccak256(abi.encodePacked(_seed, "cheeks"))) % 100;

        if (cheeksSeed % 100 < 70) return CheekType.NONE;
        if (cheeksSeed % 100 < 95) return CheekType.CIRCULAR;
        return CheekType.FRECKLES;
    }

    /*//////////////////////////////////////////////////////////////
                                  MOTES
    //////////////////////////////////////////////////////////////*/

    function getMoteTrait(uint256 _moteCount) internal pure returns (string memory) {
        return Util.uint256ToString(_moteCount);
    }

    /*//////////////////////////////////////////////////////////////
                                INTERNAL
    //////////////////////////////////////////////////////////////*/

    function trait(string memory _traitType, string memory _value) internal pure returns (string memory) {
        return string.concat("{", Util.keyValue("trait_type", _traitType), ",", Util.keyValue("value", _value), "}");
    }
}
