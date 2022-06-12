// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Util} from "src/libraries/Util.sol";

import {Bibos} from "../Bibos.sol";

contract CompressTest is Test {
    function testCompressIsolateByte(uint8 _x, uint8 _i) public {
        _i = _i % 32;

        // put x somewhere in a uint as a byte
        uint256 y = uint256(bytes32(bytes1(_x)) >> (8 * _i));
        assertEq(isolateByte(bytes32(y), _i), bytes1(_x));
        // assertEq(bytes1(_x), isolateByte(uint256(y), _i));
    }

    // _i counts from the left
    function isolateByte(bytes32 _n, uint256 _i) internal view returns (bytes1) {
        return _n[_i];
    }

    function isolateByte(uint256 _n, uint256 _i) internal view returns (bytes1) {
        return isolateByte(bytes32(_n), _i);
    }

    function testCompressTwelve(uint16 _x) public {
        _x = _x >> 4;

        bytes memory result = compress(255, 12, 1);
        bytes memory result1 = compress(255, 12, 1);

        assertEq(uint256(0), 1);
    }

    function compress(
        uint256 _n,
        uint256 _bits,
        uint256 _slot
    ) internal view returns (bytes memory) {
        bytes memory result = new bytes(64);

        uint256 j = (_slot * _bits) / 8;
        uint256 l = (_slot * _bits) % 8;
        // l + s is how long on the left, then we fill out to be a multiple of 8
        // b = (r+l+8)/8 is how many bytes we need

        uint256 r = ((8 - ((l + _bits) % 8)) % 8);
        uint256 b = (l + _bits + r) / 8;

        _n <<= r;
        _n <<= (256 - 8 * b);

        uint256 k;
        while (k < b) {
            console.logBytes1(isolateByte(_n, k));
            result[j + k] |= isolateByte(_n, k);
            ++k;
        }

        return result;
    }

    function get(
        bytes memory _data,
        uint256 _bits,
        uint256 _slot
    ) {
        // first bytes to get in result
        uint256 j = (_slot * _bits) / 8;
        uint256 l = (_slot * _bits) % 8;
        // l + s is how long on the left, then we fill out to be a multiple of 8
        // b = (r+l+8)/8 is how many bytes we need

        uint256 r = ((8 - ((l + _bits) % 8)) % 8);
        uint256 b = (l + _bits + r) / 8;

        uint256 k;
        uint256 result;

        bytes1 val = _data[j + k] << ((8 - l) % 8);
        uint256 addend = uint256(uint8(val)) << 3;
        console.log(addend);
        result += addend;
        ++k;
        if (b == 3) {
            val = shortHex[j + k];
            console.logBytes1(val);
            addend = uint256(uint8(val)) << 8;
            console.log(addend);
            result += addend;
            ++k;
        }
        val = shortHex[j + k];
        console.logBytes1(val);
        addend = uint256(uint8(val)) >> r;
        console.log(addend);
        result += addend;
        console.log(result);
    }
}
