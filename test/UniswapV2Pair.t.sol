// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.16;
pragma abicoder v2;

import "forge-std/Test.sol";
import "./ERC20Mintable.sol";
import "../src/UniswapV2Factory.sol";
import "v2-periphery/UniswapV2Router02.sol" as Router;

contract UniswapV2PairTest is Test {
    ERC20Mintable weth;
    ERC20Mintable usdt;
    ERC20Mintable wbtc;

    UniswapV2Factory factory;
    Router.UniswapV2Router02 router;

    address pair1;
    address pair2;
    address pair3;

    function setUp() public {
        weth = new ERC20Mintable("Ether", "ETH", 18);
        usdt = new ERC20Mintable("USDT", "USDT", 18);
        wbtc = new ERC20Mintable("WBTC", "WBTC", 18);

        weth.mint(address(this), 100 ether);
        usdt.mint(address(this), 100000 ether);
        wbtc.mint(address(this), 10 ether);

        factory = new UniswapV2Factory(address(this));

        router = new Router.UniswapV2Router02(address(factory), address(weth));

        pair1 = factory.createPair(address(weth), address(usdt));
        pair2 = factory.createPair(address(weth), address(wbtc));
        pair3 = factory.createPair(address(usdt), address(wbtc));
    }

    function testMint() public {
        weth.transfer(pair1, 1 ether);
        usdt.transfer(pair1, 1700 ether);
        UniswapV2Pair(pair1).mint(address(this));
        uint256 liquidity = UniswapV2Pair(pair1).balanceOf(address(this));
        UniswapV2Pair(pair1).transfer(pair1, liquidity);
        UniswapV2Pair(pair1).burn(address(this));
        liquidity = UniswapV2Pair(pair1).balanceOf(address(this));
        console.log("liquidity: %s", liquidity);
        console.log("totalSupply: %s", UniswapV2Pair(pair1).totalSupply());
    }

    function testSwap() public {
        weth.transfer(pair1, 1 ether);
        usdt.transfer(pair1, 1700 ether);
        UniswapV2Pair(pair1).mint(address(this));
    }
}
