// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { vm } from '../util/vm.sol';
import { Bibos } from '../Bibos.sol';

contract mint {
  string constant UNIX_TIME_PATH = 'scripts/time.sh';
  string constant HANDLE_TOKEN_URI_PATH = 'scripts/handle_token_uri.sh';

  function run() public returns (bool) {
    Bibos bibos = new Bibos();
    // get current time to use as random seed
    string[] memory unixTimeInputs = new string[](1);

    unixTimeInputs[0] = UNIX_TIME_PATH;

    bytes32 seed = keccak256(vm.std_cheats.ffi(unixTimeInputs));

    // set block.timestamp
    vm.std_cheats.warp(uint256(seed));

    // mint
    bibos.mint();

    // get tokenURI and run render.sh
    string[] memory handleTokenUriInputs = new string[](2);
    handleTokenUriInputs[0] = HANDLE_TOKEN_URI_PATH;
    handleTokenUriInputs[1] = bibos.tokenURI(0);
    vm.std_cheats.ffi(handleTokenUriInputs);

    return true;
  }
}
