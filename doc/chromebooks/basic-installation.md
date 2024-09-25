# The regular installation

## overview

when not talking encryption there are 2 ways one can approach installations
- lazy way "dd to emmc" (is simpler, will make you unable to boot usb due to uuid conflict)
- proper way "rsync to emmc" (recommended one)

_Note. **before proceeding** with installation it is recommended to first [set gbb flags](./setting_gbb_flags.md)_

## preparations

some disk detection bs

## more complex: rsync to emmc

in this approach we do not dump the image file onto the emmc but instead
simply sync the contents of the running system onto newly created filesystems
on the emmc. the advantages are:
- no network connection required and the running system has everything
  required
- the running image can already be a bit preconfigured and all changes to it
  will also be synced to emmc (maybe useful when installing on multiple
identical systems)
- the filesystems on the emmc will get new filesystem uuids and also the
  labels of the filesystems can be easily adjusted, so no risk of a conflict
with a booted rescue system from sd card/usb

```
# get root
sudo -i
password: (the default password of a freshly booted image is "changeme")
# define the source and target device depending on what was found out above
# example here: target is /dev/mmcblk0, source is /dev/mmcblk1
root@changeme:~# export TGTDEV=mmcblk0
root@changeme:~# export SRCDEV=mmcblk1
# wipe the partition table on the target disk
root@changeme:~# sgdisk -Z /dev/$TGTDEV
root@changeme:~# partprobe /dev/$TGTDEV
root@changeme:~# sgdisk -C -e -G /dev/$TGTDEV
root@changeme:~# partprobe /dev/$TGTDEV
# create a new partition table
root@changeme:~# cgpt create /dev/$TGTDEV
# create the two kernel partitions
root@changeme:~# cgpt add -i 1 -t kernel -b 8192 -s 65536 -l KernelA -S 1 -T 2 -P 10 /dev/$TGTDEV
root@changeme:~# cgpt add -i 2 -t kernel -b 73728 -s 65536 -l KernelB -S 0 -T 2 -P 5 /dev/$TGTDEV
# for veyron the following four lines should be used instead of the two above:
# root@changeme:~# cgpt add -i 1 -t kernel -b 73728 -s 32768 -l KernelA -S 1 -T 2 -P 10 /dev/$TGTDEV
# root@changeme:~# cgpt repair /dev/$TGTDEV
# root@changeme:~# cgpt add -i 2 -t kernel -b 106496 -s 32768 -l KernelB -S 0 -T 2 -P 5 /dev/$TGTDEV
# root@changeme:~# cgpt repair /dev/$TGTDEV
# get the config for the remaining partitions - use the link for your system
# but in theory all arm chromebooks should use the same setup here
root@changeme:~# wget https://raw.githubusercontent.com/hexdump0815/imagebuilder/main/systems/chromebook_veyron/gpt-partitions.txt
# create the boot and root partitions according to it
root@changeme:~# fdisk /dev/$TGTDEV < gpt-partitions.txt
# create the boot and root filesystems and mount them
root@changeme:~# mkfs -t ext4 -O ^has_journal -m 0 -L bootemmc /dev/${TGTDEV}p3
root@changeme:~# mkfs -t btrfs -m single -L rootemmc /dev/${TGTDEV}p4
root@changeme:~# mount -o ssd,compress-force=zstd,noatime,nodiratime /dev/${TGTDEV}p4 /mnt
root@changeme:~# mkdir -p /mnt/boot
root@changeme:~# mount /dev/${TGTDEV}p3 /mnt/boot
# copy the kernel partition to the target emmc
# the second kernel partition is by default unused initially
root@changeme:~# dd if=/dev/${SRCDEV}p1 of=/dev/${TGTDEV}p1 bs=1024k status=progress
# sync over the boot and root filesystems
root@changeme:~# rsync -axADHSX --no-inc-recursive --delete /boot/ /mnt/boot
root@changeme:~# rsync -axADHSX --no-inc-recursive --delete --exclude='/swap/*' / /mnt
# create a new 2gb swapfile
root@changeme:~# rm -rf /mnt/swap
root@changeme:~# btrfs subvolume create /mnt/swap
root@changeme:~# chmod 755 /mnt/swap
root@changeme:~# chattr -R +C /mnt/swap
root@changeme:~# btrfs property set /mnt/swap compression none
root@changeme:~# cd /mnt/swap
root@changeme:~# truncate -s 0 ./file.0; btrfs property set ./file.0 compression none; fallocate -l 2G file.0; chmod 600 ./file.0; mkswap -L file.0 ./file.0
# adjust the filesystem labels in the new etc/fstab
root@changeme:~# sed -i 's,bootpart,bootemmc,g;s,rootpart,rootemmc,g' /mnt/etc/fstab
# do the same in the u-boot config file if it exists (on 32bit arm chromebooks only)
root@changeme:~# sed -i 's,rootpart,rootemmc,g' /mnt/boot/extlinux/extlinux.conf
# umount everything
root@changeme:~# umount /mnt/boot /mnt
```
now after a shutdown the sd card/usb can be taken out/diconnected and the
system should boot into linux from emmc on the next boot.

# What now?

now after the system is installed onto memory you can look into [what next](./post-installation.md) you can do on your device