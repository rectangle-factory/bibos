// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

library Palette {
    enum Refractivity {
        LIGHT,
        DARK
    }

    function getRefractivity(bytes32 _seed) internal pure returns (Refractivity) {
        uint256 refractivitySeed = uint256(keccak256(abi.encodePacked(_seed, "refractivity"))) % 100;

        if (refractivitySeed < 80) return Refractivity.LIGHT;
        return Refractivity.DARK;
    }

    function getBodyFill(bytes32 _seed, uint256 _i) internal pure returns (string memory) {
        uint256 bodyFillValue = uint256(keccak256(abi.encodePacked(_seed, "bodyFill", _i)));

        if (getRefractivity(_seed) == Refractivity.LIGHT) return lightPalette(bodyFillValue);
        else return lightestPalette(bodyFillValue);
    }

    function getBackgroundFill(bytes32 _seed) internal pure returns (string memory) {
        uint256 backgroundFillValue = uint256(keccak256(abi.encodePacked(_seed, "backgroundFill")));

        if (getRefractivity(_seed) == Refractivity.LIGHT) return darkestPalette(backgroundFillValue);
        else return darkestPalette(backgroundFillValue);
    }

    function lightestPalette(uint256 _value) internal pure returns (string memory) {
        string[64] memory lightestPaletteValues = [
            "#ffb3b3",
            "#ffbab3",
            "#ffc1b3",
            "#ffc8b3",
            "#ffcfb3",
            "#ffd6b3",
            "#ffddb3",
            "#ffe4b3",
            "#ffebb3",
            "#fff2b3",
            "#fff9b3",
            "#feffb3",
            "#f7ffb3",
            "#f0ffb3",
            "#e8ffb3",
            "#e1ffb3",
            "#daffb3",
            "#d3ffb3",
            "#ccffb3",
            "#c5ffb3",
            "#beffb3",
            "#b7ffb3",
            "#b3ffb5",
            "#b3ffbc",
            "#b3ffc3",
            "#b3ffca",
            "#b3ffd1",
            "#b3ffd8",
            "#b3ffe0",
            "#b3ffe7",
            "#b3ffee",
            "#b3fff5",
            "#b3fffc",
            "#b3fbff",
            "#b3f4ff",
            "#b3edff",
            "#b3e6ff",
            "#b3dfff",
            "#b3d8ff",
            "#b3d1ff",
            "#b3caff",
            "#b3c3ff",
            "#b3bbff",
            "#b3b4ff",
            "#b8b3ff",
            "#bfb3ff",
            "#c6b3ff",
            "#cdb3ff",
            "#d4b3ff",
            "#dbb3ff",
            "#e2b3ff",
            "#e9b3ff",
            "#f0b3ff",
            "#f7b3ff",
            "#feb3ff",
            "#ffb3f9",
            "#ffb3f1",
            "#ffb3ea",
            "#ffb3e3",
            "#ffb3dc",
            "#ffb3d5",
            "#ffb3ce",
            "#ffb3c7",
            "#ffb3c0"
        ];
        return lightestPaletteValues[_value % 64];
    }

    function lightPalette(uint256 _value) internal pure returns (string memory) {
        string[64] memory lightPaletteValues = [
            "#ff3333",
            "#ff4633",
            "#ff5933",
            "#ff6c33",
            "#ff7e33",
            "#ff9133",
            "#ffa433",
            "#ffb733",
            "#ffca33",
            "#ffdd33",
            "#fff033",
            "#fcff33",
            "#e9ff33",
            "#d6ff33",
            "#c3ff33",
            "#b0ff33",
            "#9dff33",
            "#8aff33",
            "#78ff33",
            "#65ff33",
            "#52ff33",
            "#3fff33",
            "#33ff3a",
            "#33ff4d",
            "#33ff60",
            "#33ff72",
            "#33ff85",
            "#33ff98",
            "#33ffab",
            "#33ffbe",
            "#33ffd1",
            "#33ffe4",
            "#33fff7",
            "#33f5ff",
            "#33e2ff",
            "#33cfff",
            "#33bcff",
            "#33a9ff",
            "#3396ff",
            "#3383ff",
            "#3371ff",
            "#335eff",
            "#334bff",
            "#3338ff",
            "#4133ff",
            "#5433ff",
            "#6733ff",
            "#7933ff",
            "#8c33ff",
            "#9f33ff",
            "#b233ff",
            "#c533ff",
            "#d833ff",
            "#eb33ff",
            "#fd33ff",
            "#ff33ee",
            "#ff33db",
            "#ff33c8",
            "#ff33b5",
            "#ff33a2",
            "#ff338f",
            "#ff337d",
            "#ff336a",
            "#ff3357"
        ];
        return lightPaletteValues[_value % 64];
    }

    function darkestPalette(uint256 _value) internal pure returns (string memory) {
        string[64] memory darkestPaletteValues = [
            "#060a06",
            "#060d07",
            "#061007",
            "#061407",
            "#061907",
            "#051e07",
            "#042306",
            "#022805",
            "#060a08",
            "#060d0a",
            "#06100c",
            "#06140e",
            "#061910",
            "#051e13",
            "#042315",
            "#022817",
            "#06090a",
            "#060d0d",
            "#061010",
            "#061414",
            "#061819",
            "#051d1e",
            "#042123",
            "#022728",
            "#06080a",
            "#06090d",
            "#060b10",
            "#060d14",
            "#060f19",
            "#05111e",
            "#041223",
            "#021428",
            "#06060a",
            "#06060d",
            "#060610",
            "#060614",
            "#060619",
            "#05051e",
            "#040423",
            "#020228",
            "#08060a",
            "#09060d",
            "#0b0610",
            "#0d0614",
            "#0f0619",
            "#11051e",
            "#120423",
            "#140228",
            "#09060a",
            "#0d060d",
            "#100610",
            "#140614",
            "#180619",
            "#1d051e",
            "#210423",
            "#270228",
            "#0a0608",
            "#0d060a",
            "#10060c",
            "#14060e",
            "#190610",
            "#1e0513",
            "#230415",
            "#280217"
        ];
        return darkestPaletteValues[_value % 64];
    }
}
