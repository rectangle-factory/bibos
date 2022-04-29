# Bibos

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

### Render New Bibo

To render a new Bibo with tokenUri, metadata, traits, and svg to `output`.

```[bash]
pnpm render
```

---

## Inspector

To run the inspector app,
`[bash]pnpm run dev`, and
navigate to `localhost:3000`.
