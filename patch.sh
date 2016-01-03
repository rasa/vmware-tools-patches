#!/usr/bin/env bash

# apply patches for all modules

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -d vmware-tools-distrib ]]; then
  echo $0: Error: Directory not found: vmware-tools-distrib >&2
  exit 3
fi

if ! hash patch >/dev/null 2>&1; then
  if hash apt-get >/dev/null 2>&1; then
    sudo apt-get install -y patch
  else
    echo $0: Command not found: patch >&2
    exit 1
  fi
fi

modules="$(find ${SCRIPT_DIR}/patches -mindepth 1 -maxdepth 1 -type d)"

pushd vmware-tools-distrib >/dev/null

	if [[ -n "${modules}" ]]; then
		for module in ${modules}; do
			"${SCRIPT_DIR}/patch-module.sh" "${module}"
		done
	fi
# Currently this should only match one patch which adds support for ip instead of ifconfig
if hash ip >/dev/null 2>&1; then
  patches="$(find ${SCRIPT_DIR}/patches -maxdepth 1 -type f -size +1c -regextype posix-extended -iregex '.*\.(patch|diff)' | sort)"
  if [[ -n "${patches}" ]]; then
    for patch in ${patches}; do
      pushd bin >/dev/null
      base="$(basename ${patch})"
      echo "\$base is" + $base
      dir="$(basename $(dirname ${patch}))"
      echo "\$dir is" + $dir
      patch --batch --ignore-whitespace --strip=1 --dry-run < "${patch}" >$base.patch.err 2>&1
      if [ $? -eq 0 ]; then
        rm $base.patch.err
        echo "*** Applying ${dir}/${base} ..."
        patch --batch --ignore-whitespace --strip=1 --backup < "${patch}"
      else
        echo "*** Skipping ${dir}/${base}: patch not appropriate for this kernel"
      fi
    done
  fi
fi

popd >/dev/null

if [[ "${VMWARE_TOOLS_PATCHES_DEBUG-}" =~ (pause|PAUSE) ]]; then
  read -p "Press [Enter] to continue: "
fi
