#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v patch >/dev/null 2>&1
then
	echo $0: Command not found: patch >&2
	exit 1
fi

dir="${1:-$(pwd)}"

TOOLS=$(find "$dir" -type f -name 'VMwareTools-*.tar.gz' | sort -r)

if [ -z "$TOOLS" ]
then
	echo "$0: No files matching VMwareTools-*.tar.gz found in '$dir'" >&2
	exit 1
fi

for tool in $TOOLS
do
	$SCRIPT_DIR/untar-and-patch.sh $tool
done
