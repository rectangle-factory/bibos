// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {vm} from "../util/vm.sol";
import {io} from "../util/io.sol";
import {time} from "../util/time.sol";

import {console} from "forge-std/console.sol";

contract log {
    function run() external view {
        console.logBytes("a");
    }

    function run(uint8 _x) external view returns (string memory) {
        console.log(_x);
        return "test";
    }
}
