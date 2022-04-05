// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { Color } from './Color.sol';
import { Times } from './Times.sol';
import { Points } from './Points.sol';
import { Util } from './Util.sol';
import { SVG } from './SVG.sol';

library Glints {
  uint256 constant GLINT_COUNT = 16;

  enum GlintType {
    NONE,
    FLOATING,
    RISING,
    FALLING
  }

  function render(bytes32 _seed) internal pure returns (string memory result) {
    // color mode can be computed somewhere else
    Color.CM cm = Color.getRefractivity(_seed);
    string memory mixMode = cm == Color.CM.LIGHT ? 'lighten' : 'color-burn';
    string memory fill = cm == Color.CM.LIGHT ? 'white' : 'black';

    uint256 glintSeed = uint256(keccak256(abi.encodePacked(_seed, 'glint')));

    // determine glint type
    GlintType glintType;
    if (glintSeed % 100 < 20) {
      glintType = GlintType.FLOATING;
    }
    // glintType == RISING
    // 15%
    else if (glintSeed % 100 < 35) {
      glintType = GlintType.RISING;
    }
    // 5%
    // glintType == FALLING
    else if (glintSeed % 100 < 40) {
      glintType = GlintType.RISING;
    }

    if (glintType == GlintType.NONE) return '';
    glintSeed /= 100;

    for (uint8 i = 0; i < GLINT_COUNT; i++) {
      string memory dur = Times.long(glintSeed);
      glintSeed = glintSeed / Times.length;
      string[2] memory coords = Points.glint(glintSeed);
      glintSeed = glintSeed / Points.length;
      string memory radius = glintSeed % 2 == 0 ? '1' : '2';
      glintSeed = glintSeed / 2;

      if (glintType == GlintType.FLOATING) {
        string memory reverse = glintSeed % 2 == 0
          ? "keyPoints='1;0' keyTimes='0;1'"
          : '';
        result = addFloatingGlint(
          result,
          radius,
          coords,
          mixMode,
          fill,
          dur,
          reverse
        );
      } else if (glintType == GlintType.RISING) {
        result = addRisingGlint(result, radius, coords, mixMode, fill, dur);
      } else if (glintType == GlintType.FALLING) {
        result = addFallingGlint(result, radius, coords, mixMode, fill, dur);
      }
    }

    return result;
  }

  function addRisingGlint(
    string memory _result,
    string memory _radius,
    string[2] memory _coords,
    string memory _mixMode,
    string memory _fill,
    string memory _dur
  ) internal pure returns (string memory) {
    return
      string.concat(
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
  ) internal pure returns (string memory) {
    return
      string.concat(
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
  ) internal pure returns (string memory) {
    return
      string.concat(
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
