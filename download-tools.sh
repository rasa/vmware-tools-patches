#!/bin/bash -x

# download selected vmware tools files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WGET="wget --no-check-certificate"

URLS="\
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/11.1.0/13668589/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/11.0.3/12992109/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/11.0.2/10952296/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/11.0.1/10738065/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/11.0.0/10120384/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/10.1.3/9472307/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/10.1.2/8502123/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/10.1.1/7520154/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/10.1.0/7370838/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/10.0.1/6754183/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/10.0.0/6665085/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.5.8/5824040/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.5.7/5528452/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.5.6/5234762/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.5.5/5192483/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.5.4/5115894/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.5.3/4696910/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.5.2/4635224/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.5.1/4543325/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.5.0/4352717/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.1.1/3771013/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.1.0/3272237/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.0.2/3164312/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.0.1/3094680/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.0.0/2985594/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.1.3/3204469/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.1.2/2779224/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.1.1/2498930/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.1.0/2314774/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.0.1/2235595/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.0.0/2075534/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.6/2684343/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.5/2209127/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.4/1887983/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.3/1747349/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.2/1398658/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.1/1331545/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/5.0.5/1945692/packages/com.vmware.fusion.tools.linux.zip.tar
https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/5.0.4/1435862/packages/com.vmware.fusion.tools.linux.zip.tar
"

# version parameter can be passed to script to indicate which tools to download
if [[ -n "$1" ]]; then
	if [[ "$1" = "latest" ]]; then
		URLS=$(echo "$URLS" | head -n 1)
	else
		URLS=$(echo "$URLS" | grep "/$1/")
	fi
fi

SEVENZIP=$(which 7z 2>/dev/null)

if [[ -z "${SEVENZIP}" ]]; then
	# jessie doesn't load the loop device automatically?
	sudo modprobe loop
fi

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

		if [[ -n "${SEVENZIP}" ]]; then
			ISO_DIR=payload
			"${SEVENZIP}" x -o${ISO_DIR} payload/*.iso
		else
			ISO_DIR=/mnt/cdrom
			sudo mkdir -p ${ISO_DIR}
			sudo mount -o loop payload/*.iso ${ISO_DIR}
		fi

		tools="$(find ${ISO_DIR} -name 'VMwareTools-*.tar.gz')"

    dest="../$(basename "${tools}")"

    cp -v "${tools}" "${dest}"
    chmod ug+w "${dest}"

		if [[ -z "${SEVENZIP}" ]]; then
	    sudo umount /mnt/cdrom
		fi

    rm -fr payload
    rm -f descriptor.xml manifest.plist

  done

popd >/dev/null
