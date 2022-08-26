// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";

/// @title bytecode_size
/// @author Bumblebee Systems
contract bytecode_size is Script {
    function get_bytecode_size(address _target) public view returns (uint256) {
        return _target.code.length;
    }
}
