# orblit-kits

The index of kits for [Orblit](https://github.com/ChxisB/orblit).

A kit is one file of assets that a person installs into a project, such as a
set of crates, a tileset or a script. Authors host their own kit files over
https. This repository lists them. Each kit has one entry file that says
where each version lives and what its hash is. CI downloads every release,
checks it and publishes the index.

## Add a kit

1. Pick the https address the kit file will be hosted at. One command packs
   the kit, checks the file and writes the entry with the hash and size.

   ```sh
   dart run orblit_asset:kit publish my-kit \
     --url https://example.com/my-kit-1.0.0.opack \
     --entries kits --notes "The first release."
   ```

   Run it in a clone of this repository, so `--entries kits` writes
   `kits/<publisher>/<slug>.json`. The publisher and the slug are the ones in
   the kit's `kit.json`. A version that is listed already is refused, so
   raise `version` in `kit.json` for a new release.
2. Upload `my-kit-1.0.0.opack`, the file `publish` wrote, so that it is
   served at that address.
3. Run `./tool/check.sh`. It downloads the file and lists every problem.
4. Open a pull request. CI builds the index and lists every problem it
   finds.

The editor does the first step too. Open Scene › Publish kit, name a folder of
your project and the address, and copy the entry it shows into
`kits/<publisher>/<slug>.json`.

You can also write the entry by hand, as the next section shows. Use the hash
that `kit pack` prints.

## The entry

```json
{
  "releases": [
    {
      "version": "1.1.0",
      "url": "https://example.com/crate-pack-1.1.0.opack",
      "hash": "0f3a...64 hexadecimal digits...9c1d",
      "bytes": 48213,
      "released": "2026-10-19",
      "notes": "Adds an open crate."
    }
  ]
}
```

| Key | What it is |
| --- | --- |
| `version` | Three whole numbers, such as `1.1.0`. A version is listed once. |
| `url` | An https address of the kit file, up to 300 characters, at a public host name. No IP address, `localhost`, port, space, `\`, `#` or `@`. |
| `hash` | The hash `kit pack` printed. It is the hash of the pack. |
| `bytes` | The size of the kit file. |
| `released` | The day the version came out, as `2026-10-19`. |
| `notes` | One line about what changed. Optional. |

The file holds `releases` and no other key. The name, summary, licence and
previews come from the `kit.json` inside the latest release, so they cannot
disagree with the kit.

A release that is listed is not edited. Add a new version instead. To
withdraw a release, delete it from the list.

## What CI checks

For every release of every entry:

- the file downloads from the url within ten minutes, up to the size the
  entry gives;
- the file is the size and has the hash the entry says;
- every file inside has the hash the kit lists;
- the kit passes the rules of `kit check`: names a person can safely write,
  a licence, and the limits on size and count;
- the `kit.json` inside names the same publisher, slug and version as the
  entry.

Previews come from the latest release only. A preview is at most 1 MiB and
starts like a png, jpg or webp image.

## What it builds

```
index.json
kits/<publisher>/<slug>/releases.json
kits/<publisher>/<slug>/preview-0.png
```

`index.json` has one row for each kit. A row says whether the kit holds
scripts. GitHub Pages serves the folder at
`https://chxisb.github.io/orblit-kits/`, and the Orblit site rewrites
`/store/` to it.

Build it yourself:

```sh
git clone https://github.com/ChxisB/orblit.git     # beside this one
./tool/link_local.sh                                 # point at that checkout
./tool/check.sh                                      # build into a scratch folder
./tool/build.sh site                                 # build into ./site
```

The build downloads every release each time, so it needs a network.

## Licence

MPL-2.0, © 2026 Chris Beckett. See [LICENSE](LICENSE). The entries here only
point at kits. Each kit keeps the licence its `kit.json` names.
