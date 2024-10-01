// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./lib/TickMath.sol";
import "./lib/interfaces/INonfungiblePositionManager.sol";
import "./lib/interfaces/IUniswapV3Pool.sol";
import {console} from "forge-std/console.sol";
import "solmate/utils/FixedPointMathLib.sol";

contract Deposit {
    struct PoolSlot {        
        uint160 sqrtPriceX96;
        int24 tick;
        uint16 observationIndex;
        uint16 observationCardinality;
        uint16 observationCardinalityNext;
        uint8 feeProtocol;
        bool unlocked;        
    }

    uint256 constant WAD = 1e18;
    uint256 constant WAD2 = 1e9;
    int24 constant MIN_TICK = -887272;
    int24 constant MAX_TICK = 887272;
    uint16 constant K = 10000;
    uint256 constant Q96 = 2**96;
    uint256 constant Q48 = 2**48;
    uint256 constant Q24 = 2**24;
    address internal constant NON_FUNGIBLE_POS_MANAGER = 0xC36442b4a4522E871399CD717aBDD847Ab11FE88;

    function createPosition(address pool, uint256 amount0Desired, uint256 amount1Desired, uint16 width, uint256 deadline) external returns (
            uint256 tokenId,
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        ) {
            require(width >= 0 && width <= 10000, "width");
/*
            IUniswapV3Pool pool = IUniswapV3Pool(pool);
            (  
                uint160 sqrtPriceX96,  
                int24 tick,  
                ,  
                ,  
                ,  
                ,  
                  
            )  = pool.slot0();
            console.log("tick:", tick);
            console.log("sqrtPriceX96:", sqrtPriceX96);
*/
            //INonfungiblePositionManager _manager = INonfungiblePositionManager(NON_FUNGIBLE_POS_MANAGER);

            //INonfungiblePositionManager.MintParams memory params;
            // _params.token0 = _pool.token0();
            // _params.token1 = _pool.token1();
            // _params.fee = _pool.fee();
            // _params.recipient = 0xB0b12f40b18027f1a2074D2Ab11C6e0d6c6acbB5;
            // _params.amount0Desired = amount0Desired;
            // _params.amount1Desired = amount1Desired;
            // _params.deadline = deadline;
            
            // return _manager.mint(_params);

            return (0, 0, 0, 0);
    }

    function calculate(uint256 x, uint256 y, uint16 width, uint160 sqrtPriceX96) external returns (
        int24 tickLower,
        int24 tickUpper
    ) {

        console.log("Q96:", Q96);
        //console.log("sqrt:", FixedPointMathLib.sqrt(10*WAD));

        require (x > 0 && y > 0, "token amounts must be non-zero");
        require (width < K, "w must be less than k");

        uint256 a_fp = ((width + K) * WAD) / (K - width);
        /* a is in range [0;19999] before WAD multiply 
        */

        uint256 b_fp = (x*sqrtPriceX96*WAD)/Q96;

        console.log("a_fp:", a_fp);
        console.log("b_fp:", b_fp);

        uint256 max = 2**256-1;
        console.log("max:", max);

        uint256 sqrtPriceHighX96 = this.solveQuadratic(a_fp, b_fp, sqrtPriceX96, y);
    }

    function solveQuadratic(uint256 a_fp, uint256 b_fp, uint160 sqrtPriceX96, uint256 y) external returns (
        uint256 sqrtPriceHighX96
    ) {
        console.log("y:", y);

        uint256 sqrt_a_fp = FixedPointMathLib.sqrt(a_fp)*WAD2;
        console.log("sqrt_a_fp:", sqrt_a_fp);

        uint256 sqrtPriceX96Int = sqrtPriceX96;

        int256 A_fp = int256(b_fp);
        console.log("+A_fp:", A_fp);
        
        int256 B_fp = int256(sqrt_a_fp*y) - int256(((sqrt_a_fp*b_fp) / WAD) * sqrtPriceX96 / Q96);
        console.log("+B_fp:", B_fp);

        int256 C_fp = -int256(sqrt_a_fp)*int256(sqrtPriceX96Int)*int256(y)/int256(Q96);       
        console.log("+C_fp:", C_fp);

        int256 discriminant_fp = int256(uint256(B_fp**2) / WAD) - 4*A_fp*C_fp/int256(WAD);
        console.log("+discriminant_fp:", discriminant_fp);
        require (discriminant_fp >= 0, "must be real roots");

        int256 d_square_fp = int256(FixedPointMathLib.sqrt(uint256(discriminant_fp))) * int256(WAD2);

        int256 z1 = int256(WAD) * (-B_fp + d_square_fp) / 2 / A_fp;
        int256 z2 = int256(WAD) * (-B_fp - d_square_fp) / 2 / A_fp;
        console.log("z1: ", z1);
        console.log("z2: ", z2);

        require (z1 > 0 || z2 > 0, "must be positive solution");

        if (z1 > 0) {
            require (z1 <= 2**160-1, "z1");
            sqrtPriceHighX96 = uint256(z1);
        }
        else {
            require (z2 <= 2**160-1, "z2");
            sqrtPriceHighX96 = uint256(z2);
        }

        sqrtPriceHighX96 = (sqrtPriceHighX96 * Q96) / WAD;

        console.log("sqrtPriceHighX96", sqrtPriceHighX96);
    }
}
