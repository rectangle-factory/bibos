// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { Palette } from './Palette.sol';
import { Glints } from './Glints.sol';
import { Util } from './Util.sol';

library Traits {
  function getTraits(bytes32 _seed) internal pure returns (string memory) {
    string memory result;

    // refractivity
    Palette.Refractivity refractivity = Palette.getRefractivity(_seed);
    string memory refractivityTrait = getRefractivityTrait(refractivity);
    result = appendTrait(result, trait('refractivity', refractivityTrait));

    // glint type
    Glints.GlintType glintType = Glints.getGlintType(_seed);
    string memory glintTypeTrait = getGlintTypeTrait(glintType);
    result = appendTrait(result, trait('glintType', glintTypeTrait));

    // moute count
    // eye type
    // mouth type
    // cheek type

    return result;
  }

  function getRefractivityTrait(Palette.Refractivity _refracivity)
    internal
    pure
    returns (string memory)
  {
    return _refracivity == Palette.Refractivity.LIGHT ? 'light' : 'dark';
  }

  function getGlintTypeTrait(Glints.GlintType _glintType)
    internal
    pure
    returns (string memory)
  {
    if (_glintType == Glints.GlintType.FLOATING) return 'floating';
    if (_glintType == Glints.GlintType.RISING) return 'rising';
    if (_glintType == Glints.GlintType.FALLING) return 'falling';
    return 'none';
  }

  function appendTrait(string memory _result, string memory _trait)
    internal
    pure
    returns (string memory)
  {
    return string.concat(_result, ',', _trait);
  }

  function trait(string memory _traitType, string memory _value)
    internal
    pure
    returns (string memory)
  {
    return
      string.concat(
        '{',
        Util.keyValue('trait_type', _traitType),
        ',',
        Util.keyValue('value', _value),
        '}'
      );
  }
}
