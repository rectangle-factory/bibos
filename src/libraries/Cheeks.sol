// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "./Palette.sol";
import {Times} from "./Times.sol";
import {Points} from "./Points.sol";
import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";

library Cheeks {
    enum CheekType {
        NONE,
        CIRCULAR,
        FRECKLES
    }

    function render(bytes32 _seed) public pure returns (string memory) {
        CheekType cheekType = getCheekType(_seed);

        if (cheekType == CheekType.CIRCULAR) return circular();
        if (cheekType == CheekType.FRECKLES) return freckles();

        return "";
    }

    function getCheekType(bytes32 _seed) public pure returns (CheekType) {
        uint256 cheeksSeed = uint256(keccak256(abi.encodePacked(_seed, "cheeks"))) % 100;

        if (cheeksSeed % 100 < 70) return CheekType.NONE;
        if (cheeksSeed % 100 < 95) return CheekType.CIRCULAR;
        return CheekType.FRECKLES;
    }

    function circular() internal pure returns (string memory) {
        return
            string.concat(
                "<circle cx='149' cy='113' r='6' fill='white' fill-opacity='0.8'/>",
                "<circle cx='54' cy='113' r='6' fill='white' fill-opacity='0.8'/>"
            );
    }

    function freckles() internal pure returns (string memory) {
        return
            string.concat(
                "<circle cx='144.5' cy='110.5' r='3.5' fill='white' fill-opacity='0.8'/>",
                "<circle cx='151.5' cy='117.5' r='3.5' fill='white' fill-opacity='0.8'/>",
                "<circle cx='155.5' cy='108.5' r='3.5' fill='white' fill-opacity='0.8'/>",
                "<circle r='3.5' transform='matrix(-1 0 0 1 57.5 110.5)' fill='white' fill-opacity='0.8'/>",
                "<circle r='3.5' transform='matrix(-1 0 0 1 50.5 117.5)' fill='white' fill-opacity='0.8'/>",
                "<circle r='3.5' transform='matrix(-1 0 0 1 46.5 108.5)' fill='white' fill-opacity='0.8'/>"
            );
    }
}
