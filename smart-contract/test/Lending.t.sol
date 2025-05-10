// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Lending} from "../src/Lending.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LendingTest is Test {
    Lending public lending;

    // Arbitrum mainnet addresses
    address constant weth = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
    address constant usdc = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
    address constant aave = 0x794a61358D6845594F94dc1DB02A252b5b4814aD;

    function setUp() public {
        vm.createSelectFork(
            "https://arb-mainnet.g.alchemy.com/v2/AFncfjMcQ2V2t3_78Cp5UZ9w6ZyXT-du",
            335093227
        );
        lending = new Lending();
    }

    function testSupplyAndBorrow() public {
        deal(weth, address(this), 1e18);
        IERC20(weth).approve(address(lending), 1e18);

        lending.supplyAndBorrow(1e18, 100e6);

        assertEq(IERC20(usdc).balanceOf(address(this)), 100e6);
        console.log("USDC balance:", IERC20(usdc).balanceOf(address(this)));
    }
}
