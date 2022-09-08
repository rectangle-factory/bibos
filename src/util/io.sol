// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {vm} from "./vm.sol";

/// @title io
/// @author Bumblebee Systems
library io {
    function read(string memory filePath) internal returns (bytes memory) {
        string[] memory readInputs = new string[](2);
        readInputs[0] = "cat";
        readInputs[1] = filePath;

        bytes memory result = vm.std_cheats.ffi(readInputs);
        return result;
    }

    function write(string memory filePath, string memory data) internal {
        string[] memory writeInputs = new string[](3);
        writeInputs[0] = "scripts/io_write.sh";
        writeInputs[1] = filePath;
        writeInputs[2] = data;

        vm.std_cheats.ffi(writeInputs);
    }
}
