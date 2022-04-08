// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Glints} from "./Glints.sol";
import {Eyes} from "./Eyes.sol";
import {Mouth} from "./Mouth.sol";
import {Mote} from "./Mote.sol";
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
        string memory glintTrait = getGlintTypeTrait(glintType);
        result = appendTrait(result, trait("glint", glintTrait));

        // eyes
        Eyes.EyeType eyeType = eyes.getEyeType(_seed);
        string memory eyeTrait = getEyeTrait(eye);
        result = appendTrait(result, trait("eyes", eyeTrait));

        // mouth
        Mouth.MouthType mouthType = Mouth.getMouthType(_seed);
        string memory mouthTrait = getMouthTrait(mouthType);
        result = appendTrait(result, trait("mouth", mouthTrait));

        // cheeks
        Cheeks.CheekType cheekType = cheeks.getcheekType(_seed);
        string memory cheekTrait = getCheekTrait(cheekType);
        result = appendTrait(result, trait("cheeks", cheekTrait));

        // mote
        uint256 moteCount = motes.getMoteCount(_seed);
        string memory moteTrait = getMoteTrait(_moteCount);
        result = appendTrait(result, trait("motes", moteTrait));

        return result;
    }

    function getRefractivityTrait(Palette.Refractivity _refracivity) internal pure returns (string memory) {
        return _refractivity == Palette.Refractivity.LIGHT ? "Light" : "Dark";
    }

    function getGlintTrait(Glints.GlintType _glintType) internal pure returns (string memory) {
        if (_glintType == Glints.GlintType.FLOATING) return "Floating";
        if (_glintType == Glints.GlintType.RISING) return "Rising";
        if (_glintType == Glints.GlintType.FALLING) return "Falling";
        return "none";
    }

    function getEyeTrait(Eye.EyeType _eyeType) internal pure returns (string memory) {
        if (_eyeType == Eye.EyeType.Star) return "Star";
        if (_eyeType == Eye.EyeType.Cyclops) return "Cyclops";
        if (_eyeType == Eye.EyeType.Wince) return "Wince";
        if (_eyeType == Eye.EyeType.Heart) return "Heart";
        if (_eyeType == Eye.EyeType.Dizzy) return "Dizzy";
        if (_eyeType == Eye.EyeType.Clover) return "Clover";
        if (_eyeType == Eye.EyeType.Sleepy) return "Sleepy";
        if (_eyeType == Eye.EyeType.Wink) return "Wink";
        if (_eyeType == Eye.EyeType.Smiley) return "Smiley";
        return "Open";
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
        if (_mouthType == Cheeks.CheekType.NONE) return "None";
        if (_mouthType == Cheeks.CheekType.CIRCULAR) return "Circular";
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
