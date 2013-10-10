vmware-tools-patches
====================

These bash scripts allow you to easily apply multiple patches to a `VMwareTools-*.tar.gz` file.

It has been tested with the following files:

*. VMwareTools-9.2.3-1031360.tar.gz (VMWare Workstation 9)
*. VMwareTools-9.6.0-1294478.tar.gz (VMWare Workstation 10)

To run:

1. Checkout the repository:

<pre>
$ git clone https://github.com/rasa/vmware-tools-patches.git
</pre>

2. Copy your patch(es) into the appropriate directory in the `patches` directory. This step is optional. For example:

<pre>
$ cp great-new.patch vmware-tools-patches/patches/vmhgfs
</pre>

3. Copy a `VMwareTools-*.tar.gz` into the `vmware-tools-patches` folder:

<pre>
$ cp VMwareTools-9.6.0-1294478.tar.gz vmware-tools-patches/
</pre>

4. Apply the patches, and then run the `vmware-install.pl` installer:

<pre>
$ cd vmware-tools-patches
$ ./untar-and-patch-and-compile.sh
</pre>
