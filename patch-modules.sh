#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v patch >/dev/null 2>&1
then
	echo $0: Command not found: patch >&2
	exit 1
fi

MODULES=$(find $SCRIPT_DIR/patches -mindepth 1 -maxdepth 1 -type d)

for module in $MODULES
do
	PATCHES=$(find $module -type f -size +1 -regextype posix-extended -iregex '.*\.(patch|diff)')

	if [ "$PATCHES" ]
	then
		$SCRIPT_DIR/patch-module.sh $module
	fi
done
