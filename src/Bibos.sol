// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import { ERC721 } from "solmate/tokens/ERC721.sol";
import "./Render.sol";

contract Bibos is ERC721 {
  address public owner;
  uint256 public totalSupply;

  mapping(uint256 => bytes32) public data;

  constructor() ERC721("Bibos", "BBO") {
    owner = msg.sender;
  }

  function tokenURI(uint256 id) public view override returns (string memory) {
    require(id < totalSupply, "invalid id");
    return Render.tokenURI(id, data[id]);
  }

  function mint() external payable {
    uint256 id = ++totalSupply;

    // derive random data
    data[id] = keccak256(abi.encodePacked(msg.sender, block.timestamp));
    // mint token
    _mint(msg.sender, id);
  }
}
