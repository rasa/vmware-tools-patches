#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

tool=$1

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

if "$(command -v vmware-uninstall-tools.pl)"
then
	sudo vmware-uninstall-tools.pl
fi

rm -fr vmware-tools-distrib

echo -e "=== Patching $tool ...\n"

tar xzf $tool

pushd vmware-tools-distrib >/dev/null

	$SCRIPT_DIR/vmware-tools-patch-modules.sh

	sudo ./vmware-install.pl -d --clobber-kernel-modules=vmci,vmxnet3,pvscsi,vmmemctl,vsock,vmhgfs,vmxnet

popd >/dev/null

test "$DONT_CLEAN" ||
	rm -fr vmware-tools-distrib
