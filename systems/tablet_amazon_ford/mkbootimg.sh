#!/bin/bash
#
# arg 1 is the kernel version number
# arg 2 is BUILD_ROOT
#
# IMPORTANT: this is not yet used - for now i'm using a postmarketos kernel+initrd=boot.img
# TODO: include this into create-image.sh and maybe check root LABEL name handling

cd ${2}/boot

mkbootimg --kernel zImage-${1} --ramdisk initrd.img-${1} --cmdline 'bootopt=64S3,32N2,32N2 init=/sbin/init console=tty0 root=LABEL=rootpart rootwait ro fsck.repair=yes net.ifnames=0 ipv6.disable=1' --base 0x80000000 --kernel_offset 0x00008000 --ramdisk_offset 0x04000000 --second_offset 0x00f00000 --tags_offset 0x00000100 --pagesize 2048 -o boot.img-${1}
