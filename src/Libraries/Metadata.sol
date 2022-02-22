// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
import './Base64.sol';
import './Util.sol';

library Metadata {
  /// @notice base64 encode json metadata for the token
  /// @param _id, the tokenId
  /// @param _name, the name of the token
  /// @param _description, the description of the token
  /// @param _svg, the svg image
  /// @return string, the name of the color
  function encodeTokenMetadata(
    uint256 _id,
    bytes memory _name,
    bytes memory _description,
    bytes memory _svg
  ) internal pure returns (bytes memory) {
    bytes memory metadata = abi.encodePacked(
      '{',
      keyValue('tokenId', Util.uint256ToAscii(_id)),
      ',',
      keyValue('name', _name),
      ',',
      keyValue('description', _description),
      ',',
      keyValue('image', encodeSvg(_svg)),
      '}'
    );

    return encodeJson(metadata);
  }

  /// @notice base64 encode json
  /// @param _json, stringified json
  /// @return string, bytes64 encoded json with prefix
  function encodeJson(bytes memory _json) internal pure returns (bytes memory) {
    return
      abi.encodePacked('data:application/json;base64,', Base64.encode(_json));
  }

  /// @notice base64 encode svg
  /// @param _svg, stringified json
  /// @return string, bytes64 encoded svg with prefix
  function encodeSvg(bytes memory _svg) internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        'data:image/svg+xml;base64,',
        Base64.encode(bytes(_svg))
      );
  }

  function keyValue(bytes memory _key, bytes memory _value)
    internal
    pure
    returns (bytes memory)
  {
    return abi.encodePacked('"', _key, '":"', _value, '"');
  }

  function keyValueNoQuotes(bytes memory _key, bytes memory _value)
    internal
    pure
    returns (bytes memory)
  {
    return abi.encodePacked('"', _key, '":', _value);
  }
}
