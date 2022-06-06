// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";

import {TimesUtil} from "src/libraries/TimesUtil.sol";

contract enocode_times is Script {
    function runShort() public pure returns (bytes memory) {
        return TimesUtil.getAllShort();
    }

    function runLong() public pure returns (bytes memory) {
        return TimesUtil.getAllLong();
    }
}
