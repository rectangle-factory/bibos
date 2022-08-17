# Bibos

![Some bibos](header.png)

## Introduction

No one remembers where bibos came from, but one things for sure - they are implemented as a set of Solidity contracts which deliver animated, on-chain SVG bibos to your wallet. For now, this repo includes the inspector tool as well.

## Development

---

### Install

Install [Foundry](https://github.com/gakonst/foundry/).
Run `[bash]foundryup` to update to nightly builds.

This project uses [pnpm](https://pnpm.io/) for maximum javascript acceleration.

To install dependences:

```[bash]
pnpm i
```

For submodules:

```[bash]
forge update
```

For some scripts, you might need `jq` JSON utility. To install run `[bash]brew install jq`.

---

### Test

```[bash]
pnpm test
```

---

### Bibos Local Deployment + Inspector

1. Run `anvil` in one terminal instance.
2. Run `pnpm run deploy-anvil` in another. This deploys all the libraries, and Bibos.
3. Run `pnpm run dev`, for the frontend. Navigate to `localhost:3000` in your browser.
