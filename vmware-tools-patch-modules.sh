#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PATCHDIRS=$(find $SCRIPT_DIR/patches -mindepth 1 -maxdepth 1 -type d)

for patchdir in $PATCHDIRS
do
	PATCHES=$(find $patchdir -type f -size +1 -regextype posix-extended -iregex '.*(patch|diff)')

	if [ "$PATCHES" ]
	then
		$SCRIPT_DIR/vmware-tools-patch-module.sh $patchdir
	fi
done
