// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Metadata} from "libraries/Metadata.sol";
import {Util} from "libraries/Util.sol";
import {Traits} from "libraries/Traits.sol";
import {Data} from "./Data.sol";
import {Palette} from "libraries/Palette.sol";
import {Background} from "./Background.sol";
import {Body} from "./Body.sol";
import {Face} from "./Face.sol";
import {Motes} from "./Motes.sol";
import {Glints} from "./Glints.sol";
import {Traits} from "./Traits.sol";
import {SVG} from "./SVG.sol";

library Render {
    string public constant description = "Bibos";

    function tokenURI(uint256 _tokenId, bytes32 _seed) internal pure returns (string memory) {
        return
            Metadata.encodeMetadata({
                _id: _tokenId,
                _name: _name(_tokenId),
                _description: description,
                _attributes: Traits.attributes(_seed),
                _backgroundColor: Palette.backgroundFill(_seed, _tokenId),
                _svg: _svg(_seed, _tokenId)
            });
    }

    function _svg(bytes32 _seed, uint256 _tokenId) internal pure returns (string memory) {
        return
            SVG.element(
                "svg",
                SVG.svgAttributes(),
                Data.defs(),
                Background.render(_seed, _tokenId),
                Body.render(_seed, _tokenId),
                Motes.render(_seed),
                Glints.render(_seed),
                Face.render(_seed)
            );
    }

    function _name(uint256 _tokenId) internal pure returns (string memory) {
        return string.concat("Bibo ", Util.uint256ToString(_tokenId, 4));
    }
}
