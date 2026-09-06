#!/bin/sh

set -eu

root_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
reference_dir="${root_dir}/.references/DtBlkFx"
upstream_url="https://codeberg.org/skullzy/DtBlkFx.git"
default_upstream_ref="1506e444702d0da0f28fb3b813b88019e5a1dbc0"

upstream_ref=${DTBLKFX_UPSTREAM_REF:-${default_upstream_ref}}

mkdir -p "${root_dir}/.references"

if [ -d "${reference_dir}/.git" ]; then
  git -C "${reference_dir}" fetch --depth 1 origin "${upstream_ref}"
else
  git clone --depth 1 "${upstream_url}" "${reference_dir}"
  git -C "${reference_dir}" fetch --depth 1 origin "${upstream_ref}"
fi

git -C "${reference_dir}" checkout --detach "${upstream_ref}"

printf 'Upstream reference: %s\n' "${upstream_url}"
printf 'Checked-out revision: '
git -C "${reference_dir}" rev-parse HEAD
printf 'Reference path (ignored): %s\n' "${reference_dir}"
