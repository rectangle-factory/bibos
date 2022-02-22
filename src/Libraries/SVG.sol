// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import './Util.sol';

library SVG {
  function circle(
    string memory radius,
    string[2] memory coords,
    string memory mixMode,
    string memory fill,
    string memory opacity,
    bytes memory animation
  ) internal pure returns (bytes memory) {
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
        'opacity=',
        Util.quote(opacity),
        'fill=',
        Util.quote(fill),
        animation,
        '>'
      );
  }

  function rect(
    string memory width,
    string memory height,
    string memory bg
  ) internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        '<rect ',
        'width=',
        Util.quote(width),
        'height=',
        Util.quote(height),
        'fill=',
        Util.quote(bg),
        '/>'
      );
  }

  function animateTransform(string memory dur, bytes memory to)
    internal
    pure
    returns (bytes memory)
  {
    return
      abi.encodePacked(
        '<animateTransform ',
        'attributeType="XML" ',
        'attributeName="transform" ',
        'dur=',
        Util.quote(dur),
        'repeatCount="indefinite" ',
        'calcMode="paced" ',
        'type="translate" ',
        'additive="sum" ',
        'from="0 0" ',
        'to="0 ',
        to,
        '" ',
        '/>'
      );
  }

  function animateMotion(string memory dur, string memory rev)
    internal
    pure
    returns (bytes memory)
  {
    return
      abi.encodePacked(
        '<animateMotion ',
        'dur=',
        Util.quote(dur),
        'repeatCount="indefinite" ',
        'calcMode="paced" ',
        rev,
        '>'
      );
  }
}
