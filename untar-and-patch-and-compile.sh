#!/usr/bin/env bash

# untar a single VMwareTools .tar.gz file, and apply patches for all modules, and compile

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! hash patch >/dev/null 2>&1; then
  echo $0: Command not found: patch >&2
  exit 1
fi

tool="$1"

if [[ -z "${tool}" ]]; then
  tool="$(find -type f -name 'VMwareTools-*.tar.gz' | sort -nr | head -n 1)"
fi

if [[ -z "${tool}" ]]; then
  echo Usage: $0 tarname >&2
  exit 1
fi

if [[ ! -f "${tool}" ]]; then
  echo $0: Error: File not found: ${tool} >&2
  exit 2
fi

rm -fr vmware-tools-distrib

echo -e "=== Patching ${tool} ...\n"

tar xzf "${tool}"

if [[ ! -d vmware-tools-distrib ]]; then
  echo $0: Error: Directory not found: vmware-tools-distrib >&2
  exit 3
fi

if hash vmware-uninstall-tools.pl >/dev/null 2>&1; then
  sudo vmware-uninstall-tools.pl
fi

if hash apt-get >/dev/null 2>&1; then
  sudo apt-get install -y linux-headers-$(uname -r) build-essential dkms psmisc
fi

pushd vmware-tools-distrib >/dev/null

  "${SCRIPT_DIR}/patch-modules.sh"

  sudo ./vmware-install.pl -d --clobber-kernel-modules=pvscsi,vmblock,vmci,vmhgfs,vmmemctl,vmsync,vmxnet,vmxnet3,vsock

popd >/dev/null

if [[ -z "$DONT_CLEAN" ]]; then
  rm -fr vmware-tools-distrib
fi
