#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if [[ ! -f paper.jar ]]; then
  echo "Once ./setup.sh calistir." >&2
  exit 1
fi
exec java -Xms4G -Xmx6G -jar paper.jar --nogui
