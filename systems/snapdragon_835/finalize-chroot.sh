#!/bin/bash

# ugly hack to make booting work until it is clear how to get booting work well with the default grub
# this is using the efi boot files and a prepared grub.cfg taken from a working setup - the efi files
# expect the grub.cfg at the unusual /boot/boot/grub/grub.cfg location :) ... the following will parse
# the proper kernel version and the proper uuids of the boot and root partitions into the grub.cfg
BOOT_UUID=`blkid | grep /dev/loop0p2 | sed 's,.* UUID=",,g;s," BLOCK_SIZE=.*,,g'`
ROOT_UUID=`blkid | grep /dev/loop0p3 | sed 's,.* UUID=",,g;s," BLOCK_SIZE=.*,,g'`
KERNEL_VERSION=`ls /boot/*Image-* | sed 's,.*Image-,,g' | sort -u`
sed -i "s,BOOT_UUID,${BOOT_UUID},g" /boot/boot/grub/grub.cfg
sed -i "s,ROOT_UUID,${ROOT_UUID},g" /boot/boot/grub/grub.cfg
sed -i "s,KERNEL_VERSION,${KERNEL_VERSION},g" /boot/boot/grub/grub.cfg
