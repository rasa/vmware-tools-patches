#!/usr/bin/env bash

# untar a single VMwareTools-*.tar.gz file, and apply patches for all modules

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"${SCRIPT_DIR}/untar.sh" "$1"

"${SCRIPT_DIR}/patch.sh"
