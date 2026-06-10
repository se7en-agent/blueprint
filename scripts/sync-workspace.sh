#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
blueprint_root="$(cd -- "${script_dir}/.." && pwd)"
workspace_root="${WORKSPACE_ROOT:-$(cd -- "${blueprint_root}/../.." && pwd)}"
destination="${blueprint_root}/workspace"

if ! command -v rsync >/dev/null 2>&1; then
  echo "rsync is required for workspace sync" >&2
  exit 1
fi

if [ ! -d "${workspace_root}" ]; then
  echo "workspace root does not exist: ${workspace_root}" >&2
  exit 1
fi

mkdir -p "${destination}"

rsync -a --delete \
  --exclude '/repos/' \
  --exclude '/projects/' \
  --exclude '/gogetajob-data/' \
  --exclude '/finance/' \
  --exclude '/memory/.dreams/' \
  --exclude '/tmp/' \
  --exclude '/.git/' \
  --exclude '/.env' \
  --exclude '/*.sqlite' \
  --exclude '/*.sqlite-*' \
  "${workspace_root}/" "${destination}/"

echo "Synced ${workspace_root} -> ${destination}"
