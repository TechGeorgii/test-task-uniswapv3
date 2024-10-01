// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Deposit} from "../src/Deposit.sol";
import {console} from "forge-std/console.sol";

contract DepositTest is Test {
    address constant OPTIMISM_USDT_DAI_POOL = 0x8323D063b1D12ACce4742f1E3ed9BC46d71f4222;
    Deposit public deposit;

    function setUp() public {
        deposit = new Deposit();
    }

    function test_CreatePosition() public {
        // from tx 0x3c6da60ab1f78c635a9a27a84163c0ec628111c370d2073246e44adf728a3322
        deposit.createPosition(OPTIMISM_USDT_DAI_POOL, 1878690348, 1598506205772095349654, 1000, 999999999999);
    }

    function test_Calc() public {
        
    }
}
