// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;
import {Script, console2 as console} from "forge-std/Script.sol";
import {Util} from "src/libraries/Util.sol";

library Times2 {
    uint256 constant length = 64;
    bytes public constant shortHex2 =
        hex"383933393734363837393631383536353837393637373331353932383031393539353530383333383430363233353838393735393939353233353639373338373136363230353137363034353031393436383331373231353936393836373737353232353233363232373231383037393239383939383535393830353439373731373936373837393339383136393331383336353633363834383733393631373636393030393137363837383437383331363538373231383832393636393932";
    bytes public constant shortHex =
        hex"6faf3957bc16b092de3adb4a0c85dfa26682d2137a4c79ef9d05a395c4b31362054b87d5d933f5a2951ed30941482d372d164ee85c1b577a889581b1c626ead983a36888cd56369782bf9c239555ed3d9fa925a2dc9e33e0";
    bytes public constant longHex =
        hex"31313230313436353132353231333631303836393134393230393931313035363133313531323334303835313132303530383437313334373039383430383838313334323130323330373930303739343037373131323036313335323038343630393636313137383037363031323438313230303039323331323737303738303131323531343430313136313133353231323436313038333132303231343235303935323039393730393937313030363132303630383930313137313133343031313936313232363133333531313633313038333133303331323131313436363131333031313632313039363130353431343038303739313134363431333636";
    bytes1 constant bytesMask = hex"FF";

    // function short(uint256 _i) internal pure returns (string memory) {
    //     uint256 pos = _i * 3;
    //     bytes memory result = new bytes(4);
    //     result[0] = shortHex[pos];
    //     result[1] = ".";
    //     result[2] = shortHex[pos + 1];
    //     result[3] = shortHex[pos + 2];
    //     return string(result);
    // }

    function short(uint256 _i) internal view returns (string memory) {
        uint256 s = 11;
        // first bytes to get in result
        uint256 j = (_i * 11) / 8;
        uint256 l = (_i * 11) % 8;
        // l + s is how long on the left, then we fill out to be a multiple of 8
        // b = (r+l+8)/8 is how many bytes we need

        uint256 r = ((8 - ((l + s) % 8)) % 8);
        uint256 b = (l + s + r) / 8;

        uint256 k;
        uint256 result;
        console.logBytes1(shortHex[j + k]);
        bytes1 val = shortHex[j + k] << ((8 - l) % 8);
        console.log(l, r, b);
        console.logBytes1(val);
        uint256 addend = uint256(uint8(val)) << 3;
        console.log(addend);
        result += addend;
        ++k;
        if (b == 3) {
            val = shortHex[j + k];
            console.logBytes1(val);
            addend = uint256(uint8(val)) << 8;
            console.log(addend);
            result += addend;
            ++k;
        }
        val = shortHex[j + k];
        console.logBytes1(val);
        addend = uint256(uint8(val)) >> r;
        console.log(addend);
        result += addend;
        console.log(result);

        return string.concat(Util.uint256ToAscii(result / 100), ".", Util.uint256ToAscii(result % 100));
    }

    function long(uint256 _i) internal pure returns (string memory) {
        uint256 pos = _i * 4;
        bytes memory result = new bytes(5);
        result[0] = longHex[pos];
        result[1] = longHex[pos + 1];
        result[2] = ".";
        result[3] = longHex[pos + 2];
        result[4] = longHex[pos + 3];
        return string(result);
    }
}
