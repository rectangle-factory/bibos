# Bibos

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

For submodules:

```[bash]
forge update
```

For the render scripts, you'll need `jq`. Install `brew install jq`.

---

### Test

```[bash]
pnpm test
```

---

### Render New Bibo

```[bash]
pnpm render
```
