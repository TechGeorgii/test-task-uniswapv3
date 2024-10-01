# Concentrated liquidity deposit contract

The idea is to implement a smart contract that deposits any amount of `token0` and `token1` in a specified 
Uniswap V3 Liquidity Pool. Also, a `width` parameter is specified, that is calculated as
`width = (upperPrice - lowerPrice) * 10000 / (lowerPrice + upperPrice)`, where `lowerPrice` and `upperPrice` are 
lower and upper price bounds for a liquidity position.

# Useful commands

To run tests on Optimism chain:
`forge test -vv -w --rpc-url RPC_URL --chain 137`

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
