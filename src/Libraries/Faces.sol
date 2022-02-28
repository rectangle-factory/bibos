// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import './Color.sol';
import './Times.sol';
import './Points.sol';
import './Util.sol';
import './SVG.sol';
import './Eyes.sol';

library Faces {
  function render() internal pure returns (bytes memory result) {
    result = abi.encodePacked(
      '<g id="bibo-face" transform="translate(100,100) scale(0.5) rotate(0)" >',
      SVG.rect('200', '200', 'rgba(0,0,0,0)'),
      Eyes.render('red'),
      // mouths here
      // need to add reverse to line before
      '<animateMotion dur="10s" calcMode="linear" repeatCount="indefinite">',
      '<mpath href="#jitter-lg" />',
      '</animateMotion>',
      '</g>'
    );
  }
}
