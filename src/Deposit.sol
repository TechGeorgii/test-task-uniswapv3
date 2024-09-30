// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./lib/TickMath.sol";
import "./lib/interfaces/INonfungiblePositionManager.sol";
import "./lib/interfaces/IUniswapV3Pool.sol";
import {console} from "forge-std/console.sol";

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

    int24 min_tick = -887272;
    int24 max_tick = 887272;
    address internal constant NON_FUNGIBLE_POS_MANAGER = 0xC36442b4a4522E871399CD717aBDD847Ab11FE88;

    function createPosition(address pool, uint256 amount0Desired, uint256 amount1Desired, uint16 width, uint256 deadline) external returns (
            uint256 tokenId,
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        ) {
            require(width >= 0 && width <= 10000, "width");

            IUniswapV3Pool _pool = IUniswapV3Pool(pool);
            (  
                uint160 sqrtPriceX96,  
                int24 tick,  
                ,  
                ,  
                ,  
                ,  
                  
            )  = _pool.slot0();
            console.log("tick:", tick);
            console.log("sqrtPriceX96:", sqrtPriceX96);

            //INonfungiblePositionManager _manager = INonfungiblePositionManager(NON_FUNGIBLE_POS_MANAGER);

            // INonfungiblePositionManager.MintParams memory _params;
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
}

