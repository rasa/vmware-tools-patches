#!/bin/bash
# This file can be grabbed via wget/curl to bootstrap the repo
# A really handy place to use this bootstrap would be Packer

set -e

if [[ -n "$(type -P apt-get)" ]]; then
 # Debian and derivatives
 apt-get install -y git
elif [[ -n "$(type -P yum)" ]]; then
 # Fedora, CentOS or RHEL and derivatives
 yum -y install git
elif [[ -n "$(type -P zypper)" ]]; then
 # openSUSE
 zypper --non-interactive install git
elif [[ -n "$(type -P pacman )" ]]; then
 pacman -S --needed --noconfirm git
fi

# This is fragile, it needs updated depending on the branch/fork you want to run
git clone https://github.com/rasa/vmware-tools-patches.git
cd vmware-tools-patches

# Sourcing the setup script gets the dependencies we really need,
# so that we don't have to lay them all out here and we could uninstall them
# when we are done with them post compile
. ./setup.sh
./download-tools.sh latest
./untar-and-patch.sh
./compile.sh
