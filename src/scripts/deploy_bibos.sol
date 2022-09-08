// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";
import {Bibos} from "src/Bibos.sol";

/// @title deploy_bibos
/// @author Bumblebee Systems
contract deploy_bibos is Script {
    function run() public returns (address bibos) {
        vm.startBroadcast();
        bibos = address(new Bibos());
    }
}
