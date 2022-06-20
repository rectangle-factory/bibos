// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test, console2 as console} from "forge-std/Test.sol";
import {Bibos} from "../Bibos.sol";
import {vm} from "../util/vm.sol";
import {time} from "../util/time.sol";

contract SvgValidationTest is Test {
    Bibos bibos;

    function setUp() public {
        bibos = new Bibos();
    }

    function testValidateSvg() public {
        uint256 unixTime = time.getUnixTime();
        vm.warp(unixTime);

        bibos.mint{value: bibos.price()}();
        string memory tokenURI = bibos.tokenURI(0);

        string[] memory validateInputs = new string[](3);
        validateInputs[0] = "scripts/validate.sh";
        validateInputs[1] = tokenURI;

        // returns 0 if success, positive integer if not
        uint256 result = abi.decode(vm.ffi(validateInputs), (uint256));

        assertEq(result, 0);
    }

    function validateSvg(string memory _tokenURI) internal {}
}
