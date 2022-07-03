// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

/* solhint-disable */
// -╖╖╖╖╖╖╖╖╖╖╖»─  ─┬╖╖╖╖─~  -╖╖╖╖╖╖╖╖╖╖╖»─    -╖╖╖╖╖╖╖╖╖╖»─   ~─╖╖╖╖╖╖╖╖╖╖╖~
//    ███   `███      ███▌      ███   `███      ┌▓██^ █ ╙██╗     á███^   ╔██
//    █B█     ███▌    █I█Γ      █B█     ███▌    █O█   █   ███▄   █S█▌    ███
//    ███    ╒███     ███Γ      ███    ╒███    ███    █    ███   ▀██▓    ██
//    ███   á██▀      ███Γ      ███   #██╜    ╞███    █    ███    `███▄  '█╕
//    ███▄▓██▄        ███Γ      ███▄▓██▄      ╞██▌    █    ███       ╙██╗  `
//    ███    "██▌     ███Γ      ███    "██▌   '██▌    █'   ███   ,╗█"   ▀██w
//   ▓███      ▓██    ████     ▓███      ███   ███    █   ┌██   ██        ███▓
//    ███      ▐███  ^╙███     └███      ╞███   ██╕   ╫   ██▌  ██          ███
//    █B█      â██▌    I▐█      █B█      ║██▌    █O┐  ║   █▀   ██          █S█
//    ███     #██`     ╓▓█      ███     #██`      └█▌ ║ ╣█     ║█ε        ╒███
//   ╔██▓╗╗@▀╝^        "╙██┐   á██▓╗╗@▀╨^           `▀██        '█╗     ,Æ██`
//                         "▀≥»-                      ╞            ^╙▀▀╜"
/* solhint-enable */

import {ERC721} from "solmate/tokens/ERC721.sol";
import {Render} from "./libraries/Render.sol";

contract Bibos is ERC721 {
    address public owner;
    uint256 public totalSupply;

    // tokenId => seed
    mapping(uint256 => bytes32) public seed;
    error InvalidTokenId();

    constructor() ERC721("Bibos", "BBO") {
        owner = msg.sender;
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        if (_tokenId >= totalSupply) revert InvalidTokenId();
        return Render.tokenURI(_tokenId, seed[_tokenId]);
    }

    function getSeed(uint256 _tokenId) public view returns (bytes32) {
        return seed[_tokenId];
    }

    function mint() external payable {
        uint256 id = totalSupply++;
        seed[id] = keccak256(abi.encodePacked(msg.sender, block.timestamp));
        _mint(msg.sender, id);
    }
}
