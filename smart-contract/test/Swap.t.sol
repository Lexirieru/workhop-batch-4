// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Swap} from "../src/Swap.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SwapTest is Test {
    Swap public swap;
    address weth = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
    address usdc = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;

    function setUp() public {
        vm.createSelectFork(
            "https://arb-mainnet.g.alchemy.com/v2/AFncfjMcQ2V2t3_78Cp5UZ9w6ZyXT-du",
            335093227
        );
        swap = new Swap();
    }

    function testSwap() public {
        // Deal some WETH to the test contract
        deal(weth, address(this), 1e18);

        // Approve the Swap contract to spend our WETH
        IERC20(weth).approve(address(swap), 1e18);

        // Perform the swap
        swap.swap(1e18);

        // Verify we received USDC
        assertGt(IERC20(usdc).balanceOf(address(this)), 0);
        console.log("USDC balance:", IERC20(usdc).balanceOf(address(this)));
    }
}
