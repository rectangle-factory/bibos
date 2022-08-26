// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Metadata} from "libraries/Metadata.sol";
import {Util} from "libraries/Util.sol";
import {Traits} from "libraries/Traits.sol";
import {Data} from "libraries/Data.sol";
import {Palette} from "libraries/Palette.sol";
import {Background} from "libraries/Background.sol";
import {Body} from "libraries/Body.sol";
import {Face} from "libraries/Face.sol";
import {Motes} from "libraries/Motes.sol";
import {Glints} from "libraries/Glints.sol";
import {Traits} from "libraries/Traits.sol";
import {SVG} from "libraries/SVG.sol";

/// @title Render
/// @author Bumblebee Systems
library Render {
    string public constant description =
        "Floating. Hypnotizing. Divine? Bibos are 1111 friendly spirits for your wallet. Join the billions of people who love and adore bibos today.";

    /*//////////////////////////////////////////////////////////////
                                TOKENURI
    //////////////////////////////////////////////////////////////*/

    function tokenURI(uint256 _tokenId, bytes32 _seed) internal pure returns (string memory) {
        return
            Metadata.encodeMetadata({
                _tokenId: _tokenId,
                _name: _name(_tokenId),
                _description: description,
                _attributes: Traits.attributes(_seed, _tokenId),
                _backgroundColor: Palette.backgroundFill(_seed, _tokenId),
                _svg: _svg(_seed, _tokenId)
            });
    }

    /*//////////////////////////////////////////////////////////////
                                INTERNAL
    //////////////////////////////////////////////////////////////*/

    function _svg(bytes32 _seed, uint256 _tokenId) internal pure returns (string memory) {
        return
            SVG.element(
                "svg",
                SVG.svgAttributes(),
                Data.defs(),
                Background.render(_seed, _tokenId),
                Body.render(_seed, _tokenId),
                Motes.render(_seed, _tokenId),
                Glints.render(_seed),
                Face.render(_seed)
            );
    }

    function _name(uint256 _tokenId) internal pure returns (string memory) {
        return string.concat("Bibo ", Util.uint256ToString(_tokenId, 4));
    }
}
