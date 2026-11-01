#!/bin/bash
# Runs the engine's kit tool from a sibling checkout, so the index can be
# built before an engine change is pushed. ORBLIT_ENGINE names another path.
set -euo pipefail

ENGINE=${ORBLIT_ENGINE:-"$(dirname "$0")/../../orblit"}
KIT="$ENGINE/dotnet/Orblit.Kit"

if [ ! -f "$KIT/Orblit.Kit.csproj" ]; then
  echo "No engine checkout at $ENGINE."
  echo "Clone ChxisB/orblit beside this one, or set ORBLIT_ENGINE."
  exit 1
fi

exec dotnet run --project "$KIT" -c Release -- "$@"
