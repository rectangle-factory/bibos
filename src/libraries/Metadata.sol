// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import { Base64 } from './Base64.sol';
import { Util } from './Util.sol';

library Metadata {
  string constant JSON_BASE64_HEADER = 'data:application/json;base64,';
  string constant SVG_XML_BASE64_HEADER = 'data:image/svg+xml;base64,';

  /// @notice base64 encode json metadata for the token
  /// @param _id, the tokenId
  /// @param _name, the name of the token
  /// @param _description, the description of the token
  /// @param _svg, the svg image
  /// @return string, the name of the color
  function encodeTokenMetadata(
    uint256 _id,
    string memory _name,
    string memory _description,
    string memory _svg
  ) internal pure returns (string memory) {
    string memory metadata = string.concat(
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
  function encodeJson(string memory _json)
    internal
    pure
    returns (string memory)
  {
    return string.concat(JSON_BASE64_HEADER, Base64.encode(_json));
  }

  /// @notice base64 encode svg
  /// @param _svg, stringified json
  /// @return string, bytes64 encoded svg with prefix
  function encodeSvg(string memory _svg) internal pure returns (string memory) {
    return
      string.concat('data:image/svg+xml;base64,', Base64.encode(bytes(_svg)));
  }

  function keyValue(string memory _key, string memory _value)
    internal
    pure
    returns (string memory)
  {
    return string.concat('"', _key, '":"', _value, '"');
  }

  function keyValueNoQuotes(string memory _key, string memory _value)
    internal
    pure
    returns (string memory)
  {
    return string.concat('"', _key, '":', _value);
  }
}
