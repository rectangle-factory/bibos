// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

import {ERC721} from "solmate/tokens/ERC721.sol";
import {Owned} from "solmate/auth/Owned.sol";
import {Render} from "libraries/Render.sol";
import {Util} from "libraries/Util.sol";
import {Metadata} from "libraries/Metadata.sol";
import {Traits} from "libraries/Traits.sol";

contract Bibos is ERC721, Owned {
    /*//////////////////////////////////////////////////////////////
                                  STATE
    //////////////////////////////////////////////////////////////*/

    uint256 public constant price = (999 * 1 ether) / 10_000;
    uint256 public constant maxMintAmount = 10;
    uint256 public constant maxSupply = 999;
    string public constant description = "Bibos";
    uint256 public totalSupply;
    mapping(uint256 => bytes32) public seeds; // (tokenId => seed)

    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error InsufficentValue();
    error MintedOut();
    error ZeroMintAmount();
    error TooManyBibos();
    error InvalidTokenId();

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier OnlyIfYouPayEnough(uint256 _amount) {
        if (msg.value < _amount * price) revert InsufficentValue();
        _;
    }

    modifier OnlyIfNotMintedOut() {
        if (totalSupply >= maxSupply) revert MintedOut();
        _;
    }

    modifier OnlyIfFewerThanMaxMintAmount(uint256 _amount) {
        if (_amount > maxMintAmount) revert TooManyBibos();
        _;
    }

    modifier OnlyPositive(uint256 _amount) {
        if (_amount == 0) revert ZeroMintAmount();
        _;
    }

    /*//////////////////////////////////////////////////////////////
                               CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor() ERC721("Bibos", "BBO") Owned(msg.sender) {
        owner = msg.sender;
    }

    /*//////////////////////////////////////////////////////////////
                                TOKENURI
    //////////////////////////////////////////////////////////////*/

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        if (_tokenId >= totalSupply) revert InvalidTokenId();
        bytes32 seed = seeds[_tokenId];
        return
            Metadata.encodeMetadata({
                _id: _tokenId,
                _name: _tokenName(_tokenId),
                _description: description,
                _attributes: Traits.attributes(seed),
                _svg: Render.bibo(seed)
            });
    }

    /*//////////////////////////////////////////////////////////////
                                 MINTING
    //////////////////////////////////////////////////////////////*/

    function mint() public payable OnlyIfNotMintedOut OnlyIfYouPayEnough(1) {
        _mint(msg.sender);
    }

    function mint(uint256 _amount)
        public
        payable
        OnlyIfNotMintedOut
        OnlyIfYouPayEnough(_amount)
        OnlyPositive(_amount)
        OnlyIfFewerThanMaxMintAmount(_amount)
    {
        for (; _amount > 0; ) {
            _mint(msg.sender);
            _amount--;
        }
    }

    /*//////////////////////////////////////////////////////////////
                                WITHDRAW
    //////////////////////////////////////////////////////////////*/

    function withdraw(address payable _to) public onlyOwner {
        _to.transfer(address(this).balance);
    }

    /*//////////////////////////////////////////////////////////////
                                INTERNAL
    //////////////////////////////////////////////////////////////*/

    function _mint(address _to) internal {
        uint256 id = totalSupply++;
        seeds[id] = keccak256(abi.encodePacked(msg.sender, block.timestamp, id));
        ERC721._mint(_to, id);
    }

    function _tokenName(uint256 _tokenId) internal pure returns (string memory) {
        return string.concat("Bibo #", Util.uint256ToString(_tokenId));
    }
}
