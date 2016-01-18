#!/usr/bin/env bash

# untar a single VMwareTools-*.tar.gz file

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

tool="$1"

if [[ -z "${tool}" ]]; then
  tool="$(find -type f -name 'VMwareTools-*.tar.gz' | sort -nr -t - -k 2 | head -n 1)"
fi

if [[ -z "${tool}" ]]; then
  echo Usage: $0 tarname >&2
  exit 1
fi

if [[ ! -f "${tool}" ]]; then
  echo $0: Error: File not found: ${tool} >&2
  exit 2
fi

echo $(basename "$0"): Patching ${tool}

rm -fr vmware-tools-distrib

echo -e "=== Patching ${tool} ...\n"

tar xzf "${tool}"

if [[ ! -d vmware-tools-distrib ]]; then
  echo $0: Error: Directory not found: vmware-tools-distrib >&2
  exit 3
fi
