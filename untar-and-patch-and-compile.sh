#!/usr/bin/env bash

# untar a single VMwareTools .tar.gz file, apply patches for all modules, and compile and install VMware Tools

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"${SCRIPT_DIR}/untar-and-patch.sh" "$1"

shift

"${SCRIPT_DIR}/compile.sh" $*
