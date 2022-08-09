// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";
import {Bibos} from "src/Bibos.sol";

contract withdraw_bibos is Script {
    address constant bibosAddress = 0xF528e3381372c43F5e8a55b3E6c252E32F1a26e4;
    address payable constant vault = payable(0x972011A6F6a526E798F7D459502f686FA13Da88f);

    function run() public returns (address, address) {
        vm.startBroadcast();
        Bibos bibos = Bibos(0xF528e3381372c43F5e8a55b3E6c252E32F1a26e4);
        bibos.withdraw(vault);
        return (msg.sender, bibos.owner());
    }
}
