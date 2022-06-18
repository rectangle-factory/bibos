// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Script, console2 as console} from "forge-std/Script.sol";

import {PaletteUtil} from "dev/PaletteUtil.sol";

contract encode_palettes is Script {
    function encodeAll()
        public
        pure
        returns (
            string memory light,
            string memory lightest,
            string memory darkest
        )
    {
        return (PaletteUtil.getLight(), PaletteUtil.getLightest(), PaletteUtil.getDarkest());
    }
}
