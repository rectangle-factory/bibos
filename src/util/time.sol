// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {vm} from "./vm.sol";

library time {
    string constant UNIX_TIME_PATH = "scripts/time.sh";

    function getUnixTime() internal returns (uint256) {
        string[] memory unixTimeInputs = new string[](1);

        unixTimeInputs[0] = UNIX_TIME_PATH;

        uint256 unixTime = abi.decode(vm.std_cheats.ffi(unixTimeInputs), (uint256));

        return unixTime;
    }
}
