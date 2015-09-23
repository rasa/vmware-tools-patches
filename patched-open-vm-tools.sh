#!/bin/bash

set -e

if [[ -n "$(type -P apt-get)" ]]; then
 # Debian and derivatives
 apt-get install build-essential dkms gcc git linux-headers-$(uname -r) make patch perl psmisc unzip wget zip -y 
elif [[ -n "$(type -P yum)" ]]; then
 # Fedora, CentOS or RHEL and derivatives
 yum -y install gcc glibc-headers kernel-devel kernel-headers make perl git wget
elif [[ -n "$(type -P zypper)" ]]; then
 # openSUSE
 zypper --non-interactive install git make gcc kernel-devel patch wget
fi

git clone https://github.com/rasa/vmware-tools-patches.git
cd vmware-tools-patches
./download-tools.sh 7.1.2
./untar-and-patch.sh
./compile.sh
