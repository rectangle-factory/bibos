// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Glints} from "./Glints.sol";
import {Eyes} from "./Eyes.sol";
import {Cheeks} from "./Cheeks.sol";
import {Mouth} from "./Mouth.sol";
import {Motes} from "./Motes.sol";
import {Util} from "./Util.sol";

library Traits {
    function getTraits(bytes32 _seed) internal pure returns (string memory) {
        string memory result;

        // refractivity
        Palette.Refractivity refractivity = Palette.getRefractivity(_seed);
        string memory refractivityTrait = getRefractivityTrait(refractivity);
        result = trait("refractivity", refractivityTrait);

        // glint
        Glints.GlintType glintType = Glints.getGlintType(_seed);
        string memory glintTrait = getGlintTrait(glintType);
        result = appendTrait(result, trait("glint", glintTrait));

        // eyes
        Eyes.EyeType eyeType = Eyes.getEyeType(_seed);
        string memory eyeTrait = getEyeTrait(eyeType);
        result = appendTrait(result, trait("eyes", eyeTrait));

        // mouth
        Mouth.MouthType mouthType = Mouth.getMouthType(_seed);
        string memory mouthTrait = getMouthTrait(mouthType);
        result = appendTrait(result, trait("mouth", mouthTrait));

        // cheeks
        Cheeks.CheekType cheekType = Cheeks.getCheekType(_seed);
        string memory cheekTrait = getCheekTrait(cheekType);
        result = appendTrait(result, trait("cheeks", cheekTrait));

        // mote
        uint256 moteCount = Motes.getMoteCount(_seed);
        string memory moteTrait = getMoteTrait(moteCount);
        result = appendTrait(result, trait("motes", moteTrait));

        return result;
    }

    function getRefractivityTrait(Palette.Refractivity _refractivity) internal pure returns (string memory) {
        return _refractivity == Palette.Refractivity.LIGHT ? "Light" : "Dark";
    }

    function getGlintTrait(Glints.GlintType _glintType) internal pure returns (string memory) {
        if (_glintType == Glints.GlintType.FLOATING) return "Floating";
        if (_glintType == Glints.GlintType.RISING) return "Rising";
        if (_glintType == Glints.GlintType.FALLING) return "Falling";
        return "none";
    }

    function getEyeTrait(Eyes.EyeType _eyeType) internal pure returns (string memory) {
        if (_eyeType == Eyes.EyeType.OPEN) return "Open";
        if (_eyeType == Eyes.EyeType.SMILEY) return "Smiley";
        if (_eyeType == Eyes.EyeType.WINK) return "Wink";
        if (_eyeType == Eyes.EyeType.SLEEPY) return "Sleepy";
        if (_eyeType == Eyes.EyeType.CLOVER) return "Clover";
        if (_eyeType == Eyes.EyeType.DIZZY) return "Dizzy";
        if (_eyeType == Eyes.EyeType.HEART) return "Heart";
        if (_eyeType == Eyes.EyeType.WINCE) return "Wince";
        if (_eyeType == Eyes.EyeType.CYCLOPS) return "Cyclops";
        return "Star";
    }

    function getMouthTrait(Mouth.MouthType _mouthType) internal pure returns (string memory) {
        if (_mouthType == Mouth.MouthType.SMILE) return "Smile";
        if (_mouthType == Mouth.MouthType.MEDIUM_SMILE) return "Medium Smile";
        if (_mouthType == Mouth.MouthType.SMALL_SMILE) return "Small Smile";
        if (_mouthType == Mouth.MouthType.FLAT) return "Flat";
        if (_mouthType == Mouth.MouthType.FROWN) return "Frown";
        if (_mouthType == Mouth.MouthType.GRIN) return "Grin";
        return "Smooch";
    }

    function getCheekTrait(Cheeks.CheekType _cheekType) internal pure returns (string memory) {
        if (_cheekType == Cheeks.CheekType.NONE) return "None";
        if (_cheekType == Cheeks.CheekType.CIRCULAR) return "Circular";
        return "Freckles";
    }

    function getMoteTrait(uint256 _moteCount) internal pure returns (string memory) {
        return Util.uint256ToAscii(_moteCount);
    }

    function appendTrait(string memory _result, string memory _trait) internal pure returns (string memory) {
        return string.concat(_result, ",", _trait);
    }

    function trait(string memory _traitType, string memory _value) internal pure returns (string memory) {
        return string.concat("{", Util.keyValue("trait_type", _traitType), ",", Util.keyValue("value", _value), "}");
    }
}
