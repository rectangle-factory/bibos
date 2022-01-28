// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import "./Metadata.sol";
import "./Color.sol";
import "./Ascii.sol";

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
          tokenName("Bibos #", id), // name
          "Bibos", // description
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
    return abi.encodePacked(_name, Ascii.uint256ToAscii(_tokenId));
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
      abi.encodePacked(
        '<rect width="100%" height="100%" fill="',
        Color.getBodyLight(data[0]),
        '"/>'
      );
  }
}
