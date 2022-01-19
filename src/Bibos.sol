// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

import { ERC721 } from "solmate/tokens/ERC721.sol";

contract Bibos is ERC721 {
  address public owner;
  uint256 public totalSupply;

  constructor() ERC721("Bibos", "BBO") {
    owner = msg.sender;
  }

  function tokenURI(uint256 id) public pure override returns (string memory) {
    return string(abi.encodePacked(id));
  }

  function mint() external payable {
    _mint(msg.sender, totalSupply++);
  }
}
