// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

import {ERC721} from "solmate/tokens/ERC721.sol";
import {Render} from "libraries/Render.sol";
import {Util} from "libraries/Util.sol";
import {Metadata} from "libraries/Metadata.sol";
import {Traits} from "libraries/Traits.sol";

contract Bibos is ERC721 {
    error BibosCostsMoreThanThat();
    error BibosIsMintedOut();
    error InvalidTokenId();

    modifier OnlyIfYouPayEnough() {
        if (msg.value < price) revert BibosCostsMoreThanThat();
        _;
    }

    modifier OnlyIfBibosIsNotMintedOut() {
        if (totalSupply >= maxSupply) revert BibosIsMintedOut();
        _;
    }

    uint256 constant price = 0;
    uint256 constant maxSupply = 999;
    string constant description = "Bibos";
    address immutable owner;
    uint256 public totalSupply;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // tokenId => seed
    mapping(uint256 => bytes32) public seeds;

    constructor() ERC721("Bibos", "BBO") {
        owner = msg.sender;
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        if (_tokenId >= totalSupply) revert InvalidTokenId();
        bytes32 seed = seeds[_tokenId];
        return
            string(
                Metadata.encodeMetadata(
                    _tokenId,
                    _tokenName(_tokenId), // name
                    description, // description
                    Traits.attributes(seed), // attributes
                    Render.bibo(seed) // svg
                )
            );
    }

    function getSeed(uint256 _tokenId) public view returns (bytes32) {
        return seeds[_tokenId];
    }

    function mint() external payable OnlyIfBibosIsNotMintedOut OnlyIfYouPayEnough {
        uint256 id = totalSupply++;
        seeds[id] = keccak256(abi.encodePacked(msg.sender, block.timestamp));
        _mint(msg.sender, id);
    }

    function withdraw(address payable _to) external onlyOwner {
        _to.transfer(address(this).balance);
    }

    function _tokenName(uint256 _tokenId) internal pure returns (string memory) {
        return string.concat("Bibo #", Util.uint256ToString(_tokenId));
    }
}
