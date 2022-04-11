// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {DSTest} from "ds-test/test.sol";
import {Bibos} from "../Bibos.sol";
import {vm} from "../util/vm.sol";
import {time} from "../util/time.sol";
import {console} from "forge-std/console.sol";

contract SvgValidationTest is DSTest {
    Bibos bibos;

    function setUp() public {
        bibos = new Bibos();
    }

    function testValidateSvg() public {
        time.setToUnixTime();
        bibos.mint();
        string memory tokenURI = bibos.tokenURI(0);

        string[] memory validateInputs = new string[](3);
        validateInputs[0] = "scripts/validate.sh";
        validateInputs[1] = tokenURI;

        // returns 0 if success, positive integer if not
        uint256 result = abi.decode(vm.std_cheats.ffi(validateInputs), (uint256));

        assertEq(result, 0);
    }

    function validateSvg(string memory _tokenURI) internal {}
}
