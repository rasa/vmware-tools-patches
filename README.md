vmware-tools-patches
====================

These bash scripts allow you to easily apply multiple patches to a `VMwareTools-*.tar.gz` file.

It has been tested with the following files:

* VMwareTools-9.2.3-1031360.tar.gz (VMWare Workstation 9.0.2)
* VMwareTools-9.6.0-1294478.tar.gz (VMWare Workstation 10.0.0)
* VMwareTools-9.6.1-1378637.tar.gz (VMWare Workstation 10.0.1)

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
* psmisc

If `apt-get` is not installed, you will need to install these (or equivalent) packages manually, before starting.
