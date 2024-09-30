// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./lib/TickMath.sol";
import {console} from "forge-std/console.sol";

contract Deposit {
    int24 min_tick = -887272;
    int24 max_tick = 887272;
    address internal constant NON_FUNGIBLE_POS_MANAGER = 0xC36442b4a4522E871399CD717aBDD847Ab11FE88;

    function createPosition(address pool, uint256 amount0Desired, uint256 amount1Desired, uint16 width) external returns (
            uint256 tokenId,
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        )
        {

        // uint160 min_res = TickMath.getSqrtRatioAtTick(min_tick);
        // console.log("sqrtRatio at min tick:", min_res);

        // int24 tick = 276323;
        // uint160 res = TickMath.getSqrtRatioAtTick(tick);
        // console.log("sqrtRatio found:", res);

        // uint160 sqrtPriceX96 = 79231163915643465547832199123538643;
        // int24 foundTick = TickMath.getTickAtSqrtRatio(sqrtPriceX96);
        // console.log("tick found:", foundTick);
    }
}
