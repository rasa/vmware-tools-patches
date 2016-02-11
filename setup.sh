#!/bin/bash
# This file should be sourced to install the dependencies before they are needed
# . setup.sh

if [[ -e /etc/redhat-release ]]; then
	if hash yum >/dev/null 2>&1; then
    sudo yum -y install \
                    unzip \
                    patch \
                    gcc \
                    glibc-headers \
                    kernel-devel \
                    kernel-headers \
                    make \
                    perl \
                    wget
	fi
fi

if [[ -e /etc/debian_version ]]; then
	if hash apt-get >/dev/null 2>&1; then
		sudo apt-get install -y \
                    build-essential \
                    dkms \
                    gcc \
                    linux-headers-$(uname -r) \
                    patch \
                    perl \
                    psmisc \
                    make \
                    unzip \
                    wget \
                    zip
  fi
fi

if [[ -e /etc/arch-release ]]; then
	if hash pacman >/dev/null 2>&1; then
		sudo pacman -Syu --needed --noconfirm \
                    wget \
                    unzip \
                    patch \
                    perl \
                    gcc \
                    glibc \
                    linux-headers \
                    make \
                    base \
                    base-devel
	fi
fi

if [[ -e /etc/SuSE-release ]]; then
	if hash zypper >/dev/null 2>&1; then
   zypper --non-interactive install \
                    make \
                    gcc \
                    kernel-devel \
                    patch \
                    wget \
                    unzip
	fi
fi
