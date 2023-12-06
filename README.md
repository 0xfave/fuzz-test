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


## Run Locally

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

## Tech Stack

**Unit Test:** Foundry

**Fully automated analysis:** Slither, Aderyn

**Semi automated analysis Stateful Fuzzing:** Echidna, Foundry Invariant

**Formal Verification:** [Halmos](https://github.com/a16z/halmos/blob/main/docs/getting-started.md)
