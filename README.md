# Bibos

## Development

### Install

Install [Foundry](https://github.com/gakonst/foundry/).
Run `foundryup` to update to nightly builds.

Run `yarn install` or `npm install` for prettier.

For submodules:

```[bash]
    forge update
```

Install `jq` with `brew install jq`

---

### Test

`yarn run test` or

```[bash]
forge test --ffi --force
```

Use `--block-timestamp` if you want to change the timestamp that is used to compute the token data.

---

### Build

```[bash]
forge build
```
