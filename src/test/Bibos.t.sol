// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Bibos} from "src/Bibos.sol";

contract BibosTest is Test {
    Bibos bibos;
    uint256 price;
    uint256 maxSupply;

    address payable alice = payable(address(1));
    address payable brian = payable(address(2));
    address payable carly = payable(address(3));

    error InsufficentValue();
    error MintedOut();
    error ZeroMintAmount();
    error InvalidTokenId();
    error AmountNotAvailable();

    function setUp() public {
        vm.prank(alice);
        bibos = new Bibos();
        price = bibos.price();
        maxSupply = bibos.maxSupply();
    }

    function testMint() public {
        bibos.mint{value: price}();
        assertEq(bibos.totalSupply(), 1);
        assertEq(address(bibos).balance, price);
    }

    function testMintWrongPrice(uint16 _value) public {
        vm.assume(_value < 2**12);
        vm.assume(_value != price);
        vm.expectRevert(InsufficentValue.selector);
        bibos.mint{value: _value}();
    }

    function testMintMultiple(uint16 _amount) public {
        vm.assume(_amount <= maxSupply);
        bibos.mint{value: _amount * price}(_amount);
        assertEq(bibos.totalSupply(), _amount);
        assertEq(address(bibos).balance, uint256(_amount) * price);
    }

    function testMintMultipleWrongPrice(uint16 _amount, uint16 _value) public {
        vm.assume(_value < 2**12);
        vm.assume(_amount > 0);
        vm.assume(_amount <= maxSupply);
        vm.assume(_value != uint256(_amount) * price);
        vm.expectRevert(InsufficentValue.selector);
        bibos.mint{value: _value}(_amount);
    }

    function testMintOverSupply(uint16 _amount) public {
        vm.assume(_amount > maxSupply);
        vm.expectRevert(AmountNotAvailable.selector);
        bibos.mint{value: _amount * price}(_amount);
    }

    function testMintWhenMintedOut() public {
        bibos.mint{value: maxSupply * price}(maxSupply);

        vm.expectRevert(MintedOut.selector);
        bibos.mint{value: price}();
    }

    function testMintMultipleWhenMintedOut(uint16 _amount) public {
        vm.assume(_amount > maxSupply);
        bibos.mint{value: maxSupply * price}(maxSupply);

        vm.expectRevert(MintedOut.selector);
        bibos.mint{value: _amount * price}(_amount);
    }

    function testWithdraw(uint16 _amount) public {
        vm.assume(_amount <= maxSupply);
        bibos.mint{value: _amount * price}(_amount);

        vm.prank(brian);
        vm.expectRevert("UNAUTHORIZED");
        bibos.withdraw(carly);

        vm.prank(alice);
        bibos.withdraw(carly);

        assertEq(address(bibos).balance, 0);
        assertEq(carly.balance, _amount * price);
    }

    function testGetTokenURI() public {
        bibos.mint{value: bibos.price()}();
        string memory tokenURI = bibos.tokenURI(0);

        assertGt(bytes(tokenURI).length, 0);
    }
}
