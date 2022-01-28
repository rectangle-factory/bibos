# Bibos

## Development

### Install

Install [Foundry](https://github.com/gakonst/foundry/).
`npm install` for prettier.

For git submodules:

```[bash]
    git submodule init
    git submodule update
```

Install `jq` with `brew install jq`

---

### Test

```[bash]
forge test --ffi --force
```

Seems we need `--force`, otherwise the tokenUri won't update. Use `--block-timestamp` if you want to change the timestamp that is used to compute the token data.

---

### Build

```[bash]
forge build
```
