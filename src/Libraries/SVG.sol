// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import './Util.sol';

library SVG {
  function circle(
    string memory radius,
    string[2] memory coords,
    string memory mixMode,
    string memory fill,
    string memory opacity
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
        'fill=',
        Util.quote(fill),
        'opacity=',
        Util.quote(opacity),
        '>'
      );
  }

  function circleClose() internal pure returns (bytes memory) {
    return abi.encodePacked('</circle>');
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

  function path(
    string memory d,
    string memory fill,
    string memory stroke,
    string memory strokeWidth,
    string memory strokeLinecap
  ) internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        '<path d=',
        Util.quote(d),
        'stroke=',
        Util.quote(stroke),
        'stroke-width=',
        Util.quote(strokeWidth),
        'stroke-linecap=',
        Util.quote(strokeLinecap),
        '/>'
      );
  }

  function ellipse(
    string[2] memory coords,
    string memory radiusX,
    string memory radiusY,
    string memory fill
  ) internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        '<ellipse cx=',
        Util.quote(coords[0]),
        'cy=',
        Util.quote(coords[1]),
        'rx=',
        Util.quote(radiusX),
        'ry=',
        Util.quote(radiusY),
        'fill=',
        Util.quote(fill),
        '/>'
      );
  }

  function animateMotion(
    string memory rev,
    string memory dur,
    string memory calcMode,
    string memory mpath
  ) internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        '<animateMotion ',
        rev,
        'dur=',
        Util.quote(dur),
        'repeatCount="indefinite" ',
        'calcMode=',
        Util.quote(calcMode),
        '>',
        mpath,
        '</animateMotion>'
      );
  }

  function animate(string memory dur) internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        '<animate ',
        'attributeName="opacity" ',
        'values="0;1;0" ',
        'dur=',
        Util.quote(dur),
        'repeatCount="indefinite" ',
        '/>'
      );
  }
}
