# installing a newer kernel

## where to get a newer kernel from?

there are two possible sources for newer kernels: either a new self built
kernel (the recommended way - see building-own-kernels.md) or if there is a
newer kernel available in the release area of the kernel build info repo which
can happen from time to time with no real guarantee if and when it might happen.

## how to install it

the kernel build is either a tar.gz archive which needs to be unpacked as root
from the root directoy (here 5.19.1-stb-exy+.tar.gzn as an example):
```
cd /
tar xzf /somepath/5.19.1-stb-exy+.tar.gz
```
in the archive are some files in /boot, dtb files (if they exist for the kernel)
in /boot/dtb-5.19.1-stb-exy+ and the kernel modules and some tools in
/lib/modules/5.19.1-stb-exy+ (the plus sign at the end of the kernel version is
there if any kind of patches got applied relative to the clean original linux
mainline kernel tree).

it is always recommended and in case of a luks encryted root filesystem even
reqired to rebuild the corresponding initramfs after installing a new kernel
via the following command:
```
initramfs-update -c -k 5.19.1-sty-exy+
```

if the kernel is the result of an own kernel build then everything should
already be in place.

## how to activate/use the new kernel

this depends on the way a system is booted and is described for the different
boot types in the following subsections:

### u-boot

a new entry for new kernel version has to be created in the file
/boot/extlinux/extlinux.conf - the easiest way is to simply copy and paste
another entry and adjust the kernel version for it. it might be required to
adjust the DEFAULT entry in extlinux.conf as well - this is only required if
there is no boot menu accessible via kayboard/display or serial console during
boot.

### grub

once running the "update-grub" command as root should include the new kernel
into the grub boot menu. be aware: depending on the kernel version number it
might not be set as the defulat kernel to be booted and might need manual
selection at the grub boot prompt.

### chromebooks

first a note regarding 32bit armv7l chromebooks: so far they are not using the
kpart kernel image based approach as described below (which is valid for all
64bit aarch64 chromebooks) - they are using u-boot instead, so the u-boot
section should apply. intel based chromebooks usually using some form of grub
booting, so the grub section should apply for those.

chromebook images can boot kernels from one of the two special kernel
partitions of the disk (the first two small partitions), but the kernel builds
usually only build a kernel, which can be booted from the first partition as
during the creation of the kpart kernel boot image the root filesystem defined
for the kernel is hard coded to "root=PARTUUID=%U/PARTNROFF=3" which will use
the partiton with the offset 3 from the partition of the booted kernel as root
filesystem. as the root filesystem on those images is on partition 4 the
kernel has to be in partition 1 to be able to find it (1+3 = 4). a new kpart
image needs to be built with an offset of 2 to be able to boot it for testing
purposes for instance from the second kernel boot partition.

to install a chromebook kernel in the kpart format it simply has to be written
to the first partition of the device the image had been installed on (sd card
or usb disk) with the linux dd command like for example (assuming mmcblk0 as
device):

dd if=/boot/vmlinux.kpart-xyz of=/dev/mmcblk0p1

or (assuming sda as device):

dd if=/boot/vmlinux.kpart-xyz of=/dev/sda1

please double check the device name the kernel is being written too beforehand
as the dd command will simply override what is there without asking and
without any extra checks.

chromebooks will always boot from the kernel boot partition with the highest
priority which is by default the first kernel boot partition of the images. it
is possible to change the priority to make the second partition the one with
the highest priority so that it will get booted automatically during the next
boot with the following command:
```
cgpt add -i 2 -S 0 -T 1 -P 15 /dev/mmcblk0
```
assuming /dev/mmcblk0 to be the device for the disk to be booted. this switch
of boot priorities is only valid for a single boot, i.e. booting from the
second kernel boot partition has to be requested via this command new each
time. more information about how to test boot new kernels on chromebooks can
be found in test-booting-a-kernel-on-chromebooks.txt ...
