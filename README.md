vmware-tools-patches
====================

These bash scripts allow you to easily apply multiple patches to a `VMwareTools-*.tar.gz` file.

It has been tested with the following files:

* [VMwareTools-9.9.0-2304977.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.1.0/2314774/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 7.1.0)
* [VMwareTools-9.8.4-2202052.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.0.1/2235595/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 7.0.1)
* [VMwareTools-9.8.3-2075148.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/7.0.0/2075534/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 7.0.0)
* [VMwareTools-9.6.2-1688356.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.3/1747349/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 6.0.3/4/5 & Workstation 10.0.2/3/4)
* [VMwareTools-9.6.1-1378637.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.2/1398658/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 6.0.2 & Workstation 10.0.1)
* [VMwareTools-9.6.0-1294478.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.1/1331545/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 6.0.0/1 & Workstation 10.0.0)
* [VMwareTools-9.2.4-1398046.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/5.0.5/1945692/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 5.0.5 & Workstation 9.0.3)
* [VMwareTools-9.2.3-1031360.tar.gz](https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/5.0.4/1435862/packages/com.vmware.fusion.tools.linux.zip.tar) (VMware Fusion 5.0.4 & Workstation 9.0.2)

and apply successfully with the following Linux kernels:

* 3.16.x
* 3.12.x
* 3.11.x
* 3.8.x
* 3.5.x
* 2.6.32

I have not personally tested the following kernels, but presumably the patches will apply successfully on them:

* 3.17.x
* 3.15.x

The included patches do not currently apply successfully with the following Linux kernels:

* 3.13.x

and building VMWare Tools fails with the following error:

````
vmhgfs-only/link.c:186:10: error: implicit declaration of function ‘vfs_readlink’ [-Werror=implicit-function-declaration]
````

but VMWare Tools still builds, and installs successfully.

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
