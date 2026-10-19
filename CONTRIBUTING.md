# Contributing

The index of kits for Orblit.

To list a kit, add an entry file and open a pull request. The
[README](README.md) says how. Talk about anything larger first, in an issue
or on the [Discord](https://discord.gg/5DH7HuDUtJ). The builder lives in
[ChxisB/orblit](https://github.com/ChxisB/orblit), in `packages/orblit_asset`.

## Checking your work

```sh
./tool/link_local.sh   # point at a local orblit checkout
./tool/check.sh
```

`check.sh` downloads every release and builds the index into a scratch
folder. It lists every problem at once.

## Commits

Each commit on a pull request is checked by commitlint. The subject is an
imperative of 72 characters or fewer with no full stop. The body wraps at 72.

## Licence

This repository is under MPL-2.0. Opening a pull request means you are
offering your change under that same licence, and that you wrote it or
otherwise have the right to contribute it.

There is no CLA to sign and no copyright to assign. You keep the copyright on
what you write. It is simply licensed the same way as the rest of the
repository.

The kit a pull request lists keeps its own licence. Only list a kit you may
share under the licence its `kit.json` names.
