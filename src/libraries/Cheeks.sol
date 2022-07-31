// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Util} from "./Util.sol";
import {SVG} from "./SVG.sol";
import {Traits} from "./Traits.sol";

enum CheekType {
    NONE,
    CIRCULAR,
    FRECKLES,
    BIG
}

library Cheeks {
    /*//////////////////////////////////////////////////////////////
                                 RENDER
    //////////////////////////////////////////////////////////////*/

    function render(bytes32 _seed) internal pure returns (string memory) {
        CheekType cheekType = Traits.cheekType(_seed);
        if (cheekType == CheekType.CIRCULAR) return _circular();
        if (cheekType == CheekType.FRECKLES) return _freckles();
        if (cheekType == CheekType.BIG) return _big();
        return "";
    }

    /*//////////////////////////////////////////////////////////////
                                INTERNAL
    //////////////////////////////////////////////////////////////*/

    function _circular() internal pure returns (string memory) {
        return
            string.concat(
                "<circle cx='149' cy='113' r='6' fill='white' fill-opacity='0.6'/>",
                "<circle cx='54' cy='113' r='6' fill='white' fill-opacity='0.6'/>"
            );
    }

    function _big() internal pure returns (string memory) {
        return
            string.concat(
                "<ellipse cx='151' cy='113' rx='11' ry='9' fill='white' fill-opacity='0.3'/>",
                "<ellipse cx='52' cy='113' rx='11' ry='9' fill='white' fill-opacity='0.3'/>"
            );
    }

    function _freckles() internal pure returns (string memory) {
        return
            string.concat(
                "<circle cx='144.5' cy='110.5' r='3.5' fill='white' fill-opacity='0.6'/>",
                "<circle cx='151.5' cy='117.5' r='3.5' fill='white' fill-opacity='0.6'/>",
                "<circle cx='155.5' cy='108.5' r='3.5' fill='white' fill-opacity='0.6'/>",
                "<circle r='3.5' transform='matrix(-1 0 0 1 57.5 110.5)' fill='white' fill-opacity='0.6'/>",
                "<circle r='3.5' transform='matrix(-1 0 0 1 50.5 117.5)' fill='white' fill-opacity='0.6'/>",
                "<circle r='3.5' transform='matrix(-1 0 0 1 46.5 108.5)' fill='white' fill-opacity='0.6'/>"
            );
    }
}
