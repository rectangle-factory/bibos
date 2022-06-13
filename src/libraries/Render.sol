// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Metadata} from "./Metadata.sol";
import {Util} from "./Util.sol";
import {Background} from "./Background.sol";
import {Body} from "./Body.sol";
import {Face} from "./Face.sol";
import {Glints} from "./Glints.sol";
import {Motes} from "./Motes.sol";
import {Traits} from "./Traits.sol";
import {SVG} from "./SVG.sol";

library Render {
    function tokenURI(uint256 _tokenId, bytes32 _seed) internal pure returns (string memory) {
        return
            string(
                Metadata.encodeTokenMetadata(
                    _tokenId,
                    tokenName("Bibo #", _tokenId), // name
                    "Bibos", // description
                    Traits.getTraits(_seed), // attributes
                    svg(_seed) // svg
                )
            );
    }

    /// @notice constructs the name of the token
    function tokenName(string memory _name, uint256 _tokenId) internal pure returns (string memory) {
        return string.concat(_name, Util.uint256ToString(_tokenId));
    }

    function svg(bytes32 _seed) internal pure returns (string memory) {
        string memory svgChildren = string.concat(
            SVG.defs(),
            Background.render(_seed),
            Body.render(_seed),
            Glints.render(_seed),
            Motes.render(_seed),
            Face.render(_seed)
        );
        return SVG.svg(svgChildren);
    }
}
