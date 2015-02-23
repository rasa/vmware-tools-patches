#!/usr/bin/env bash

# apply patches for a single module

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! hash patch >/dev/null 2>&1; then
  if hash apt-get >/dev/null 2>&1; then
    sudo apt-get install -y patch
  else
    echo $0: Command not found: patch >&2
    exit 1
  fi
fi

if [[ -z "$1" ]]; then
  echo Usage: $0 patchdir >&2
  exit 2
fi

patchdir="$1"

if [[ ! -d "${patchdir}" ]]; then
  echo $0: Error: Directory not found: ${patchdir} >&2
  exit 3
fi

patches="$(find ${patchdir} -type f -size +1c -regextype posix-extended -iregex '.*\.(patch|diff)' | sort)"

if [[ -z "${patches}" ]]; then
  echo $0: Error: no patches found in ${patchdir} >&2
  exit 4
fi

module="$(basename ${patchdir})"

if [[ ! -d lib/modules/source ]]; then
  echo $0: Error: Directory not found: lib/modules/source >&2
  exit 5
fi

if [[ ! -f "lib/modules/source/${module}.tar" ]]; then
  echo $0: Error: File not found: lib/modules/source/${module}.tar >&2
  exit 6
fi

pushd lib/modules/source >/dev/null

  if [[ ! -f "${module}.tar.orig" ]]; then
    cp -p "${module}.tar" "${module}.tar.orig"
  fi

  rm -rf "${module}-only"

  tar --no-same-owner --no-same-permissions -xf "${module}.tar"

  if [[ ! -d "${module}-only" ]]; then
    echo $0: Error: Directory not found: ${module}-only in lib/modules/source/${module}.tar >&2
    exit 7
  fi

  chmod -R a+w "${module}-only"

  pushd "${module}-only" >/dev/null

    for patch in ${patches}; do
      base="$(basename ${patch})"
      dir="$(basename $(dirname ${patch}))"
      patch --batch --ignore-whitespace --strip=1 --dry-run < "${patch}" >/dev/null 2>&1
      if [ $? -eq 0 ]; then
        echo "*** Applying ${dir}/${base} ..."
        patch --batch --ignore-whitespace --strip=1 --backup < "${patch}"
      else
        echo "*** Skipping ${dir}/${base}: did not apply cleanly"
      fi
    done

  popd >/dev/null

  tar -cf "${module}.tar" "${module}-only"

  if [[ -z "${VMWARE_TOOLS_PATCHES_DEBUG}" ]]; then
    rm -rf "${module}-only"
  fi

popd >/dev/null
