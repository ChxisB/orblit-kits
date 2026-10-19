# orblit-kits

The index of kits for [Orblit](https://github.com/ChxisB/orblit).

A kit is one file of assets that a person installs into a project, such as a
set of crates, a tileset or a script. Authors host their own kit files over
https. This repository lists them. Each kit has one entry file that says
where each version lives and what its hash is. CI downloads every release,
checks it and publishes the index.

## Add a kit

1. Pack the kit and note the hash it prints.

   ```sh
   dart run orblit_asset:kit pack my-kit -o my-kit-1.0.0.opack
   ```

2. Host the file at an https address. A GitHub release works, and so does
   any server that sends the file. A redirect is fine, because the hash is
   what is trusted.
3. Add `kits/<publisher>/<slug>.json`. The publisher and the slug are the
   ones in the kit's `kit.json`.
4. Open a pull request. CI builds the index and lists every problem it
   finds.

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
| `url` | An https address of the kit file, up to 300 characters. |
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

- the file downloads from the url, up to 1040 MiB;
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
