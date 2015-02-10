#!/usr/bin/env bash

# download selected vmware tools patch files

set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WGET="wget --no-check-certificate"

URLS="
vmblock,https://sites.google.com/site/mysticalzerotmp/vmblock.3.10.patch
vmblock,https://sites.google.com/site/mysticalzerotmp/vmblock.3.11.patch
vmhgfs,https://raw.github.com/misheska/basebox-packer/master/template/misheska-ubuntu1204/floppy/vmtools.inode.c.patch
vmhgfs,https://raw.github.com/misheska/basebox-packer/master/template/misheska-ubuntu1204/floppy/vmware9.compat_mm.patch
vmci,https://raw.github.com/misheska/basebox-packer/master/template/misheska-ubuntu1204/floppy/vmware9.k3.8rc4.patch
"

pushd patches

  for modurl in ${URLS}; do
    mod="${modurl%%,*}"
    url="${modurl#*,}"

    pushd "${mod}"

      file="$(basename ${url})"

      if [[ -f "$file" ]]; then
        continue
      fi

      ${WGET} "${url}"

      if [[ "${file}" = "vmware9.compat_mm.patch" ]]; then
        perl -pi.bak -e 's|(vmware9.compat_mm.patch)|shared/\1|;' "${file}"
      fi

    popd

  done

popd
