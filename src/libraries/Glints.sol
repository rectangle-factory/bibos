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

  function render(bytes32 _seed) internal pure returns (string memory) {
    string memory result = '';
    Color.CM cm = Color.getRefractivity(_seed);
    string[5] memory opacities = cm == Color.CM.LIGHT
      ? ['0.3', '0.4', '0.5', '0.6', '0.7']
      : ['0.6', '0.7', '0.8', '0.9', '1.0'];
    string memory mixMode = 'lighten';
    string memory fill = 'white';

    uint256 glintMainSeed = uint256(
      keccak256(abi.encodePacked(_seed, 'glint'))
    );

    // determine glint type
    GlintType glintType;
    if (glintMainSeed % 100 < 20) {
      glintType = GlintType.FLOATING;
    }
    // glintType == RISING
    // 15%
    else if (glintMainSeed % 100 < 35) {
      glintType = GlintType.RISING;
    }
    // 5%
    // glintType == FALLING
    else if (glintMainSeed % 100 < 40) {
      glintType = GlintType.RISING;
    }

    if (glintType == GlintType.NONE) return '';

    for (uint8 i = 0; i < GLINT_COUNT; i++) {
      uint256 glintSeed = uint256(
        keccak256(abi.encodePacked(glintMainSeed, i))
      );

      string memory dur = Times.long(glintSeed);
      glintSeed = glintSeed / Times.length;
      string[2] memory coords = Points.glint(glintSeed);
      glintSeed = glintSeed / Points.length;
      string memory radius = glintSeed % 2 == 0 ? '1' : '2';
      glintSeed = glintSeed / 2;
      string memory opacity = opacities[glintSeed];
      glintSeed /= opacities.length;

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
          opacity,
          dur,
          reverse
        );
      } else if (glintType == GlintType.RISING) {
        result = addRisingGlint(
          result,
          radius,
          coords,
          mixMode,
          fill,
          opacity,
          dur
        );
      } else if (glintType == GlintType.FALLING) {
        result = addFallingGlint(
          result,
          radius,
          coords,
          mixMode,
          fill,
          opacity,
          dur
        );
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
    string memory _opacity,
    string memory _dur
  ) internal pure returns (string memory) {
    return
      string.concat(
        _result,
        '<g transform="translate(0,25)">',
        SVG.circle(_radius, _coords, _mixMode, _fill, _opacity),
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
    string memory _opacity,
    string memory _dur,
    string memory _reverse
  ) internal pure returns (string memory) {
    return
      string.concat(
        _result,
        SVG.circle(_radius, _coords, _mixMode, _fill, _opacity),
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
    string memory _opacity,
    string memory _dur
  ) internal pure returns (string memory) {
    return
      string.concat(
        _result,
        '<g transform="translate(0,-25)">',
        SVG.circle(_radius, _coords, _mixMode, _fill, _opacity),
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
