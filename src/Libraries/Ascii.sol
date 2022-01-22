// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

/// @title the bibos ascii library
/// @notice utility functions for converting to ascii
library Ascii {
  /// @notice converts a uint256 to string
  /// @param _value, uint256, the value to convert
  /// @return result the resulting string
  function uint256ToAscii(uint256 _value)
    internal
    pure
    returns (bytes memory result)
  {
    if (_value == 0) return "0";

    assembly {
      // largest uint = 2^256-1 has 78 digits
      // reserve 110 = 78 + 32 bytes of data in memory
      // (first 32 are for string length)

      // get 110 bytes of free memory
      result := add(mload(0x40), 110)
      mstore(0x40, result)

      // keep track of digits
      let digits := 0

      for {

      } gt(_value, 0) {

      } {
        // increment digits
        digits := add(digits, 1)
        // go back one byte
        result := sub(result, 1)
        // compute ascii char
        let c := add(mod(_value, 10), 48)
        // store byte
        mstore8(result, c)
        // advance to next digit
        _value := div(_value, 10)
      }
      // go back 32 bytes
      result := sub(result, 32)
      // store the length
      mstore(result, digits)
    }
  }
}
