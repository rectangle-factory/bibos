// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Util} from "src/libraries/Util.sol";

library PointsUtil {
    uint256 constant length = 64;

    function body(uint256 _index) internal pure returns (string[2] memory) {
        string[2][64] memory bodyPoints = [
            ["186", "165"],
            ["170", "119"],
            ["174", "150"],
            ["135", "128"],
            ["129", "151"],
            ["172", "175"],
            ["119", "125"],
            ["185", "186"],
            ["165", "124"],
            ["115", "151"],
            ["129", "131"],
            ["165", "129"],
            ["137", "184"],
            ["135", "167"],
            ["181", "147"],
            ["155", "186"],
            ["153", "171"],
            ["164", "127"],
            ["156", "124"],
            ["138", "164"],
            ["156", "113"],
            ["174", "150"],
            ["133", "161"],
            ["119", "153"],
            ["132", "120"],
            ["138", "161"],
            ["182", "186"],
            ["144", "175"],
            ["122", "173"],
            ["169", "166"],
            ["177", "187"],
            ["168", "150"],
            ["149", "162"],
            ["163", "133"],
            ["157", "167"],
            ["157", "179"],
            ["123", "116"],
            ["140", "188"],
            ["166", "112"],
            ["123", "172"],
            ["165", "173"],
            ["147", "116"],
            ["155", "141"],
            ["130", "179"],
            ["172", "162"],
            ["126", "117"],
            ["181", "132"],
            ["124", "125"],
            ["149", "182"],
            ["155", "139"],
            ["155", "148"],
            ["125", "112"],
            ["113", "169"],
            ["134", "131"],
            ["169", "125"],
            ["181", "128"],
            ["170", "144"],
            ["173", "130"],
            ["185", "120"],
            ["151", "122"],
            ["131", "177"],
            ["135", "174"],
            ["157", "166"],
            ["130", "152"]
        ];

        return bodyPoints[_index % 64];
    }

    function getAllBodyAscii() internal pure returns (bytes memory) {
        // all in format XXX
        // numbers less than 256
        // can actually use max but this is easier, cleaner

        // need to convert ascii to integer
        // need to convert integer to ascii (we have this)

        uint256 i;
        bytes memory result;
        for (; i < 64; ) {
            string[2] memory pair = body(i);
            result = abi.encodePacked(result, pair[0]);
            result = abi.encodePacked(result, pair[1]);
            ++i;
        }
        return result;
    }

    function getAllBodyNumeric() internal pure returns (bytes memory) {
        // all in format XXX
        // numbers less than 256

        // need to convert ascii to integer
        // need to convert integer to ascii (we have this)
        bytes memory result;
        uint256 i;
        for (; i < 64; ) {
            string[2] memory pair = body(i);

            result = bytes.concat(result, bytes1(uint8(Util.asciiToUint256(pair[0]))));
            result = bytes.concat(result, bytes1(uint8(Util.asciiToUint256(pair[1]))));
            ++i;
        }
        return result;
    }

    function glint(uint256 _index) internal pure returns (string[2] memory) {
        string[2][64] memory glintPoints = [
            ["14197", "12081"],
            ["16677", "21319"],
            ["13387", "16772"],
            ["22704", "16645"],
            ["17630", "11738"],
            ["17843", "08390"],
            ["12277", "20604"],
            ["17944", "21681"],
            ["18262", "14682"],
            ["21022", "16664"],
            ["15613", "21233"],
            ["18344", "15504"],
            ["14518", "15146"],
            ["08967", "13154"],
            ["13447", "14649"],
            ["09986", "12576"],
            ["15243", "15862"],
            ["11632", "11864"],
            ["16637", "14065"],
            ["15065", "14821"],
            ["12858", "12567"],
            ["21582", "09536"],
            ["13460", "10584"],
            ["13905", "11204"],
            ["19175", "10614"],
            ["20053", "18669"],
            ["07638", "18103"],
            ["12427", "18750"],
            ["12263", "08905"],
            ["22413", "10417"],
            ["17006", "20714"],
            ["19692", "17939"],
            ["13854", "15031"],
            ["15668", "16568"],
            ["15476", "14172"],
            ["09442", "10696"],
            ["13977", "17285"],
            ["17003", "19452"],
            ["06531", "15630"],
            ["06513", "13577"],
            ["15657", "15004"],
            ["16012", "17734"],
            ["16266", "11169"],
            ["12868", "20095"],
            ["10278", "19874"],
            ["15068", "15024"],
            ["14908", "13724"],
            ["19875", "14739"],
            ["10868", "15246"],
            ["11395", "19660"],
            ["14341", "13907"],
            ["15494", "07532"],
            ["11959", "09671"],
            ["11319", "07402"],
            ["18002", "22110"],
            ["14686", "16113"],
            ["13620", "19987"],
            ["14909", "09794"],
            ["10189", "13092"],
            ["15535", "14909"],
            ["13716", "17187"],
            ["10886", "13681"],
            ["15363", "17881"],
            ["17082", "20575"]
        ];
        return glintPoints[_index % 64];
    }

    function getAllGlintsNumeric() internal pure returns (bytes memory) {
        // all in format XXX.XX
        // numbers less than 256

        bytes memory result;
        uint256 i;
        bytes1 integralPart;
        bytes1 fractionalPart;
        for (; i < 64; ) {
            string[2] memory pair = glint(i);
            uint256 x = Util.asciiToUint256(pair[0]);
            integralPart = bytes1(uint8(x / 100));
            fractionalPart = bytes1(uint8(x % 100));
            result = bytes.concat(result, integralPart, fractionalPart);

            uint256 y = Util.asciiToUint256(pair[1]);
            integralPart = bytes1(uint8(y / 100));
            fractionalPart = bytes1(uint8(y % 100));
            result = bytes.concat(result, integralPart, fractionalPart);
            ++i;
        }
        return result;
    }

    function motes(uint256 _index) internal pure returns (string[2][3] memory) {
        string[2][3][24] memory motePoints = [
            [["173", "094"], ["107", "193"], ["206", "127"]],
            [["107", "193"], ["150", "210"], ["193", "193"]],
            [["173", "206"], ["094", "127"], ["150", "210"]],
            [["094", "127"], ["193", "107"], ["107", "107"]],
            [["150", "090"], ["193", "193"], ["107", "193"]],
            [["107", "193"], ["094", "173"], ["090", "150"]],
            [["206", "127"], ["206", "173"], ["150", "210"]],
            [["150", "090"], ["094", "127"], ["206", "127"]],
            [["193", "107"], ["090", "150"], ["150", "210"]],
            [["173", "094"], ["107", "107"], ["193", "193"]],
            [["127", "094"], ["094", "173"], ["127", "206"]],
            [["206", "127"], ["094", "173"], ["210", "150"]],
            [["210", "150"], ["193", "193"], ["127", "094"]],
            [["107", "107"], ["094", "173"], ["127", "094"]],
            [["173", "206"], ["206", "173"], ["090", "150"]],
            [["090", "150"], ["150", "210"], ["107", "107"]],
            [["150", "090"], ["173", "206"], ["090", "150"]],
            [["206", "173"], ["173", "206"], ["107", "107"]],
            [["150", "090"], ["090", "150"], ["127", "094"]],
            [["094", "127"], ["127", "094"], ["206", "173"]],
            [["127", "094"], ["193", "193"], ["206", "127"]],
            [["127", "094"], ["127", "206"], ["150", "210"]],
            [["094", "127"], ["127", "094"], ["150", "210"]],
            [["210", "150"], ["090", "150"], ["150", "090"]]
        ];
        return motePoints[_index % 24];
    }

    function getAllMotesAscii() internal pure returns (bytes memory) {
        // all in format XXX

        uint256 i;
        bytes memory result;
        for (; i < 64; ) {
            string[2][3] memory pair = motes(i);
            uint256 j;
            for (; j < 3; ) {
                result = abi.encodePacked(result, pair[j][0]);
                result = abi.encodePacked(result, pair[j][1]);
                ++j;
            }
            ++i;
        }
        return result;
    }

    function getAllMotesNumeric() internal pure returns (bytes memory) {
        // all in format XXX

        uint256 i;
        bytes memory result;
        for (; i < 64; ) {
            string[2][3] memory pair = motes(i);
            uint256 j;
            for (; j < 3; ) {
                result = bytes.concat(result, bytes1(uint8(Util.asciiToUint256(pair[j][0]))));
                result = bytes.concat(result, bytes1(uint8(Util.asciiToUint256(pair[j][1]))));
                ++j;
            }
            ++i;
        }
        return result;
    }
}
