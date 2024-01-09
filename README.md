# Fuzz Test

This repo holds all the projects I will be learning Fuzz Test on. 
I will be picking a Live project and write a Uint & Fuzz Test
My major focus is on projects building on 🐴Uniswap protocol

## Projects

Here are the protocols I wrote test for:

- [Arrakis](https://www.arrakis.finance/) - [github](https://github.com/ArrakisFinance/v2-core)


## 🚀 About Me
Blockchain developer specialise in security
-----------------------------------------------------

*   🔐 Smart Contract Auditor | Solidity
*   👨‍🔬 Blockchain Engineer
*   📫 You can reach me for consulting, stateful fuzz test and audits on [X](https://twitter.com/0xFave), [Cantina](https://cantina.xyz/u/0xfave), [C4](https://code4rena.com/@0xfave)
*   🤝  I'm open to collaborating on Smart contract development and Audits
*   ⚡  I love working on AMMs, Protocols built on Uniswap Concentrated Liquidity MM, Intent Centric Protocols

## Acknowledgements

 - [echidna tutorial from TOB](https://github.com/crytic/echidna-streaming-series)


## Thought Process
1. Understand what the invariants are
2. Write functions tht can execute them


## Usage

This is a list of the most frequently needed commands.

### Build

Build the contracts:

```sh
$ forge build
```

### Clean

Delete the build artifacts and cache directories:

```sh
$ forge clean
```

### Compile

Compile the contracts:

```sh
$ forge build
```

### Coverage

Get a test coverage report:

```sh
$ forge coverage
```

### Deploy

Deploy to Anvil:

```sh
$ forge script script/Deploy.s.sol --broadcast --fork-url http://localhost:8545
```

For this script to work, you need to have a `MNEMONIC` environment variable set to a valid
[BIP39 mnemonic](https://iancoleman.io/bip39/).

For instructions on how to deploy to a testnet or mainnet, check out the
[Solidity Scripting](https://book.getfoundry.sh/tutorials/solidity-scripting.html) tutorial.

### Format

Format the contracts:

```sh
$ forge fmt
```

### Gas Usage

Get a gas report:

```sh
$ forge test --gas-report
```

### Lint

Lint the contracts:

```sh
$ bun run lint
```

### Test

Run the tests:

```sh
$ forge test
```

Generate test coverage and output result to the terminal:

```sh
$ bun run test:coverage
```

Generate test coverage with lcov report (you'll have to open the `./coverage/index.html` file in your browser, to do so
simply copy paste the path):

```sh
$ bun run test:coverage:report
```

## Tech Stack

**Unit Test:** Foundry

**Fully automated analysis:** Slither, Aderyn

**Semi automated analysis Stateful Fuzzing:** Echidna, Foundry Invariant

**Formal Verification:** [Halmos](https://github.com/a16z/halmos/blob/main/docs/getting-started.md)
