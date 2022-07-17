// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";

import {TimesUtil} from "dev/TimesUtil.sol";

contract encode_times is Script {
    function getShorter() public pure returns (bytes memory) {
        return TimesUtil.getShorter();
    }

    function getShort() public pure returns (bytes memory) {
        return TimesUtil.getShort();
    }

    function getLong() public pure returns (bytes memory) {
        return TimesUtil.getLong();
    }
}
