#!/usr/bin/env bash

# apply patches for all modules

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! hash patch >/dev/null 2>&1; then
  echo $0: Command not found: patch >&2
  exit 1
fi

modules="$(find ${SCRIPT_DIR}/patches -mindepth 1 -maxdepth 1 -type d)"

for module in ${modules}; do
  patches="$(find ${module} -type f -size +1 -regextype posix-extended -iregex '.*\.(patch|diff)')"

  if [[ "${patches}" ]]; then
    "${SCRIPT_DIR}/patch-module.sh" "$module"
  fi
done
