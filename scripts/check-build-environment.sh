#!/bin/sh

set -eu

missing=0

require_command() {
  command_name=$1
  if command -v "${command_name}" >/dev/null 2>&1; then
    printf '%-12s %s\n' "${command_name}" "$(command -v "${command_name}")"
  else
    printf '%-12s MISSING\n' "${command_name}"
    missing=1
  fi
}

printf '%s\n' 'DtBlkFx build environment'
printf '%s\n' '========================='
printf 'Host architecture: %s\n' "$(uname -m)"
require_command xcrun
require_command clang
require_command cmake
require_command make

if sdk_path=$(xcrun --sdk macosx --show-sdk-path 2>/dev/null); then
  printf 'macOS SDK:      %s\n' "${sdk_path}"
else
  printf '%s\n' 'macOS SDK:      MISSING (Xcode Command Line Tools or Xcode required)'
  missing=1
fi

if command -v pkg-config >/dev/null 2>&1; then
  printf 'pkg-config:     %s\n' "$(pkg-config --version)"
  if pkg-config --exists fftw3f; then
    printf 'FFTW3f:         %s (%s)\n' "$(pkg-config --modversion fftw3f)" "$(pkg-config --libs fftw3f)"
  else
    printf '%s\n' 'FFTW3f:         not found (required only when DTBLKFX_ENABLE_FFTW=ON)'
  fi
else
  printf '%s\n' 'pkg-config:     not installed (optional until FFTW3f is enabled)'
fi

if [ "$(uname -m)" != "arm64" ]; then
  printf '%s\n' 'WARNING: host is not arm64; use an Apple Silicon runner for release validation.'
fi

if [ "${missing}" -ne 0 ]; then
  exit 1
fi

printf '%s\n' 'Required command-line tools are available.'
