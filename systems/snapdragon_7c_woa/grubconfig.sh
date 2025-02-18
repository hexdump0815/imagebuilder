#!/bin/bash

# add some extra options to the kernel cmdline - not used yet
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="rootwait ro console=tty0 fsck.repair=yes net.ifnames=0 ipv6.disable=1 noresume apparmor=0 efi=novamap,noruntime clk_ignore_unused pd_ignore_unused deferred_probe_timeout=30"/g' /etc/default/grub
# do not boot any dtb entry automatically - the user has to decide according to the device used
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/g' /etc/default/grub

# the following will parse the proper kernel version and the proper uuids of the
# boot and root partitions into the provided custom grub menu entries
# the velvet custom config is initially named differently and here renamed to its
# regular name to not result in a conflict during the initial grub installation
mv -vf /etc/grub.d/40_custom.velvet /etc/grub.d/40_custom
BOOT_UUID=`blkid | grep /dev/loop0p2 | sed 's,.* UUID=",,g;s," .*,,g'`
ROOT_UUID=`blkid | grep /dev/loop0p3 | sed 's,.* UUID=",,g;s," .*,,g'`
KERNEL_VERSION=`ls /boot/*Image-* | sed 's,.*Image-,,g' | sort -u`
sed -i "s,BOOT_UUID,${BOOT_UUID},g" /etc/grub.d/40_custom
sed -i "s,ROOT_UUID,${ROOT_UUID},g" /etc/grub.d/40_custom
sed -i "s,KERNEL_VERSION,${KERNEL_VERSION},g" /etc/grub.d/40_custom
