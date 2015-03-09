#!/usr/bin/env bash

# apply patches for all modules

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

modules="$(find ${SCRIPT_DIR}/patches -mindepth 1 -maxdepth 1 -type d)"

for module in ${modules}; do
  "${SCRIPT_DIR}/patch-module.sh" "${module}"
done

if [[ "${VMWARE_TOOLS_PATCHES_DEBUG-}" =~ (pause|PAUSE) ]]; then
  read -p "Press [Enter] to continue: "
fi
