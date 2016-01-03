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


VMWARE_INSTALL_OPTIONS="--clobber-kernel-modules=pvscsi,vmblock,vmci,vmhgfs,vmmemctl,vmsync,vmxnet,vmxnet3,vsock"

if [[ -n "$1" ]]; then
	VMWARE_INSTALL_OPTIONS="$1"
fi

pushd vmware-tools-distrib >/dev/null

if sudo ./vmware-install.pl --help 2>&1 | grep -q 'force-install'; then
    VMWARE_INSTALL_OPTIONS="--force-install ${VMWARE_INSTALL_OPTIONS}"
fi

sudo ./vmware-install.pl --default ${VMWARE_INSTALL_OPTIONS}

popd >/dev/null

if hash systemctl >/dev/null 2>&1; then
  sudo cp $SCRIPT_DIR/patches/vmware-tools.service /etc/systemd/system/
  sudo systemctl enable vmware-tools.service
fi
