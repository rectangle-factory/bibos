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

To render a new Bibo with tokenUri, metadata, traits, and svg to `output`.

```[bash]
pnpm render
```

---

## Inspector

To run the inspector app, start the express server in one terminal instance
`[bash]pnpm run start-server`
and run the inspector app in another terminal instance
`[bash]pnpm run start-inspector`.
Navigate to `localhost:3000` in your browser.
