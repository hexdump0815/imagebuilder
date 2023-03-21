# using the imagebuilder framework

IMPORTANT NOTE: this document is just the beginning and will hopefully get better over time :)

## requirements and preparations

the imagebuilder framework is supposed to run on the system for which the
image should be built for, i.e. to build a aarch64 image it should run on an
aarch64 system. there is one partial exception to this rule: the framework is
also able to build images with a 64bit kernel and a 32bit userland and for
this it has to run on the 64bit system - for example to build an aarch64 image
with a 32bit armv7l userland (which has lower memory requirements than a
64bit userland which might make a difference on low mem systems) it has to be
used on an aarch64 system.

the easiest way is to simply use the latest availabe imagebuilder image for a
given system, get it running and then use the imagebuilder on it to build an
up to date new image. a 32gb or larger sd card or usb devices should be
enough on storage to build an image. to have all the build tools around to
(optionally) build a kernel and build an image one should run the following
commands (the swapfile size should be best at 1-2x the size of ram in the
system and depending on the available storage size of course as well):
```
/scripts/extend-rootfs.sh
/scripts/recreate-swapfile.sh 2G
/scripts/install-buildtools.sh
```

currently the imagebuilder framework has some paths hardcoded into its scripts
and thus it should for now live in /compile/local/imagebuilder - at some
point in time i hope to make it more flexible, so that the location where to
run it can be freely chosen, but for now its best to clone this repo to
/compile/local/imagebuilder as a first step (in case the btrfs filesystem is
used, please have a look at the next section beforehand):
```
git clone https://github.com/hexdump0815/imagebuilder /compile/local/imagebuilder
cd /compile/local/imagebuilder
```

the next step is to run:
```
./scripts/prepare.sh
```
to install some extra tools and commands required for the imagebuilder. this
step has to be done only once per system where the imagebuilder framework
should be used.

## special considerations when using the btrfs filesystem (default in most cases)

when the imagebuilder framework is used on a system running on an imagebuilder
based image then for most systems the rootfs is btrfs and some special setup
is required to avoid useless extra compression (as the btrfs filesystem used
has already transparent compression enabled) and maybe even potential
problems in this case:
```
cd /compile/local/
btrfs subvolume create /compile/local/imagebuilder-diskimage
chattr -R +C /compile/local/imagebuilder-diskimage
btrfs property set /compile/local/imagebuilder-diskimage compression none
```

in case one mounts some extra disk or partition to /compile/local to use it
with the btrfs filesystem (which might be a good idea due to built in
compression, checksumming and partially deduplication to save space) then the
following commands could be used assuming /dev/xyz to be the disk or partition
which should be mounted to /compile/local to be used as disk for the
imagebuilder framework:
```
mkfs -t btrfs -m single -L clocal /dev/xyz
```
then the following line should be added at the end of /etc/fstab:
```
LABEL=clocal /compile/local btrfs defaults,ssd,compress-force=zstd,noatime,nodiratime 0 2
```
then it can be mounted finally via:
```
mkdir -p /compile/local
mount /compile/local
```

## getting some files required to build the image

afterwards run:
```
./scripts/get-files.sh
```
which will print out all available options so a potential full cmdline could
look like
```
./scripts/get-files.sh amlogic_gx aarch64 bookworm
```
this command will fetch a prebuilt kernel, if required a prebuilt u-boot or
other files required beyond standard debian or ubuntu files to build the
image.

## how to use a self built kernel instead of the downloaded one

in case one prefers to use a self built kernel etc. instead, then follow the
notes about building the kernel, u-boot etc. which are usually linked in the
readme.md of the corresponding system one wants to build an image for. more
information about building an own kernel can be found in
doc/building-own-kernels.md - i would really like to encourage everyone to
build your own kernel, as it is not that complicated and this way one can
easily install a newer version from time to time (also for this there is
some information in the doc dir). at the beginning it is maybe the easiest
to start with the prebuilt kernel downloaded and start building an own kernel
later on.

to use the self build kernel instead of the downloaded one, simply replace the
downloaded kernel-abc-xyz.tar.gz file in /compile/local/imagebuild-download
with the self built kernel archive, which usually will be something like
/compile/result/stable/6.1.0-stb-av8.tar.gz (for the above amlogic_gx case
and for that following the corresponding kernel build notes from
https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.av8
in this example).

for some systems, especially all of the 64bit arm chromebooks which are using
the native chromebook bootloader there are extra steps required to extract
the bootable kernel image from the kernel .tar.gz file. in general it is a
good idea to have a look at the "get-files.sh" for the system one wants to
build an image for to see if there are any extra steps besides the wget
commands to get the precompiled kernel etc. and everything related to them.
the special steps for the chromebooks mentioned above are those for example:
https://github.com/hexdump0815/imagebuilder/blob/ff75dd53677f3e59fbff4db125cf1152cba04b0a/systems/chromebook_kukui/get-files.sh#L9
i.e. this extracts the corresponding vmlinux.kpart image (the kernel in a
format which can be booted from the chromebook bootloader) out of the kernel
.tar.gz file and puts it there as boot-xyz.dd so that it gets written to
the first chromebook kernel partition in the image creation step.

## create the rootfs cache and rootfs

the next step is to run:
```
./scripts/create-fs.sh
```
again with the same options as get-files.sh before to build a rootfs for
the image. this will download a lot of files from the debian or ubuntu
repositories to install them into the rootfs to be prepared. to speed up
this process for future builds a cache of the generic first stage of this
rootfs is created and will be used for future builds at
/compile/local/imagebuilder-aarch64-bookworm-cache - the rootfs for the
image will then be built at /compile/local/imagebuilder-root

## create the actual bootable image

when this has finished it is time to build the actual bootable disk image
based on the rootfs just prepared by running:
```
./scripts/create-image.sh
```
again with the same options as before - this will create the bootable disk
image as
/compile/local/imagebuilder-diskimage/amlogic_gx-aarch64-bookworm.img
for example.

this image can be written using the dd command to an sd card or usb device
and should be bootable. for some images some extra preparation is required
like writing the correct boot block to the image if multiple devices which
require different boot blocks are supported by one image. this should
usually be mentioned in the readme.md or in the doc dir of the
corresponding system.
