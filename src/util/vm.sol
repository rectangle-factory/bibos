// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Vm} from "forge-std/Vm.sol";

/// @title vm
/// @author Bumblebee Systems
library vm {
    Vm constant std_cheats = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
}
