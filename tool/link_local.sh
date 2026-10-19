#!/bin/bash
# Points this repository at a sibling engine checkout instead of the git
# dependency, so the index can be built before the engine change is pushed.
# The override is not committed.
set -euo pipefail
cd "$(dirname "$0")/.."

ENGINE=${1:-../orblit}
ASSET="$ENGINE/packages/orblit_asset"

if [ ! -f "$ASSET/pubspec.yaml" ]; then
  echo "No engine checkout at $ENGINE."
  echo "Clone ChxisB/orblit beside this one, or pass its path."
  exit 1
fi

cat > pubspec_overrides.yaml <<YAML
# Written by tool/link_local.sh. Not committed.
dependency_overrides:
  orblit_asset:
    path: $(cd "$ASSET" && pwd)
YAML

dart pub get > /dev/null
echo "orblit_kits -> $(cd "$ASSET" && pwd)"
