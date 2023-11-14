
# Fuzz Test

This repo holds all the projects I will be learning Fuzz Test on. 

I will be picking a Live project and write a Uint & Fuzz Test

## Projects

Here are the protocols I wrote test for:

- [Company 1]()


## 🚀 About Me
Blockchain developer specialise in Blockhain security
-----------------------------------------------------

*   🔐 Smart Contract Auditor | Solidity
*   👨‍🔬 Blockchain Engineer
*   📫 You can reach me for consulting and audits on [X](https://twitter.com/0xFave), [Cantina](https://cantina.xyz/u/0xfave), [C4](https://code4rena.com/@0xfave)
*   🤝  I'm open to collaborating on Smart contract development and Audits
*   ⚡  I love working on AMMs, DEXs, Perpetual Dex, Intent Centric Protocols
## Acknowledgements

 - [echidna tutorial from TOB](https://github.com/crytic/echidna-streaming-series)


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
## Tech Stack

**Unit Test:** Foundry

**Fully automated analysis:** Slither, Aderyn

**Semi automated analysis:** Echidna