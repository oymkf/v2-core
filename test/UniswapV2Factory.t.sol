// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.16;
pragma abicoder v2;

import "forge-std/Test.sol";
import "./ERC20Mintable.sol";
import "../src/UniswapV2Factory.sol";

contract UniswapV2FactoryTest is Test {
    ERC20Mintable weth;
    ERC20Mintable usdt;

    UniswapV2Factory factory;

    function setUp() public {
        weth = new ERC20Mintable("Ether", "ETH", 18);
        usdt = new ERC20Mintable("USDT", "USDT", 18);

        factory = new UniswapV2Factory(address(this));
    }

    function testMint() public {
        weth.mint(address(this), 100 ether);
        usdt.mint(address(this), 100 ether);
        assertEq(weth.balanceOf(address(this)), 100 ether);
        assertEq(usdt.balanceOf(address(this)), 100 ether);
    }
}
