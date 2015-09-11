#!/usr/bin/env bash

# compile and install VMware Tools

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -d vmware-tools-distrib ]]; then
  echo $0: Error: Directory not found: vmware-tools-distrib >&2
  exit 3
fi

if hash vmware-uninstall-tools.pl >/dev/null 2>&1; then
  sudo vmware-uninstall-tools.pl
fi

if [[ -e /etc/redhat-release ]]; then
	if hash yum >/dev/null 2>&1; then
		sudo yum -y install unzip patch gcc glibc-headers kernel-devel kernel-headers make perl
	fi
fi

if [[ -e /etc/debian_version ]]; then
	if hash apt-get >/dev/null 2>&1; then
		sudo apt-get install -y build-essential dkms linux-headers-$(uname -r) patch perl psmisc
	fi
fi

VMWARE_INSTALL_OPTIONS="--clobber-kernel-modules=pvscsi,vmblock,vmci,vmhgfs,vmmemctl,vmsync,vmxnet,vmxnet3,vsock"

if [[ -n "$1" ]]; then
	VMWARE_INSTALL_OPTIONS="$1"
fi

pushd vmware-tools-distrib >/dev/null

  sudo ./vmware-install.pl -d ${VMWARE_INSTALL_OPTIONS}

popd >/dev/null
