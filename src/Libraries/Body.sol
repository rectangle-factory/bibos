// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import './Color.sol';
import './Times.sol';
import './Points.sol';
import './Util.sol';

library Body {
  function render(bytes32 data) internal pure returns (bytes memory) {
    Color.CM cm = Color.CM.LIGHT;
    return
      abi.encodePacked(
        '<g filter="url(#blur)">',
        bodyBackground(cm, data[0]),
        bodyCircle(cm, '64', data[1]),
        bodyCircle(cm, '56', data[2]),
        bodyCircle(cm, '48', data[3]),
        bodyCircle(cm, '48', data[4]),
        bodyCircle(cm, '32', data[5]),
        bodyCircle(cm, '32', data[6]),
        '</g>'
      );
  }

  function bodyCircle(
    Color.CM cm,
    bytes memory radius,
    bytes1 value
  ) internal pure returns (bytes memory) {
    string memory mixMode = cm == Color.CM.LIGHT ? 'overlay' : 'color-burn';
    string memory fill = cm == Color.CM.LIGHT
      ? Color.bodyLight(value)
      : Color.bodyDark(value);

    string memory dur = Times.short(value);
    string[2] memory coords = Points.body(value);

    // switch on first byte of val
    // equiv to val % 2 == 0
    string memory points = value & 0x01 == 0
      ? 'keyPoints="1;0" keyTimes="0;1" '
      : '';

    return
      abi.encodePacked(
        '<circle r=',
        Util.quote(radius),
        'cx=',
        Util.quote(coords[0]),
        'cy=',
        Util.quote(coords[1]),
        'style=',
        Util.quote(abi.encodePacked('mix-blend-mode:', mixMode)),
        'shape-rendering="optimizeSpeed" ',
        'fill=',
        Util.quote(fill),
        '>',
        animation(points, dur),
        '</circle>'
      );
  }

  function bodyBackground(Color.CM cm, bytes1 value)
    internal
    pure
    returns (bytes memory)
  {
    string memory bg = cm == Color.CM.LIGHT
      ? Color.bgLight(value)
      : Color.bgDark(value);
    return
      abi.encodePacked(
        '<rect width="300" height="300" ',
        'fill=',
        Util.quote(bg),
        '/>'
      );
  }

  function animation(string memory points, string memory dur)
    internal
    pure
    returns (bytes memory)
  {
    return
      abi.encodePacked(
        '<animateMotion ',
        points,
        'dur=',
        Util.quote(dur),
        'repeatCount="indefinite" ',
        'calcMode="linear" ',
        '>',
        '<mpath xlink:href="#jitter-lg"/>',
        '</animateMotion>'
      );
  }
}
