#!/bin/bash
# Builds the index into a scratch folder. A bad entry, a wrong hash, a missing
# licence or a kit that breaks a rule fails here, with every problem listed.
set -uo pipefail
cd "$(dirname "$0")/.."

scratch=$(mktemp -d)
trap 'rm -rf "$scratch"' EXIT

if ./tool/build.sh "$scratch/site" > "$scratch/build.log" 2>&1; then
  echo "  ok    $(tail -1 "$scratch/build.log")"
  echo
  echo "everything green"
else
  echo "  FAIL  index"; cat "$scratch/build.log"
  echo
  echo "1 failing step(s)"
  exit 1
fi
