#!/usr/bin/env bash

# apply patches for all modules

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

modules="$(find ${SCRIPT_DIR}/patches -mindepth 1 -maxdepth 1 -type d)"

for module in ${modules}; do
  patches="$(find ${module} -type f -size +1c -regextype posix-extended -iregex '.*\.(patch|diff)')"

  if [[ -n "${patches}" ]]; then
    "${SCRIPT_DIR}/patch-module.sh" "${module}"
  fi
done
