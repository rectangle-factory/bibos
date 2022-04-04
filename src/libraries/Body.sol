// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { Color } from './Color.sol';
import { Times } from './Times.sol';
import { Points } from './Points.sol';
import { Util } from './Util.sol';
import { SVG } from './SVG.sol';

library Body {
  function render(bytes32 _seed) internal pure returns (string memory) {
    string[7] memory radii = ['64', '64', '64', '56', '48', '32', '24'];
    Color.CM cm = Color.CM.LIGHT;
    // const bodyCircles = [ 64, 64, 64, 56, 48, 32, 24 ]
    bytes32 bodySeed = keccak256(abi.encodePacked(_seed, 'body'));



    for (uint8 i = 0; i < 7; i++) {

            string memory mixMode = 'lighten';
    string memory fill = _cm == Color.CM.LIGHT
      ? Color.bodyLight(value)
      : Color.bodyDark(value);

    string memory dur = Times.short(value);
    string[2] memory coords = (i === 0) ? ['150','150'] : Points.body(value);

    // switch on first byte of val
    // equiv to val % 2 == 0
    string memory reverse = value % 2 == 0
      ? 'keyPoints="1;0" keyTimes="0;1" '
      : '';

      addBodyCircle(result, radius, coords, mixMode, fill, dur, reverse);
    }
        // <g id="bibo-body" filter="url(#blur)">
        //     <rect id="bibo-compositing-background" width="100%" height="100%" fill="${background}" />
    return
      string.concat(
        bodyBackground(cm, bodySeed[0]),
        ' <!-- BODY --> ',
        '<g filter="url(#blur)">',
        bodyBackground(cm, bodySeed[0]),
        bodyCircle(cm, '64', bodySeed[1]),
        bodyCircle(cm, '56', bodySeed[2]),
        bodyCircle(cm, '48', bodySeed[3]),
        bodyCircle(cm, '48', bodySeed[4]),
        bodyCircle(cm, '32', bodySeed[5]),
        bodyCircle(cm, '32', bodySeed[6]),
        '</g>'
      );
  }

  function addBodyCircle(
    string memory _result,
    Color.CM _cm,
    string memory _radius,
    uint256 _value
  ) internal pure returns (string memory result) {
    // string memory mixMode = cm == Color.CM.LIGHT ? 'overlay' : 'color-burn';


    //       var fill = palette[localEny % palette.length]

    // var r = bodyCircles[i]

    // var dur = shortTimes[localEny % shortTimes.length]
    // var [cx, cy] = bodyPoints[localEny % bodyPoints.length]



            // <circle fill="${fill}" r="${r}" cx="${cx}" cy="${cy}" style="mix-blend-mode:lighten" shape-rendering="optimizeSpeed">
            //     <animateMotion ${reverse} dur="${dur}" repeatCount="indefinite" calcMode="linear">
            //         <mpath href="#jitter-lg"/> 
            //     </animateMotion>
            // </circle>


      _result = string.concat(_result, 
        SVG.circle(radius, coords, mixMode, fill, '1'),
        SVG.animateMotion(
          reverse,
          dur,
          'linear',
          '<mpath xlink:href="#jitter-lg"/>'
        ),
        '</circle>'
      );
  }

  function addBodyBackground(string memory _result, string memory _fill)
    internal
    pure
    returns (string memory)
  {
    _result = string.concat(_result, SVG.rect('100%', '100%', _fill));
  }
}
