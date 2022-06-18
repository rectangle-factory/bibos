// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Data} from "./Data.sol";
import {Background} from "./Background.sol";
import {Body} from "./Body.sol";
import {Glints} from "./Glints.sol";
import {Motes} from "./Motes.sol";
import {Face} from "./Face.sol";
import {SVG} from "./SVG.sol";

library Render {
    function bibo(bytes32 _seed) internal pure returns (string memory) {
        string memory children = string.concat(
            Data.defs(),
            Background.render(_seed),
            Body.render(_seed),
            Glints.render(_seed),
            Motes.render(_seed),
            Face.render(_seed)
        );
        return SVG.wrap(children);
    }
}
