// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import './Color.sol';
import './Times.sol';
import './Points.sol';
import './Util.sol';

library Glints {
  function render(bytes32 data) internal pure returns (bytes memory result) {
    Color.CM cm = Color.CM.DARK;
    string memory mixMode = cm == Color.CM.LIGHT ? 'lighten' : 'color-burn';
    string memory fill = cm == Color.CM.LIGHT ? 'white' : 'black';

    bytes1 value = data[0];
    // string[4] memory glintTypes = ['RISING', 'FLOATING', 'FALLING', 'NONE'];
    // string glintType = glintTypes[value % 4];

    uint8 glintCount = 16;

    for (uint8 index = 0; index < glintCount; index++) {
      // get the next byte in data
      value = data[index];

      string memory dur = Times.long(value);
      string[2] memory coords = Points.glint(value);
      string memory r = value & 0x01 == 0 ? '1' : '2';
      string memory rev = value & 0x01 == 0
        ? "keyPoints='1;0' keyTimes='0;1'"
        : '';

      // glintType == RISING
      if (value & 0x11 == 0x00) {
        result = abi.encodePacked(
          result,
          '<g transform="translate(0,50)">',
          '<circle ',
          'r=',
          Util.quote(r),
          'cx=',
          Util.quote(coords[0]),
          'cy=',
          Util.quote(coords[1]),
          'style="mix-blend-mode:',
          Util.quote(abi.encodePacked('mix-blend-mode:', mixMode)),
          '"',
          'opacity="0.5" ',
          'fill=',
          Util.quote(fill),
          '>',
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
          'to="0 -100" ',
          '/>',
          '<animate ',
          'attributeName="opacity" ',
          'values="0;1;0" ',
          'dur=',
          Util.quote(dur),
          'repeatCount="indefinite" ',
          '/>'
          '</circle>',
          '</g>'
        );
      }

      // glintType == FLOATING
      if (value & 0x11 == 0x01) {
        result = abi.encodePacked(
          result,
          '<circle ',
          'r=',
          Util.quote(r),
          'cx=',
          Util.quote(coords[0]),
          'cy=',
          Util.quote(coords[1]),
          'style=',
          Util.quote(abi.encodePacked('mix-blend-mode:', mixMode)),
          'opacity="0.75" ',
          'fill=',
          Util.quote(fill),
          '>',
          '<animateMotion ',
          'dur=',
          Util.quote(dur),
          'repeatCount="indefinite" ',
          'calcMode="paced" ',
          rev,
          '>',
          '<mpath xlink:href="#jitter-sm"/>',
          '</animateMotion>',
          '</circle>'
        );
      }

      // glintType == FALLING
      if (value & 0x11 == 0x10) {
        result = abi.encodePacked(
          result,
          '<g>',
          '<circle ',
          'r=',
          Util.quote(r),
          'cx=',
          Util.quote(coords[0]),
          'cy=',
          Util.quote(coords[1]),
          'style=',
          Util.quote(abi.encodePacked('mix-blend-mode:', mixMode)),
          'opacity="0.5" ',
          'fill=',
          Util.quote(fill),
          '>',
          '<animateTransform',
          'attributeType="XML"',
          'attributeName="transform"',
          'dur=',
          Util.quote(dur),
          'repeatCount="indefinite" ',
          'calcMode="paced"        ',
          'type="translate"',
          'additive="sum"',
          'from="0 0"',
          'to="0 100"/>',
          '<animate ',
          'attributeName="opacity" ',
          'values="0;1;0" ',
          'dur=',
          Util.quote(dur),
          'repeatCount="indefinite" ',
          '/>',
          '</circle>',
          '</g>'
        );
      }
    }
  }
}
