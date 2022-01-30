// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import './Metadata.sol';
import './Color.sol';
import './Util.sol';
import './Body.sol';

library Render {
  function tokenURI(uint256 id, bytes32 data)
    internal
    pure
    returns (string memory)
  {
    return
      string(
        Metadata.encodeTokenMetadata(
          id,
          tokenName('Bibos #', id), // name
          'Bibos', // description
          svg(data) // svg
        )
      );
  }

  /// @notice constructs the name of the token
  function tokenName(string memory _name, uint256 _tokenId)
    internal
    pure
    returns (bytes memory)
  {
    return abi.encodePacked(_name, Util.uint256ToAscii(_tokenId));
  }

  function svg(bytes32 data) internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        '<svg ',
        'pauseAnimations="true" '
        'xmlns="http://www.w3.org/2000/svg" '
        'xmlns:xlink="http://www.w3.org/1999/xlink" '
        'width="500" '
        'height="500" '
        'viewBox="0 0 300 300" '
        'fill="none" '
        '>',
        defs(),
        svgChildren(data),
        '</svg>'
      );
  }

  function svgChildren(bytes32 data) internal pure returns (bytes memory) {
    Color.CM cm = Color.CM.DARK;
    return abi.encodePacked(Body.background(cm, data[0]), Body.blurGroup(data));
  }

  function defs() internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        '<defs>',
        '<!-- Blur filter -->',
        '<filter id="blur" x="-50%" y="-50%" width="200%" height="200%" color-interpolation-filters="sRGB">',
        '<feFlood flood-opacity="0" result="BackgroundImageFix"/>',
        '<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>',
        '<feGaussianBlur stdDeviation="${showDebug ? 0 : 15}"/>',
        '</filter>',
        '<!-- Figure Eights -->',
        '<path id="jitter-sm" d="M10.4485 2.98177C14.4091 4.48135 20 6.52342 20 2.98176C20 -0.548164 14.617 1.40118 10.4485 2.98177ZM10.4485 2.98177C10.4347 2.98703 10.4208 2.99226 10.4069 2.99751C6.23277 4.58084 1 6.5628 1 3.02114C1 -0.520506 6.48798 1.4822 10.4485 2.98177Z" />',
        '<path id="jitter-lg" d="M11.4431 4.92852C15.8206 9.82815 22 10.2396 22 4.92847C22 -0.382675 16.0504 -0.235806 11.4431 4.92852ZM11.4431 4.92852C11.4278 4.94569 11.4124 4.9628 11.3972 4.97994C6.78359 10.1532 1 10.4969 1 5.05714C1 -0.382663 7.06566 0.0289037 11.4431 4.92852Z" />',
        '</defs>'
      );
  }
}
