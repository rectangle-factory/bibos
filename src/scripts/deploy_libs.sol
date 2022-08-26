// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test, console2 as console} from "forge-std/Test.sol";
import {CREATE3} from "solmate/utils/CREATE3.sol";

import {Mouth} from "libraries/Mouth.sol";
import {Eyes} from "libraries/Eyes.sol";
import {Cheeks} from "libraries/Cheeks.sol";
import {Face} from "libraries/Face.sol";
import {Body} from "libraries/Body.sol";
import {Motes} from "libraries/Motes.sol";

import {time} from "util/time.sol";
import {io} from "util/io.sol";

/// @title deploy_libs
/// @author Bumblebee Systems
contract deploy_libs {
    mapping(string => address) public addresses;

    function _deploy(string memory _name, bytes memory _creationCode) internal returns (address) {
        bytes32 salt = keccak256(abi.encode(_name));
        address deployment = CREATE3.deploy(salt, _creationCode, 0);
        addresses[_name] = deployment;
        return deployment;
    }

    constructor() {
        _deploy("Mouth", type(Mouth).creationCode);
        _deploy("Eyes", type(Eyes).creationCode);
        _deploy("Cheeks", type(Cheeks).creationCode);
        // link Mouth, Eyes, Cheeks for Face
        _deploy("Face", type(Face).creationCode);
        _deploy("Body", type(Body).creationCode);
        _deploy("Motes", type(Motes).creationCode);
    }
}
