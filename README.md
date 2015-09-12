# VMware Tools Patches [![Flattr this][flatter_png]][flatter]

Patch VMware Tools source code for a variety of VMware Tools and kernel versions.

## Quickest Start (The easiest way)

````bash
$ git clone https://github.com/rasa/vmware-tools-patches.git
$ cd vmware-tools-patches
$ ./patched-open-vm-tools.sh
````
The above script has been provided which generally should always work, automatically invoking commands described in the following section "Quick Start"

To update and re-patch later, remove the `vmware-tools-patches` subdirectory with the previous download and re-run the script.

## Quick Start

To build VMware Tools, do the following:

1. Checkout the repository:
	````bash
	$ git clone https://github.com/rasa/vmware-tools-patches.git
	````

2. *(Optional)* Copy your patch(es) into the appropriate directory in the `patches` directory. Patches must end in `.patch`, or `.diff` and be [properly formatted](#required-patch-format). For example:
	````bash
	$ cp great-new.patch vmware-tools-patches/patches/vmhgfs
	````

3. Copy or download the version of VMware Tools you wish to use into the `vmware-tools-patches` folder. One way to do this is using [download-tools.sh](../../blob/master/download-tools.sh) and pass it the associated VMWare Fusion version number:
	````bash
	$ cd vmware-tools-patches
	$ ./download-tools.sh 7.1.2
	````

   It is strongly suggested to use the [latest version](#tested-vmware-tools-versions) of VMware Tools.

   VMware Tools is also included inside the `linux.iso` file that is shipped with VMware Fusion, Player, and Workstation. 

4. Untar the tarball, and apply the patches:
	````bash
	$ cd vmware-tools-patches
	$ ./untar-and-patch.sh
	````

5. Run the `vmware-install.pl` installer to install VMware Tools:
	````bash
	$ ./compile.sh
	````

## Tested Kernels

With the patches applied, at least one version of VMware Tools listed [below](#tested-vmware-tools-versions), compiles successfully with the following Linux kernels:

* [4.0.x](http://kernelnewbies.org/Linux_4.0)
* [3.19.x](http://kernelnewbies.org/Linux_3.19)
* [3.18.x](http://kernelnewbies.org/Linux_3.18)
* [3.17.x](http://kernelnewbies.org/Linux_3.17)
* [3.16.x](http://kernelnewbies.org/Linux_3.16)
* [3.13.x](http://kernelnewbies.org/Linux_3.13)
* [3.12.x](http://kernelnewbies.org/Linux_3.12)
* [3.11.x](http://kernelnewbies.org/Linux_3.11)
* [3.8.x](http://kernelnewbies.org/Linux_3.8)
* [3.5.x](http://kernelnewbies.org/Linux_3.5)
* [2.6.32](http://kernelnewbies.org/Linux_2.6.32)

We have not received any reports of the patches failing on the following kernels, so presumably they apply successfully:

* [3.15.x](http://kernelnewbies.org/Linux_3.15)
* [3.14.x](http://kernelnewbies.org/Linux_3.14)
* [3.10.x](http://kernelnewbies.org/Linux_3.10)
* [3.9.x](http://kernelnewbies.org/Linux_3.9)
* [3.7.x](http://kernelnewbies.org/Linux_3.7) and earlier

## Tested VMware Tools Versions

The included patches have been tested with the following versions of VMware Tools:


* [VMwareTools-10.0.0-2977863.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.0.0/2985594/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 8.0.0 & Workstation 12.0.0)
* [VMwareTools-9.9.3-2759765.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.1.2/2779224/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 7.1.2 & Workstation 11.1.2)
* [VMwareTools-9.9.2-2496486.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.1.1/2498930/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 7.1.1 & Workstation 11.1.0)
* [VMwareTools-9.9.0-2304977.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.1.0/2314774/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 7.1.0 & Workstation 11.0.0)
* [VMwareTools-9.8.4-2202052.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.0.1/2235595/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 7.0.1)
* [VMwareTools-9.8.3-2075148.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.0.0/2075534/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 7.0.0)
* [VMwareTools-9.6.6-2649738.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.6/2684343/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 6.0.6 & Workstation 10.0.5/6/7)
* [VMwareTools-9.6.2-1688356.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.3/1747349/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 6.0.3/4/5 & Workstation 10.0.2/3/4)
* [VMwareTools-9.6.1-1378637.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.2/1398658/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 6.0.2 & Workstation 10.0.1)
* [VMwareTools-9.6.0-1294478.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.1/1331545/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 6.0.0/1 & Workstation 10.0.0)
* [VMwareTools-9.2.4-1398046.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/5.0.5/1945692/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 5.0.5 & Workstation 9.0.3)
* [VMwareTools-9.2.3-1031360.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/5.0.4/1435862/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 5.0.4 & Workstation 9.0.2)

## Encountering Failures

If one or more patches do not apply successfully, you may get an error during compilation, such as

````
vmhgfs-only/link.c:186:10: error: implicit declaration of function ‘vfs_readlink’ [-Werror=implicit-function-declaration]
````

This indicates the `vmhgfs` kernel module failed to build and was not installed. That may be acceptable, as VMware Tools still installed successfully, but without the "shared folder" functionality provided by the `vmhgfs` module.

## Required Patch Format

Please note your patches must contain only one directory name in them. For example, the following patches will work:

````
+--- vmhgfs-only/link.c.orig	2014-04-23 10:11:34.891106441 +0100
++++ vmhgfs-only/link.c	2014-04-23 00:49:03.000000000 +0100
````
or
````
+--- vmhgfs-only.orig/link.c	2014-04-23 10:11:34.891106441 +0100
++++ vmhgfs-only/link.c	2014-04-23 00:49:03.000000000 +0100
````
The following patches will not work:

````
+--- link.c.orig	2014-04-23 10:11:34.891106441 +0100
++++ link.c	2014-04-23 00:49:03.000000000 +0100
````
or
````
+--- path/to/vmhgfs-only/link.c.orig	2014-04-23 10:11:34.891106441 +0100
++++ path/to/vmhgfs-only/link.c	2014-04-23 00:49:03.000000000 +0100
````

## Dependencies

If you use [download-tools.sh](../../blob/master/download-tools.sh), to download a VMware Tools file, the script will need the following installed:

* sevenzip or sudo rights
* unzip
* wget
* zip

If `apt-get` is installed on your system, the following packages will be installed when you first run [compile.sh](../../blob/master/compile.sh) or [untar-and-patch-and-compile.sh.sh](../../blob/master/untar-and-patch-and-compile.sh.sh):

* linux-headers-$(uname -r)
* build-essential
* dkms
* patch
* perl
* psmisc

If `yum` is installed on your system, the following packages will be installed when you first run [compile.sh](../../blob/master/compile.sh) or [untar-and-patch-and-compile.sh.sh](../../blob/master/untar-and-patch-and-compile.sh.sh):

* gcc
* glibc-headers 
* kernel-devel
* kernel-headers 
* make 
* perl

If neither `apt-get` or `yum` is installed, you will need to install these (or equivalent) packages manually, before starting.

## Contributing

To contribute to this project, please see [CONTRIBUTING.md](CONTRIBUTING.md).

## Bugs

To view existing bugs, or report a new bug, please see [issues](../../issues).

## Changelog

To view the version history for this project, please see [CHANGELOG.md](CHANGELOG.md).

## License

This project is [MIT licensed](LICENSE).

## Contact

This project was created and is maintained by [Ross Smith II][] [![endorse][endorse_png]][endorse]

Feedback, suggestions, and enhancements are welcome.

[Ross Smith II]: mailto:ross@smithii.com "ross@smithii.com"
[flatter]: https://flattr.com/submit/auto?user_id=rasa&url=https%3A%2F%2Fgithub.com%2Frasa%2Fvmware-tools-patches
[flatter_png]: http://button.flattr.com/flattr-badge-large.png "Flattr this"
[endorse]: https://coderwall.com/rasa
[endorse_png]: https://api.coderwall.com/rasa/endorsecount.png "endorse"
