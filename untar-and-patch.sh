#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v patch >/dev/null 2>&1
then
	echo $0: Command not found: patch >&2
	exit 1
fi

tool=$1

if [ -z "$tool" ]
then
	tool=$(find -type f -name 'VMwareTools-*.tar.gz' | sort -nr | head -n 1)
fi

if [ -z "$tool" ]
then
	echo Usage: $0 tarname >&2
	exit 1
fi

if [ ! -f "$tool" ]
then
	echo $0: Error: File not found: $tool >&2
	exit 2
fi

export VMWARE_TOOLS_VER=$(echo $tool | cut -d'-' -f 2)

export VMWARE_TOOLS_MAJ_VER=$(echo $VMWARE_TOOLS_VER | cut -d'.' -f 1)
export VMWARE_TOOLS_MIN_VER=$(echo $VMWARE_TOOLS_VER | cut -d'.' -f 2)
export VMWARE_TOOLS_REV_VER=$(echo $VMWARE_TOOLS_VER | cut -d'.' -f 3)

rm -fr vmware-tools-distrib

echo -e "=== Patching $tool ...\n"

tar xzf $tool

if [ ! -d vmware-tools-distrib ]
then
	echo $0: Error: Directory not found: vmware-tools-distrib >&2
	exit 3
fi

pushd vmware-tools-distrib >/dev/null

	$SCRIPT_DIR/patch-modules.sh

popd >/dev/null

test "$DONT_CLEAN" ||
	rm -fr vmware-tools-distrib
