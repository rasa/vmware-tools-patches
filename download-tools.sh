#!/usr/bin/env bash

# download selected vmware tools files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WGET="wget --no-check-certificate"

URLS="
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.0.1/2235595/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.0.0/2075534/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.3/1747349/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.2/1398658/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.1/1331545/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/5.0.5/1945692/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/5.0.4/1435862/packages/com.vmware.fusion.tools.linux.zip.tar
"

# jessie doesn't load the loop device automatically?
sudo modprobe loop

mkdir -p downloads
pushd downloads >/dev/null

  for url in ${URLS}; do
    ver="$(echo ${url} | sed -e 's/.*\/\([0-9]*\.[0-9]*\.[0-9]*\)\/.*/\1/')"
    zip="$(basename "${url}" .tar)"
    base="$(basename "${zip}" .zip)"
    tar="${zip}-${ver}.tar"

    rm -f "${zip}"
    rm -fr payload

    if [[ ! -f "${tar}" ]]; then
      ${WGET} -O "${tar}" "${url}"
    fi

    tar xvf "${tar}"

    if [[ ! -f "${zip}" ]]; then
      echo $0: File not found: ${zip} in ${tar} >&2
      exit 1
    fi

    unzip -o "${zip}"

    rm -f "${zip}"

    if [[ ! -d "payload" ]]; then
      echo $0: Directory not found: payload in ${zip} >&2
      exit 2
    fi

    sudo mkdir -p /mnt/cdrom
    sudo mount -o loop payload/*.iso /mnt/cdrom

    tools="$(find /mnt/cdrom -name 'VMwareTools-*.tar.gz')"

    dest="../$(basename "${tools}")"

    cp -v "${tools}" "${dest}"
    chmod ug+w "${dest}"

    sudo umount /mnt/cdrom

    rm -fr payload
    rm -f descriptor.xml manifest.plist

  done

popd >/dev/null
