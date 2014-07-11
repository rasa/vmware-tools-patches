vmware-tools-patches
====================

These bash scripts allow you to easily apply multiple patches to a `VMwareTools-*.tar.gz` file.

It has been tested with the following files:

* VMwareTools-9.6.2-1688356.tar.gz (VMWare Workstation 10.0.2 & 10.0.3)
* VMwareTools-9.6.1-1378637.tar.gz (VMWare Workstation 10.0.1)
* VMwareTools-9.6.0-1294478.tar.gz (VMWare Workstation 10.0.0)
* VMwareTools-9.2.4-1398046.tar.gz (WMware Workstation 9.0.3)
* VMwareTools-9.2.3-1031360.tar.gz (VMWare Workstation 9.0.2)

and apply successfully with the following Linux kernels:

* 3.12.x
* 3.11.x
* 3.8.x
* 3.5.x
* 2.6.32

The included patches do not currently apply successfully with the following Linux kernels:

* 3.13.x

but VMWare Tools still builds, and installs successfully.

The included patches do not currently apply successfully with the following Linux kernels:

* 3.15.x

and building VMWare Tools fails with the following error:

````
vmhgfs-only/link.c:186:10: error: implicit declaration of function ‘vfs_readlink’ [-Werror=implicit-function-declaration]
````

To run:

1. Checkout the repository:
<pre>
$ git clone https://github.com/rasa/vmware-tools-patches.git
</pre>
2. Copy your patch(es) into the appropriate directory in the `patches` directory. The file must end in `.patch`, or `.diff`. This step is optional. For example:
<pre>
$ cp great-new.patch vmware-tools-patches/patches/vmhgfs
</pre>
3. Copy a `VMwareTools-*.tar.gz` into the `vmware-tools-patches` folder:
<pre>
$ cp VMwareTools-*.tar.gz vmware-tools-patches/
</pre>
4. Apply the patches, and then run the `vmware-install.pl` installer:
<pre>
$ cd vmware-tools-patches
$ ./untar-and-patch-and-compile.sh
</pre>

If `apt-get` is installed on your system, the following packages will be installed prior to compilation:

* linux-headers-$(uname -r)
* build-essential
* dkms
* patch
* psmisc

If `apt-get` is not installed, you will need to install these (or equivalent) packages manually, before starting.
