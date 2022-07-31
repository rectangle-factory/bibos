// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Palette} from "libraries/Palette.sol";
import {Util} from "libraries/Util.sol";
import {SVG} from "libraries/SVG.sol";
import {Traits} from "libraries/Traits.sol";

enum EyeType {
    OPEN,
    SMILEY,
    WINK,
    ROUND,
    SLEEPY,
    CLOVER,
    DIZZY,
    STAR,
    HEART,
    HAHA,
    CYCLOPS,
    OPAL
}

library Eyes {
    /*//////////////////////////////////////////////////////////////
                                 RENDER
    //////////////////////////////////////////////////////////////*/

    function render(bytes32 _seed) internal pure returns (string memory) {
        string memory fill = "black";

        EyeType eyeType = Traits.eyeType(_seed);

        if (eyeType == EyeType.OPEN) return _open(fill);
        if (eyeType == EyeType.SMILEY) return _smiley(fill);
        if (eyeType == EyeType.WINK) return _wink(fill);
        if (eyeType == EyeType.ROUND) return _round(fill);
        if (eyeType == EyeType.SLEEPY) return _sleepy(fill);
        if (eyeType == EyeType.CLOVER) return _clover(fill);
        if (eyeType == EyeType.DIZZY) return _dizzy(fill);
        if (eyeType == EyeType.STAR) return _star(fill);
        if (eyeType == EyeType.HEART) return _heart(fill);
        if (eyeType == EyeType.HAHA) return _haha(fill);
        if (eyeType == EyeType.CYCLOPS) return _cyclops(fill);
        return _opal(fill);
    }

    /*//////////////////////////////////////////////////////////////
                                INTERNAL
    //////////////////////////////////////////////////////////////*/

    function _open(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<ellipse cx="58" cy="79" rx="18" ry="20" fill="',
                _fill,
                '"/>',
                '<ellipse cx="142" cy="79" rx="18" ry="20" fill="',
                _fill,
                '"/>',
                '<ellipse cx="65" cy="75.5" rx="6" ry="6.5" fill="white"/>',
                '<ellipse cx="149" cy="75.5" rx="6" ry="6.5" fill="white"/>'
            );
    }

    function _clover(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M50 69L66 85M50 85L66 69" stroke="',
                _fill,
                '" stroke-width="24" stroke-linecap="round"/>',
                '<path d="M134 69L150 85M134 85L150 69" stroke="',
                _fill,
                '" stroke-width="24" stroke-linecap="round"/>',
                '<circle cx="149" cy="72" r="6" fill="white"/>',
                '<circle cx="65" cy="72" r="6" fill="white"/>'
            );
    }

    function _dizzy(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M59.6645 74.0529C61.0054 72.9366 59.3272 69.9131 56.2074 70.5958C53.2108 70.9583 50.279 75.8268 52.9588 80.7586C55.2103 85.6761 63.4411 88.7892 70.0358 84.4242C76.7252 80.5755 79.5444 69.1782 73.0767 60.6407C67.2313 51.9471 52.4557 48.7063 42.3791 56.7675C32.004 64.0877 29.2918 82.0505 39.5466 94.1708" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>',
                '<path d="M140.459 73.9503C139.143 75.046 140.79 78.0136 143.852 77.3435C146.793 76.9877 149.671 72.2092 147.04 67.3687C144.83 62.542 136.752 59.4865 130.279 63.7708C123.713 67.5484 120.946 78.7349 127.295 87.1145C133.032 95.6473 147.534 98.8282 157.424 90.9161C167.608 83.7313 170.27 66.1006 160.204 54.2045" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>'
            );
    }

    function _cyclops(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<ellipse cx="100" cy="70" rx="18" ry="20" fill="',
                _fill,
                '"/>',
                '<ellipse cx="107" cy="66.5" rx="6" ry="6.5" fill="white"/>'
            );
    }

    function _heart(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M58.0103 99C58.3112 99 58.66 98.8972 59.0567 98.6915C59.467 98.4995 59.8569 98.2801 60.2262 98.0332C64.0288 95.5649 67.3322 92.9731 70.1363 90.2579C72.9541 87.529 75.1358 84.7247 76.6815 81.8449C78.2272 78.9515 79 76.0374 79 73.1028C79 71.1556 78.6854 69.3797 78.0562 67.7753C77.427 66.1709 76.5652 64.7859 75.4709 63.6203C74.3767 62.4546 73.1045 61.5633 71.6546 60.9462C70.2047 60.3154 68.6522 60 66.9971 60C64.9453 60 63.1602 60.5211 61.6419 61.5633C60.1236 62.5918 58.913 63.9494 58.0103 65.6361C57.0938 63.9631 55.8764 62.6055 54.3581 61.5633C52.8534 60.5211 51.0684 60 49.0029 60C47.3478 60 45.7953 60.3154 44.3454 60.9462C42.9091 61.5633 41.637 62.4546 40.5291 63.6203C39.4211 64.7859 38.5525 66.1709 37.9233 67.7753C37.3078 69.3797 37 71.1556 37 73.1028C37 76.0374 37.7728 78.9515 39.3185 81.8449C40.8642 84.7247 43.0459 87.529 45.8637 90.2579C48.6815 92.9731 51.9849 95.5649 55.7738 98.0332C56.1568 98.2801 56.5467 98.4995 56.9433 98.6915C57.3537 98.8972 57.7093 99 58.0103 99Z" fill="',
                _fill,
                '"/>',
                '<path d="M142.01 99C142.311 99 142.66 98.8972 143.057 98.6915C143.467 98.4995 143.857 98.2801 144.226 98.0332C148.029 95.5649 151.332 92.9731 154.136 90.2579C156.954 87.529 159.136 84.7247 160.681 81.8449C162.227 78.9515 163 76.0374 163 73.1028C163 71.1556 162.685 69.3797 162.056 67.7753C161.427 66.1709 160.565 64.7859 159.471 63.6203C158.377 62.4546 157.105 61.5633 155.655 60.9462C154.205 60.3154 152.652 60 150.997 60C148.945 60 147.16 60.5211 145.642 61.5633C144.124 62.5918 142.913 63.9494 142.01 65.6361C141.094 63.9631 139.876 62.6055 138.358 61.5633C136.853 60.5211 135.068 60 133.003 60C131.348 60 129.795 60.3154 128.345 60.9462C126.909 61.5633 125.637 62.4546 124.529 63.6203C123.421 64.7859 122.553 66.1709 121.923 67.7753C121.308 69.3797 121 71.1556 121 73.1028C121 76.0374 121.773 78.9515 123.319 81.8449C124.864 84.7247 127.046 87.529 129.864 90.2579C132.681 92.9731 135.985 95.5649 139.774 98.0332C140.157 98.2801 140.547 98.4995 140.943 98.6915C141.354 98.8972 141.709 99 142.01 99Z" fill="',
                _fill,
                '"/>',
                '<circle cx="152" cy="74" r="6" fill="white"/>',
                '<circle cx="68" cy="74" r="6" fill="white"/>'
            );
    }

    function _smiley(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M40 77.5C46 71.8333 61.6 64.6 76 81" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>',
                '<path d="M160 77.5C154 71.8333 138.4 64.6 124 81" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>'
            );
    }

    function _sleepy(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M74.9877 69.8113C70.6588 76.8378 57.4625 87.8622 39.3086 75.748" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>',
                '<path d="M125.012 69.8113C129.341 76.8378 142.537 87.8622 160.691 75.748" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>'
            );
    }

    function _star(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M121.162 79.0869C121.502 80.5275 122.637 81.8486 124.907 84.4908L125.109 84.7264C124.84 87.7584 124.737 89.3509 125.27 90.6376C125.768 91.8434 126.645 92.8641 127.774 93.5533C128.979 94.2887 130.603 94.4663 133.706 94.7339L133.909 94.9695C136.179 97.6116 137.314 98.9327 138.707 99.5104C139.933 100.019 141.292 100.135 142.589 99.8422C144.064 99.5096 145.416 98.401 148.122 96.184L148.363 95.9863C151.467 96.2492 153.097 96.3497 154.415 95.8298C155.649 95.3426 156.694 94.4862 157.4 93.3833C158.153 92.2064 158.335 90.6206 158.609 87.589L158.85 87.3913C161.555 85.1743 162.907 84.0658 163.499 82.7048C164.019 81.5076 164.138 80.1803 163.838 78.9131C163.498 77.4725 162.363 76.1514 160.093 73.5092L159.891 73.2737C160.16 70.2417 160.263 68.6491 159.731 67.3624C159.232 66.1566 158.355 65.1359 157.226 64.4467C156.021 63.7113 154.397 63.5337 151.294 63.2661L151.091 63.0305C148.821 60.3884 147.686 59.0673 146.293 58.4896C145.067 57.9814 143.708 57.8653 142.411 58.1578C140.936 58.4904 139.584 59.599 136.878 61.816L136.637 62.0137C133.533 61.7508 131.903 61.6503 130.585 62.1702C129.351 62.6574 128.306 63.5138 127.6 64.6167C126.847 65.7936 126.666 67.3794 126.392 70.4109L126.15 70.6087C123.445 72.8257 122.093 73.9342 121.501 75.2952C120.981 76.4924 120.862 77.8197 121.162 79.0869Z" fill="',
                _fill,
                '"/>',
                '<path d="M36.4896 82.7048C37.0673 84.0658 38.3884 85.1743 41.0305 87.3913L41.2662 87.5891C41.5338 90.6206 41.7114 92.2064 42.4468 93.3833C43.1359 94.4862 44.1566 95.3426 45.3625 95.8298C46.6492 96.3497 48.2417 96.2492 51.2736 95.9863L51.5092 96.184C54.1514 98.401 55.4725 99.5096 56.9131 99.8422C58.1803 100.135 59.5076 100.019 60.7048 99.5104C62.0658 98.9327 63.1743 97.6116 65.3913 94.9695L65.589 94.7339C68.6206 94.4663 70.2064 94.2887 71.3833 93.5533C72.4862 92.8641 73.3427 91.8434 73.8299 90.6376C74.3498 89.3509 74.2492 87.7583 73.9864 84.7263L74.184 84.4908C76.401 81.8486 77.5096 80.5275 77.8422 79.0869C78.1347 77.8197 78.0186 76.4924 77.5104 75.2952C76.9327 73.9342 75.6116 72.8257 72.9695 70.6087L72.7339 70.411C72.4663 67.3794 72.2888 65.7936 71.5533 64.6167C70.8642 63.5138 69.8435 62.6574 68.6376 62.1702C67.3509 61.6503 65.7584 61.7508 62.7264 62.0137L62.4908 61.816C59.8486 59.599 58.5275 58.4904 57.0869 58.1578C55.8197 57.8653 54.4924 57.9814 53.2952 58.4896C51.9342 59.0673 50.8257 60.3884 48.6087 63.0305L48.411 63.2661C45.3795 63.5337 43.7937 63.7113 42.6168 64.4467C41.5139 65.1359 40.6574 66.1566 40.1702 67.3624C39.6504 68.6491 39.7509 70.2416 40.0137 73.2736L39.816 73.5092C37.599 76.1514 36.4904 77.4725 36.1578 78.9131C35.8653 80.1803 35.9814 81.5076 36.4896 82.7048Z" fill="',
                _fill,
                '"/>',
                '<circle cx="148" cy="73" r="6" fill="white"/>',
                '<circle cx="64" cy="73" r="6" fill="white"/>'
            );
    }

    function _wink(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M160 77.5C154 71.8333 138.4 64.6 124 81" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round"/>',
                '<ellipse cx="58" cy="79" rx="18" ry="20" fill="',
                _fill,
                '"/>',
                '<ellipse cx="65" cy="75.5" rx="6" ry="6.5" fill="white"/>'
            );
    }

    function _haha(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<path d="M74 80.5L44 77.5833M74 80.5L57.8571 61M74 80.5L52.8571 94" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round" stroke-linejoin="round"/>',
                '<path d="M126 80.5L156 77.5833M126 80.5L142.143 61M126 80.5L147.143 94" stroke="',
                _fill,
                '" stroke-width="10" stroke-linecap="round" stroke-linejoin="round"/>'
            );
    }

    function _round(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<circle cx="142" cy="79" r="19" fill="',
                _fill,
                '"/>',
                '<circle cx="58" cy="79" r="19" fill="',
                _fill,
                '"/>',
                '<circle cx="65" cy="75" r="6" fill="white"/>',
                '<circle cx="149" cy="75" r="6" fill="white"/>'
            );
    }

    function _opal(string memory _fill) internal pure returns (string memory) {
        return
            string.concat(
                '<circle cx="58" cy="79" r="22" fill="',
                _fill,
                '"/>',
                '<circle cx="142" cy="79" r="22" fill="',
                _fill,
                '"/>',
                '<path d="M45.6829 86.5051C45.615 86.0823 45.8239 85.6632 46.2023 85.4628L48.3117 84.3458C48.6981 84.1411 49.1727 84.2113 49.4834 84.5191L51.1522 86.1722C51.4589 86.476 51.536 86.9422 51.3435 87.3286L50.2685 89.486C50.076 89.8724 49.6573 90.0916 49.2301 90.0297L46.9054 89.6929C46.4726 89.6302 46.1308 89.2936 46.0614 88.8618L45.6829 86.5051Z" fill="white" fill-opacity="0.9"/>',
                '<path d="M49.0832 72.1223C49.0972 72.4245 48.962 72.5987 48.6777 72.6448C48.5583 72.6642 48.4466 72.6413 48.3427 72.5762C48.2387 72.511 48.1685 72.4199 48.132 72.3028C47.975 71.766 47.8354 71.3552 47.7134 71.0705C47.5961 70.7791 47.4453 70.5692 47.2611 70.441C47.0826 70.3118 46.8215 70.2311 46.4779 70.199C46.1389 70.1602 45.6664 70.1256 45.0604 70.095C44.7782 70.0822 44.6158 69.9445 44.5733 69.682C44.5538 69.5621 44.5765 69.4501 44.6413 69.3459C44.7061 69.2417 44.7968 69.1713 44.9135 69.1348C45.4814 68.9666 45.9215 68.8191 46.2336 68.6924C46.5456 68.5656 46.7683 68.4094 46.9016 68.2238C47.0349 68.0382 47.1098 67.7801 47.1262 67.4494C47.1483 67.1179 47.1477 66.6641 47.1243 66.088C47.1169 65.7905 47.2525 65.6192 47.5312 65.574C47.8155 65.5279 47.9988 65.6504 48.081 65.9417C48.2371 66.4728 48.3738 66.884 48.4911 67.1754C48.6075 67.4611 48.7573 67.6652 48.9406 67.7878C49.1238 67.9104 49.3878 67.9906 49.7324 68.0284C50.0761 68.0605 50.5481 68.0923 51.1485 68.1238C51.4373 68.1414 51.6025 68.2786 51.6441 68.5355C51.6885 68.8094 51.5581 68.9945 51.2527 69.0909C50.698 69.2687 50.2679 69.4234 49.9624 69.5549C49.6569 69.6864 49.4375 69.845 49.3042 70.0306C49.1709 70.2162 49.0956 70.4715 49.0783 70.7964C49.0609 71.1214 49.0626 71.5633 49.0832 72.1223Z" fill="white" fill-opacity="0.9"/>',
                '<circle cx="61.5" cy="64.5" r="2.5" fill="white" fill-opacity="0.9"/>',
                '<circle cx="54.5" cy="65.5" r="1.5" fill="white" fill-opacity="0.9"/>',
                '<circle cx="69" cy="67" r="1" fill="white" fill-opacity="0.9"/>',
                '<circle cx="73" cy="74" r="1" fill="white" fill-opacity="0.9"/>',
                '<circle cx="63" cy="93" r="1" fill="white" fill-opacity="0.9"/>',
                '<circle cx="43" cy="84" r="1" fill="white" fill-opacity="0.9"/>',
                '<circle cx="44" cy="72" r="1" fill="white" fill-opacity="0.9"/>',
                string.concat(
                    '<circle cx="51" cy="94" r="1" fill="white" fill-opacity="0.9"/>',
                    '<ellipse cx="71.2904" cy="83.7158" rx="3.60879" ry="2.40586" transform="rotate(-25.2591 71.2904 83.7158)" fill="white" fill-opacity="0.9"/>',
                    '<path d="M56.6664 88.3688C56.7484 88.5271 56.871 88.6329 57.0344 88.6863C57.199 88.7431 57.3906 88.7546 57.6091 88.7208L59.8863 88.3738L60.9745 90.3967C61.0816 90.5926 61.2062 90.7386 61.3483 90.8346C61.4918 90.9339 61.6513 90.9686 61.827 90.9387C61.9992 90.9097 62.1345 90.8289 62.2328 90.696C62.3334 90.5643 62.3962 90.3942 62.4211 90.1857L62.6945 87.964L64.9705 87.6458C65.1902 87.6153 65.367 87.5509 65.5008 87.4525C65.6345 87.3541 65.7107 87.2187 65.7294 87.0462C65.7504 86.8748 65.7103 86.7206 65.6091 86.5835C65.5079 86.4464 65.3583 86.3299 65.1605 86.2342L63.0724 85.2154L63.3893 82.9944C63.4199 82.7803 63.4041 82.5948 63.3419 82.438C63.2821 82.2823 63.1737 82.1654 63.0168 82.0873C62.8575 82.008 62.6966 81.9908 62.5339 82.0357C62.3736 82.0817 62.2173 82.1814 62.0649 82.3349L60.4834 83.9261L58.4085 82.8719C58.2153 82.7729 58.0334 82.7243 57.863 82.7261C57.6926 82.728 57.5459 82.7878 57.4229 82.9055C57.2965 83.0244 57.2338 83.168 57.2347 83.3363C57.2391 83.5035 57.2942 83.6834 57.4 83.8759L58.5176 85.884L56.9093 87.4409C56.7579 87.5865 56.66 87.7391 56.6155 87.8988C56.5711 88.0584 56.5881 88.2151 56.6664 88.3688Z" fill="white" fill-opacity="0.9"/>',
                    '<path fill-rule="evenodd" clip-rule="evenodd" d="M52.9292 80.493C53.3951 78.0879 56.1205 79.674 54.2643 81.2575C56.5734 80.4584 56.5579 83.6048 54.2589 82.796C56.1189 84.3923 53.3779 85.9525 52.9351 83.5603C52.4693 85.9654 49.7535 84.3959 51.6 82.7957C49.2838 83.6212 49.2993 80.4748 51.6055 81.2572C49.7384 79.6873 52.4864 78.1007 52.9292 80.493Z" fill="white" fill-opacity="0.9"/>',
                    '<path fill-rule="evenodd" clip-rule="evenodd" d="M57.3165 92.4697C57.5912 91.0518 59.198 91.9869 58.1036 92.9205C59.465 92.4494 59.4559 94.3044 58.1004 93.8275C59.197 94.7686 57.5811 95.6885 57.32 94.2781C57.0454 95.6961 55.4442 94.7708 56.5329 93.8274C55.1673 94.314 55.1765 92.459 56.5361 92.9203C55.4353 91.9948 57.0555 91.0593 57.3165 92.4697ZM57.2111 93.1997C57.3099 93.1426 57.4442 93.17 57.501 93.2684C57.5578 93.3668 57.5201 93.5067 57.4213 93.5637C57.3225 93.6208 57.1923 93.5778 57.1355 93.4794C57.0787 93.3811 57.1123 93.2567 57.2111 93.1997Z" fill="white" fill-opacity="0.9"/>',
                    '<path d="M57.4651 77.0869C57.683 77.417 57.6477 77.7029 57.3593 77.9448C57.2382 78.0464 57.0975 78.0954 56.9372 78.0918C56.777 78.0881 56.6372 78.0328 56.5179 77.9257C55.9826 77.428 55.5512 77.0601 55.2238 76.822C54.8972 76.5733 54.5876 76.4385 54.295 76.4176C54.0082 76.3919 53.6611 76.476 53.2538 76.6697C52.8473 76.8529 52.2936 77.1299 51.5927 77.5008C51.2673 77.6752 50.9929 77.6292 50.7696 77.3629C50.6676 77.2413 50.6182 77.1004 50.6212 76.94C50.6243 76.7797 50.6791 76.64 50.7857 76.5211C51.3109 75.9524 51.7063 75.4925 51.972 75.1415C52.2376 74.7905 52.3832 74.4662 52.4088 74.1687C52.4343 73.8711 52.3457 73.5312 52.1431 73.149C51.9461 72.762 51.642 72.2529 51.2305 71.6217C51.0232 71.2926 51.0609 71.0095 51.3436 70.7725C51.632 70.5306 51.9197 70.5457 52.2068 70.8176C52.7372 71.3095 53.1658 71.6799 53.4923 71.9286C53.814 72.1716 54.1187 72.3006 54.4064 72.3156C54.6942 72.3307 55.0442 72.2442 55.4564 72.0563C55.8637 71.8625 56.415 71.5826 57.1101 71.2165C57.4462 71.0431 57.7234 71.0867 57.9419 71.3472C58.175 71.625 58.1523 71.9201 57.8739 72.2325C57.37 72.8031 56.9905 73.2644 56.7354 73.6164C56.4804 73.9683 56.3401 74.2931 56.3146 74.5906C56.289 74.8882 56.3752 75.2252 56.573 75.6016C56.7708 75.978 57.0682 76.4731 57.4651 77.0869Z" fill="white" fill-opacity="0.9"/>',
                    '<circle cx="45" cy="78" r="2" fill="white" fill-opacity="0.9"/>',
                    '<ellipse cx="53.5" cy="90" rx="1.5" ry="1" fill="white" fill-opacity="0.9"/>',
                    '<ellipse cx="67.5" cy="90" rx="1.5" ry="2" fill="white" fill-opacity="0.9"/>',
                    '<circle cx="149" cy="75" r="6" fill="white"/>',
                    '<path d="M129.683 86.5051C129.615 86.0823 129.824 85.6632 130.202 85.4628L132.312 84.3458C132.698 84.1411 133.173 84.2113 133.483 84.5191L135.152 86.1722C135.459 86.476 135.536 86.9422 135.344 87.3286L134.269 89.486C134.076 89.8724 133.657 90.0916 133.23 90.0297L130.905 89.6929C130.473 89.6302 130.131 89.2936 130.061 88.8618L129.683 86.5051Z" fill="white" fill-opacity="0.9"/>',
                    '<path d="M133.083 72.1223C133.097 72.4245 132.962 72.5987 132.678 72.6448C132.558 72.6642 132.447 72.6413 132.343 72.5762C132.239 72.511 132.169 72.4199 132.132 72.3028C131.975 71.766 131.835 71.3552 131.713 71.0705C131.596 70.7791 131.445 70.5692 131.261 70.441C131.083 70.3118 130.822 70.2311 130.478 70.199C130.139 70.1602 129.666 70.1256 129.06 70.095C128.778 70.0822 128.616 69.9445 128.573 69.682C128.554 69.5621 128.577 69.4501 128.641 69.3459C128.706 69.2417 128.797 69.1713 128.913 69.1348C129.481 68.9666 129.921 68.8191 130.234 68.6924C130.546 68.5656 130.768 68.4094 130.902 68.2238C131.035 68.0382 131.11 67.7801 131.126 67.4494C131.148 67.1179 131.148 66.6641 131.124 66.088C131.117 65.7905 131.253 65.6192 131.531 65.574C131.815 65.5279 131.999 65.6504 132.081 65.9417C132.237 66.4728 132.374 66.884 132.491 67.1754C132.607 67.4611 132.757 67.6652 132.941 67.7878C133.124 67.9104 133.388 67.9906 133.732 68.0284C134.076 68.0605 134.548 68.0923 135.148 68.1238C135.437 68.1414 135.602 68.2786 135.644 68.5355C135.689 68.8094 135.558 68.9945 135.253 69.0909C134.698 69.2687 134.268 69.4234 133.962 69.5549C133.657 69.6864 133.438 69.845 133.304 70.0306C133.171 70.2162 133.096 70.4715 133.078 70.7964C133.061 71.1214 133.063 71.5633 133.083 72.1223Z" fill="white" fill-opacity="0.9"/>',
                    '<circle cx="145.5" cy="64.5" r="2.5" fill="white" fill-opacity="0.9"/>',
                    '<circle cx="138.5" cy="65.5" r="1.5" fill="white" fill-opacity="0.9"/>',
                    '<circle cx="153" cy="67" r="1" fill="white" fill-opacity="0.9"/>',
                    string.concat(
                        '<circle cx="157" cy="74" r="1" fill="white" fill-opacity="0.9"/>',
                        '<circle cx="147" cy="93" r="1" fill="white" fill-opacity="0.9"/>',
                        '<circle cx="127" cy="84" r="1" fill="white" fill-opacity="0.9"/>',
                        '<circle cx="128" cy="72" r="1" fill="white" fill-opacity="0.9"/>',
                        '<circle cx="135" cy="94" r="1" fill="white" fill-opacity="0.9"/>',
                        '<ellipse cx="155.29" cy="83.7158" rx="3.60879" ry="2.40586" transform="rotate(-25.2591 155.29 83.7158)" fill="white" fill-opacity="0.9"/>',
                        '<path d="M140.666 88.3688C140.748 88.5271 140.871 88.6329 141.034 88.6863C141.199 88.7431 141.391 88.7546 141.609 88.7208L143.886 88.3738L144.975 90.3967C145.082 90.5926 145.206 90.7386 145.348 90.8346C145.492 90.9339 145.651 90.9686 145.827 90.9387C145.999 90.9097 146.134 90.8289 146.233 90.696C146.333 90.5643 146.396 90.3942 146.421 90.1857L146.695 87.964L148.971 87.6458C149.19 87.6153 149.367 87.5509 149.501 87.4525C149.635 87.3541 149.711 87.2187 149.729 87.0462C149.75 86.8748 149.71 86.7206 149.609 86.5835C149.508 86.4464 149.358 86.3299 149.16 86.2342L147.072 85.2154L147.389 82.9944C147.42 82.7803 147.404 82.5948 147.342 82.438C147.282 82.2823 147.174 82.1654 147.017 82.0873C146.858 82.008 146.697 81.9908 146.534 82.0357C146.374 82.0817 146.217 82.1814 146.065 82.3349L144.483 83.9261L142.409 82.8719C142.215 82.7729 142.033 82.7243 141.863 82.7261C141.693 82.728 141.546 82.7878 141.423 82.9055C141.297 83.0244 141.234 83.168 141.235 83.3363C141.239 83.5035 141.294 83.6834 141.4 83.8759L142.518 85.884L140.909 87.4409C140.758 87.5865 140.66 87.7391 140.616 87.8988C140.571 88.0584 140.588 88.2151 140.666 88.3688Z" fill="white" fill-opacity="0.9"/>',
                        '<path fill-rule="evenodd" clip-rule="evenodd" d="M136.929 80.493C137.395 78.0879 140.121 79.674 138.264 81.2575C140.573 80.4584 140.558 83.6048 138.259 82.796C140.119 84.3923 137.378 85.9525 136.935 83.5603C136.469 85.9654 133.753 84.3959 135.6 82.7957C133.284 83.6212 133.299 80.4748 135.605 81.2572C133.738 79.6873 136.486 78.1007 136.929 80.493Z" fill="white" fill-opacity="0.9"/>',
                        '<path fill-rule="evenodd" clip-rule="evenodd" d="M141.317 92.4697C141.591 91.0518 143.198 91.9869 142.104 92.9205C143.465 92.4494 143.456 94.3044 142.1 93.8275C143.197 94.7686 141.581 95.6885 141.32 94.2781C141.045 95.6961 139.444 94.7708 140.533 93.8274C139.167 94.314 139.176 92.459 140.536 92.9203C139.435 91.9948 141.055 91.0593 141.317 92.4697ZM141.211 93.1997C141.31 93.1426 141.444 93.17 141.501 93.2684C141.558 93.3668 141.52 93.5067 141.421 93.5637C141.322 93.6208 141.192 93.5778 141.135 93.4794C141.079 93.3811 141.112 93.2567 141.211 93.1997Z" fill="white" fill-opacity="0.9"/>',
                        '<path d="M141.465 77.0869C141.683 77.417 141.648 77.7029 141.359 77.9448C141.238 78.0464 141.097 78.0954 140.937 78.0918C140.777 78.0881 140.637 78.0328 140.518 77.9257C139.983 77.428 139.551 77.0601 139.224 76.822C138.897 76.5733 138.588 76.4385 138.295 76.4176C138.008 76.3919 137.661 76.476 137.254 76.6697C136.847 76.8529 136.294 77.1299 135.593 77.5008C135.267 77.6752 134.993 77.6292 134.77 77.3629C134.668 77.2413 134.618 77.1004 134.621 76.94C134.624 76.7797 134.679 76.64 134.786 76.5211C135.311 75.9524 135.706 75.4925 135.972 75.1415C136.238 74.7905 136.383 74.4662 136.409 74.1687C136.434 73.8711 136.346 73.5312 136.143 73.149C135.946 72.762 135.642 72.2529 135.23 71.6217C135.023 71.2926 135.061 71.0095 135.344 70.7725C135.632 70.5306 135.92 70.5457 136.207 70.8176C136.737 71.3095 137.166 71.6799 137.492 71.9286C137.814 72.1716 138.119 72.3006 138.406 72.3156C138.694 72.3307 139.044 72.2442 139.456 72.0563C139.864 71.8625 140.415 71.5826 141.11 71.2165C141.446 71.0431 141.723 71.0867 141.942 71.3472C142.175 71.625 142.152 71.9201 141.874 72.2325C141.37 72.8031 140.99 73.2644 140.735 73.6164C140.48 73.9683 140.34 74.2931 140.315 74.5906C140.289 74.8882 140.375 75.2252 140.573 75.6016C140.771 75.978 141.068 76.4731 141.465 77.0869Z" fill="white" fill-opacity="0.9"/>',
                        '<circle cx="129" cy="78" r="2" fill="white" fill-opacity="0.9"/>',
                        '<ellipse cx="137.5" cy="90" rx="1.5" ry="1" fill="white" fill-opacity="0.9"/>',
                        '<ellipse cx="151.5" cy="90" rx="1.5" ry="2" fill="white" fill-opacity="0.9"/>',
                        '<circle cx="65" cy="75" r="6" fill="white"/>'
                    )
                )
            );
    }
}
