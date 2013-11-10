#!/usr/bin/env bash

# untar all VMwareTools-*.tar.gz files found, and apply patches for all modules for each one

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

dir="${1:-$(pwd)}"

tools="$(find "${dir}" -type f -name 'VMwareTools-*.tar.gz' | sort -r)"

if [[ -z "${tools}" ]]; then
  echo "$0: No files matching VMwareTools-*.tar.gz found in '${dir}'" >&2
  exit 1
fi

for tool in ${tools}; do
  "${SCRIPT_DIR}/untar-and-patch.sh" "${tool}"
done
