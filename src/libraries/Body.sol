// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { Color } from './Color.sol';
import { Times } from './Times.sol';
import { Points } from './Points.sol';
import { Util } from './Util.sol';
import { SVG } from './SVG.sol';

library Body {
  function render(bytes32 _seed) internal pure returns (string memory) {
    string memory result = '';

    string[7] memory radii = ['64', '64', '64', '56', '48', '32', '24'];

    // const bodyCircles = [ 64, 64, 64, 56, 48, 32, 24 ]
    uint256 bodySeed = uint256(keccak256(abi.encodePacked(_seed, 'body')));

    string memory backgroundFill = Color.getBackgroundFill(_seed);
    result = addBodyBackground(result, backgroundFill);

    for (uint8 i = 0; i < 7; i++) {
      string memory mixMode = 'lighten';
      string memory radius = radii[i];
      string memory fill = Color.getBodyFill(_seed, i);

      string memory dur = Times.short(bodySeed);
      bodySeed /= Times.length;

      string[2] memory coords = (i == 0)
        ? ['150', '150']
        : Points.body(bodySeed);
      bodySeed /= Points.length;

      // switch on first byte of val
      // equiv to val % 2 == 0
      string memory reverse = bodySeed % 2 == 0
        ? 'keyPoints="1;0" keyTimes="0;1" '
        : '';
      bodySeed /= 2;

      result = addBodyCircle(
        result,
        radius,
        coords,
        mixMode,
        fill,
        dur,
        reverse
      );
    }

    return result;
  }

  function addBodyCircle(
    string memory _result,
    string memory _radius,
    string[2] memory _coords,
    string memory _mixMode,
    string memory _fill,
    string memory _reverse,
    string memory _dur
  ) internal pure returns (string memory) {
    string memory mpath = '<mpath xlink:href="#jitter-lg"/>';
    string memory calcMode = 'linear';
    string memory opacity = '1';

    return
      string.concat(
        _result,
        SVG.circle(_radius, _coords, _mixMode, _fill, opacity),
        SVG.animateMotion(_reverse, _dur, calcMode, mpath),
        '</circle>'
      );
  }

  function addBodyBackground(string memory _result, string memory _fill)
    internal
    pure
    returns (string memory)
  {
    return string.concat(_result, SVG.rect('100%', '100%', _fill));
  }
}
