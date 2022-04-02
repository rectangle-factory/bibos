// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { Color } from './Color.sol';
import { Times } from './Times.sol';
import { Points } from './Points.sol';
import { Util } from './Util.sol';
import { SVG } from './SVG.sol';

library Glints {
  uint256 constant GLINT_COUNT = 16;

  function render(bytes32 _seed) internal pure returns (string memory result) {
    Color.CM cm = Color.CM.DARK;
    string memory mixMode = cm == Color.CM.LIGHT ? 'lighten' : 'color-burn';
    string memory fill = cm == Color.CM.LIGHT ? 'white' : 'black';

    for (uint8 index = 0; index < GLINT_COUNT; index++) {
      // generate new random seed
      uint256 glintSeed = uint256(
        keccak256(abi.encodePacked(_seed, 'glint', index))
      );

      string memory dur = Times.long(glintSeed);
      glintSeed = glintSeed / Times.length;
      string[2] memory coords = Points.glint(glintSeed);
      glintSeed = glintSeed / Points.length;
      string memory radius = glintSeed % 2 == 0 ? '1' : '2';
      glintSeed = glintSeed / 2;

      // glintType == FLOATING
      // 20%
      if (glintSeed % 100 < 20) {
        string memory reverse = glintSeed % 2 == 0
          ? "keyPoints='1;0' keyTimes='0;1'"
          : '';
        addFloatingGlint(result, radius, coords, mixMode, fill, dur, reverse);
      }
      // glintType == RISING
      // 15%
      else if (glintSeed % 100 < 35) {
        addRisingGlint(result, radius, coords, mixMode, fill, dur);
      }
      // 40%
      // glintType == FALLING
      else if (glintSeed % 100 < 40) {
        addFallingGlint(result, radius, coords, mixMode, fill, dur);
      }
      // else no glint
      // 60%
    }
  }

  function addRisingGlint(
    string memory _result,
    string memory _radius,
    string[2] memory _coords,
    string memory _mixMode,
    string memory _fill,
    string memory _dur
  ) internal pure {
    _result = string.concat(
      _result,
      '<g transform="translate(0,50)">',
      SVG.circle(_radius, _coords, _mixMode, _fill, '0.5'),
      animateTransform(_dur, '-100'),
      SVG.animate(_dur),
      '</circle>',
      '</g>'
    );
  }

  function addFloatingGlint(
    string memory _result,
    string memory _radius,
    string[2] memory _coords,
    string memory _mixMode,
    string memory _fill,
    string memory _dur,
    string memory _reverse
  ) internal pure {
    _result = string.concat(
      _result,
      SVG.circle(_radius, _coords, _mixMode, _fill, '0.75'),
      SVG.animateMotion(
        _reverse,
        _dur,
        'paced',
        '<mpath xlink:href="#jitter-sm"/>'
      ),
      '</circle>'
    );
  }

  function addFallingGlint(
    string memory _result,
    string memory _radius,
    string[2] memory _coords,
    string memory _mixMode,
    string memory _fill,
    string memory _dur
  ) internal pure {
    _result = string.concat(
      _result,
      '<g>',
      SVG.circle(_radius, _coords, _mixMode, _fill, '0.5'),
      animateTransform(_dur, '100'),
      SVG.animate(_dur),
      '</circle>',
      '</g>'
    );
  }

  function animateTransform(string memory _dur, string memory _to)
    internal
    pure
    returns (string memory)
  {
    return
      string.concat(
        '<animateTransform ',
        'attributeType="XML" ',
        'attributeName="transform" ',
        'dur=',
        Util.quote(_dur),
        'repeatCount="indefinite" ',
        'calcMode="paced" ',
        'type="translate" ',
        'additive="sum" ',
        'from="0 0" ',
        'to="0 ',
        _to,
        '" ',
        '/>'
      );
  }
}
