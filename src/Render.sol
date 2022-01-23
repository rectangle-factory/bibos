// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

library Render {
  function tokenURI(uint256 id, bytes32 data)
    external
    pure
    returns (string memory)
  {
    return "Something";
  }

  function svg(bytes32 data) internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        "<svg ",
        'version="1.1" ',
        'xmlns="http://www.w3.org/2000/svg" ',
        'preserveAspectRatio="xMinYMin meet" ',
        'viewBox="0 0 350 350" ',
        'color-interpolation-filters="sRGB" '
        ">",
        svgChildren(data),
        "</svg>"
      );
  }

  function svgChildren(bytes32 data) internal pure returns (bytes memory) {
    return
      abi.encodePacked('<rect width="100%" height="100%" fill="', "red", '"/>');
  }
}
