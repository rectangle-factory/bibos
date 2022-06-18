// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test, console2 as console} from "forge-std/Test.sol";
import {Mouth} from "src/libraries/Mouth.sol";
import {Eyes} from "src/libraries/Eyes.sol";
import {Cheeks} from "src/libraries/Cheeks.sol";
import {Face} from "src/libraries/Face.sol";
import {Body} from "src/libraries/Body.sol";
import {Glints} from "src/libraries/Glints.sol";

import {CREATE3} from "solmate/utils/CREATE3.sol";
import {time} from "src/util/time.sol";
import {io} from "src/util/io.sol";

// need to link bibos and deploy the contracts here.

contract deploy {
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
        _deploy("Glints", type(Glints).creationCode);
    }
}
