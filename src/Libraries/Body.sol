// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import './Color.sol';

library Body {
  function shortTimes(bytes1 index) internal pure returns (string memory) {
    string[64] memory times = [
      '8.93',
      '9.74',
      '6.87',
      '9.61',
      '8.56',
      '5.87',
      '9.67',
      '7.31',
      '5.92',
      '8.01',
      '9.59',
      '5.50',
      '8.33',
      '8.40',
      '6.23',
      '5.88',
      '9.75',
      '9.99',
      '5.23',
      '5.69',
      '7.38',
      '7.16',
      '6.20',
      '5.17',
      '6.04',
      '5.01',
      '9.46',
      '8.31',
      '7.21',
      '5.96',
      '9.86',
      '7.77',
      '5.22',
      '5.23',
      '6.22',
      '7.21',
      '8.07',
      '9.29',
      '8.99',
      '8.55',
      '9.80',
      '5.49',
      '7.71',
      '7.96',
      '7.87',
      '9.39',
      '8.16',
      '9.31',
      '8.36',
      '5.63',
      '6.84',
      '8.73',
      '9.61',
      '7.66',
      '9.00',
      '9.17',
      '6.87',
      '8.47',
      '8.31',
      '6.58',
      '7.21',
      '8.82',
      '9.66',
      '9.92'
    ];

    return times[uint8(index) % 64];
  }

  function bodyPoints(bytes1 index) internal pure returns (string[2] memory) {
    string[2][64] memory points = [
      ['186', '165'],
      ['170', '119'],
      ['174', '150'],
      ['135', '128'],
      ['129', '151'],
      ['172', '175'],
      ['119', '125'],
      ['185', '186'],
      ['165', '124'],
      ['115', '151'],
      ['129', '131'],
      ['165', '129'],
      ['137', '184'],
      ['135', '167'],
      ['181', '147'],
      ['155', '186'],
      ['153', '171'],
      ['164', '127'],
      ['156', '124'],
      ['138', '164'],
      ['156', '113'],
      ['174', '150'],
      ['133', '161'],
      ['119', '153'],
      ['132', '120'],
      ['138', '161'],
      ['182', '186'],
      ['144', '175'],
      ['122', '173'],
      ['169', '166'],
      ['177', '187'],
      ['168', '150'],
      ['149', '162'],
      ['163', '133'],
      ['157', '167'],
      ['157', '179'],
      ['123', '116'],
      ['140', '188'],
      ['166', '112'],
      ['123', '172'],
      ['165', '173'],
      ['147', '116'],
      ['155', '141'],
      ['130', '179'],
      ['172', '162'],
      ['126', '117'],
      ['181', '132'],
      ['124', '125'],
      ['149', '182'],
      ['155', '139'],
      ['155', '148'],
      ['125', '112'],
      ['113', '169'],
      ['134', '131'],
      ['169', '125'],
      ['181', '128'],
      ['170', '144'],
      ['173', '130'],
      ['185', '120'],
      ['151', '122'],
      ['131', '177'],
      ['135', '174'],
      ['157', '166'],
      ['130', '152']
    ];

    return points[uint8(index) % 64];
  }

  function blurGroup(bytes32 data) internal pure returns (bytes memory) {
    Color.CM cm = Color.CM.LIGHT;
    return
      abi.encodePacked(
        '<g filter="url(#blur)">',
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
    bytes memory r,
    bytes1 v
  ) internal pure returns (bytes memory) {
    string memory mixMode = cm == Color.CM.LIGHT ? 'overlay' : 'color-burn';
    string memory fill = cm == Color.CM.LIGHT
      ? Color.bodyLight(v)
      : Color.bodyDark(v);

    string memory dur = shortTimes(v);
    string[2] memory c = bodyPoints(v);

    string memory rev = v & 0x01 == 0 ? 'keyPoints="1;0" keyTimes="0;1" ' : '';
    return
      abi.encodePacked(
        '<circle r=',
        quote(r),
        'cx=',
        quote(c[0]),
        'cy=',
        quote(c[1]),
        'style=',
        quote(abi.encodePacked('mix-blend-mode:', mixMode)),
        'shape-rendering="optimizeSpeed" ',
        'fill=',
        quote(fill),
        '>',
        animation(rev, dur),
        '</circle>'
      );
  }

  function background(Color.CM cm, bytes1 v)
    internal
    pure
    returns (bytes memory)
  {
    string memory bg = cm == Color.CM.LIGHT
      ? Color.bgLight(v)
      : Color.bgDark(v);
    return
      abi.encodePacked(
        '<rect width="300" height="300" ',
        'fill=',
        quote(bg),
        '/>'
      );
  }

  function animation(string memory rev, string memory dur)
    internal
    pure
    returns (bytes memory)
  {
    return
      abi.encodePacked(
        '<animateMotion ',
        rev,
        'dur=',
        quote(dur),
        'repeatCount="indefinite" ',
        'calcMode="linear" ',
        '>',
        '<mpath xlink:href="#jitter-lg"/>',
        '</animateMotion>'
      );
  }

  // puts a space after
  function quote(bytes memory value) internal pure returns (bytes memory) {
    return abi.encodePacked('"', value, '" ');
  }

  function quote(string memory value) internal pure returns (bytes memory) {
    return quote(bytes(value));
  }
}
