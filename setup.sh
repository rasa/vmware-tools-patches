#!/bin/bash
# This file should be sourced to install the dependencies before they are needed
# . setup.sh

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

if [[ -e /etc/arch-release ]]; then
	if hash pacman >/dev/null 2>&1; then
		sudo pacman -Syu --needed --noconfirm wget unzip patch gcc glibc linux-headers make perl
	fi
fi
