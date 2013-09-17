#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "$1" ]
then
	echo Usage: $0 patchdir >&2
	exit 1
fi

patchdir=$1

if [ ! -d "$patchdir" ]
then
	echo $0: Error: Directory not found: $patchdir >&2
	exit 2
fi

PATCHES=$(find $patchdir -type f -size +1 -regextype posix-extended -iregex '.*(patch|diff)')

if [ -z "$PATCHES" ]
then
	echo $0: Error: no patches found in $patchdir >&2
	exit 3
fi

module=$(basename $patchdir)

if [ ! -f "lib/modules/source/$module.tar" ]
then
	echo $0: Error: File not found: lib/modules/source/$module.tar >&2
	exit 4
fi

pushd lib/modules/source >/dev/null

	if [ ! -f "$module.tar.orig" ]
	then
	  cp -p $module.tar $module.tar.orig
	fi

	rm -rf $module-only

	tar xf $module.tar

	pushd $module-only >/dev/null

		for patch in $PATCHES
		do
			base=$(basename $patch)
			dir=$(basename $(dirname $patch))
			echo -e "--- Applying $dir/$base ...\n"
			patch --batch --strip=1 --ignore-whitespace --force < $patch
			echo
		done

	popd >/dev/null

	tar cf $module.tar $module-only

#	rm -rf $module-only

popd >/dev/null
