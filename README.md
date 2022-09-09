# Bibos

![Some bibos](header.png)

## Introduction

No one remembers where bibos came from, but one things for sure - they are implemented as a set of Solidity contracts which deliver animated, on-chain SVG bibos to your wallet. For now, this repo includes the inspector tool as well.

## Development

---

### Install

Install [Foundry](https://github.com/gakonst/foundry/).
Run `foundryup` to update to nightly builds.

This project uses [pnpm](https://pnpm.io/) for maximum javascript acceleration.

To install dependences:

```[bash]
pnpm i
```

To install submodules:

```[bash]
forge install
```

For some scripts, you will need the `jq` JSON utility. To install on MacOS, run `brew install jq`.

---

### Test

To run forge tests:

```[bash]
forge test
```

---

### Bibos Local Inspector

The Bibos Local Inspector is a local web interface which allows you to:

- generate and view random Bibos from the contract
- inspect the underlying SVG code

To use:

```[bash]
pnpm dev
```
