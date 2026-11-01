#!/bin/bash
# Builds the index into a folder that does not exist yet. Downloads every
# release the entries list, so it needs a network.
set -euo pipefail
cd "$(dirname "$0")/.."

OUT=${1:-site}
./tool/kit.sh index kits -o "$OUT"
