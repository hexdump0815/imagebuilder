# installing on emmc on arm chromebooks

## disclaimer

lets start with a disclaimer: this document describes how to install the
content of thses linux images onto the internal storage (mostly emmc,
in the future maybe sometimes nvme) of an arm chromebook. this means that
everything on the internal storage will be deleted and is lost and one should
backup all data from the internal storage which should be kept to a safe
place. on arm chromebooks the images discussed here will still use the default
chromebook bootloader (which is not located on the emmc/nvme storage, but in a
small extra storage device and thus will not be harmed by the installtion) and
as a result of that and basic design of chromebooks it is always possible to
restore chromeos on them with not too much effort - for more information about
the restoration process one can have a look here:
https://support.google.com/chromebook/answer/1080595?hl=en

## overview

this document will describe different methods of how to get a successfully
booted image installed onto the internal storage of the chromebook. please
note that everything described here is only valid for arm chromebooks as the
typical boot setup for intel chromebooks is usually different resulting in
changes required to the process.

the methods described are:

- the easiest approach is to simply download the image file to the booted
  image system and write it to emmc via dd just like it maybe was written to
the sd card before, this approach is easy and fast but also has some drawbacks
- the next more complex approach is to partition the internal storage from the
  booted imagei, create filesystems on those partitions and then sync all data
to those freshly created filesystems, this approach requires a slight bit more
work but has some advantages and is the way i would recommend
- the most complex approach also gives the best and most secure result as the
  rootfs on the internal storage will be encrypted, the process is of the
installation is similar to the last approach with some steps required for the
encryption added on top of it

this document is in the end the steps required to install to emmc on arm
chromebooks extracted from the somewhat harder to read document
install-to-emmc-with-luks-full-disk-encryption.txt and brought into an easier
to read form.

## preparations

first it is required to find out the device the booted image is running on and
the device name of the internal storage. for this the following should be done
in a terminal:
```
# get root
sudo -i
password: (the default password of a freshly booted image is "changeme")
# show all relevant devices
root@changeme:~# ls -d /dev/mmcblk* /dev/sd* | cat
/dev/mmcblk0
/dev/mmcblk0boot0
/dev/mmcblk0boot1
/dev/mmcblk0p1
...
/dev/mmcblk0p12
/dev/mmcblk0rpmb
/dev/sda
/dev/sda1
/dev/sda2
/dev/sda3
/dev/sda4
# check which device is mounted on /boot
root@changeme:~# df -h /boot
/dev/sda3         504M   68M  426M  14% /boot
root@changeme:~# fdisk -l
Disk /dev/mmcblk0: 29.12 GiB, 31268536320 bytes, 61071360 sectors
Units: sectors of 1 * 512 = 512 bytes
...
```
this output shows us the following: the internal emmc device here is mmcblk0
as it can be identified by the existing boot0/boot1/rpmb partitions for it as
well - it does not always have to be 0, also other numbers are possible like
mmcblk1 or mmcblk2. in case of chromeos still being on the device then it
usually has around 12 partitions (p1...p12). this will be the target device of
the installation called TGTDEV below.

besides that we can see another disk device sda here which can be a usb drive
or an sd card reader internally connected in a certain way. it does not have
to be a sdx device, but also can be a mmcblkx device - for instance mmcblk1.
this device does not have the boot0/boot1/rpmb partitions and thus is for sure
not the emmc - instead it has four partitions: 1...4 for sdx or p1..p4 for
mmcblkx and this is how the booted image looks like. this will be the source
device of the installation call SRCDEV below. the df command output also helps
to identify this as the device the image is booted from as the /boot partition
of the running system is mounted from it. the fdisk command can help in some
cases to find out which device is which based on the shown sizes.

two more important notes: first if the chromebook you want to install to is a
veryon, then make sure to read the section about veyron below as some things
are a bit special for this device. the other note is that i would definitely
recommend to remove the write protect screw in the chromebooks (for older
devices) or to ccd open it (for newer devices if a suzyqable required for this
is at hand) and set the gbb flags to 0x19 as described in the corresponding
sections here:
https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks - especially
the older chromebooks tend to forget all their dev mode, allow boot from usb,
no beep etc. settings when the battery drains completely and the only way to
get out of this is to restore chromeos via restore disk and set everything
there again, which will overwrite all data on your emmc, so no chance to
access the data beforehand anymore in such a situation - setting the gbbflags
will set the chromebook to dev mode, allow boot from usb, no beep etc. as
default in hardware - so even if it forgets everything, those settings will
still be intact and you can boot from usb/sd at any time and you will not
loose dev mode by accident this way. if setting the gbb flags is not an
option (for instance because there is no suzyqable available for a newer
chromebook) then always back up all the important data you have on your
linux system on the internal drive to a safe place - i think this is good
practice in general as storage hardware can always fail resulting in data
loss.

## very simple approach: dd to emmc

the easiest way to install the image to emmc is to simply boot it from sd/usb,
extend the rootfs, download the image file onto it and then write it to emmc
from there. as there is a slight risk of the used btrfs filesystem getting
confused by being around twice with the same filesystem uuid it is recommended
to boot the second newest image to write the newest one - this way it is made
sure that both have a different btrfs filesystem uuid as this uuid is generate
new for each created image. it might even be possible to use the same image,
but it is safer to do it with two different images as described. an example
session in the terminal for this procedure could look like (a working network
connection is required at this time, be it wifi or usb ethernet):
```
# get root
sudo -i
password: (the default password of a freshly booted image is "changeme")
# extend the rootfs to the full size of the sd card/usb to have space
root@changeme:~# /scripts/extend-rootfs.sh
# get the image from the corresponding github imagebuilder release page
# example here is the latest nyan image
root@changeme:~# wget https://github.com/hexdump0815/imagebuilder/releases/download/230218-04/chromebook_nyan-armv7l-bookworm.img.gz
# define the target device depending on what was found out above
# example here: target is /dev/mmcblk0
root@changeme:~# export TGTDEV=mmcblk0
# write the image to emmc
root@changeme:~# zcat chromebook_nyan-armv7l-bookworm.img.gz | dd of=/dev/$TGTDEV bs=1024k status=progress
# do any potential special u-boot writing for your device to the emmc
# as well in case it was required for the sd card before
```
now after a shutdown the sd card/usb can be taken out/diconnected and the
system should boot into linux from emmc on the next boot.

## veyron is special

for veyron (= rk3288 based) chromebooks for some strange reason the beginning
of the emmc cannot be written to which also results in the primary gpt
partition table having to be ignored on those devices. the workaround here is
to simply create the kernel partitions a bit further into the emmc device and
fix the gpt partition table so that at least its copy at the end of the disk
is correct. as a result the dd workflow from above is getting more complex as
the partitions have to be created and fixed properly by hand on emmc and then
the partitions have to be dumped one by one to them.
```
# get root
sudo -i
password: (the default password of a freshly booted image is "changeme")
# extend the rootfs to the full size of the sd card/usb to have space
root@changeme:~# /scripts/extend-rootfs.sh
# get the image from the corresponding github imagebuilder release page
# this is about veyron, so lets get the latest image for it
root@changeme:~# wget https://github.com/hexdump0815/imagebuilder/releases/download/230218-05/chromebook_veyron-armv7l-bookworm.img.gz
# uncompress the image, so at least 6gb of free space is required
root@changeme:~# gunzip -v chromebook_veyron-armv7l-bookworm.img.gz
# define the target device depending on what was found out above
# example here: target is /dev/mmcblk0
root@changeme:~# export TGTDEV=mmcblk0
# wipe the partition table on the target disk
root@changeme:~# sgdisk -Z /dev/$TGTDEV
root@changeme:~# partprobe /dev/$TGTDEV
root@changeme:~# sgdisk -C -e -G /dev/$TGTDEV
root@changeme:~# partprobe /dev/$TGTDEV
# create a new partition table and the two special kernel partitions
root@changeme:~# cgpt create /dev/$TGTDEV
root@changeme:~# cgpt add -i 1 -t kernel -b 73728 -s 32768 -l KernelA -S 1 -T 2 -P 10 /dev/$TGTDEV
root@changeme:~# cgpt repair /dev/$TGTDEV
root@changeme:~# cgpt add -i 2 -t kernel -b 106496 -s 32768 -l KernelB -S 0 -T 2 -P 5 /dev/$TGTDEV
root@changeme:~# cgpt repair /dev/$TGTDEV
# get the config for the remaining partitions
root@changeme:~# wget https://raw.githubusercontent.com/hexdump0815/imagebuilder/main/systems/chromebook_veyron/gpt-partitions.txt
# create the boot and root partitions according to it
root@changeme:~# fdisk /dev/$TGTDEV < gpt-partitions.txt
# mount the image as loop device
root@changeme:~# losetup --partscan /dev/loop0 chromebook_veyron-armv7l-bookworm.img
# copy the kernel, boot and root partition to the target emmc
# the second kernel partition is by default unused initially
root@changeme:~# dd if=/dev/loop0p1 of=/dev/${TGTDEV}p1 bs=1024k status=progress
root@changeme:~# dd if=/dev/loop0p3 of=/dev/${TGTDEV}p3 bs=1024k status=progress
root@changeme:~# dd if=/dev/loop0p4 of=/dev/${TGTDEV}p4 bs=1024k status=progress
# unmount the image from the loop device
root@changeme:~# losetup -d /dev/loop0
# do any potential special u-boot writing for your device to the emmc
# as well in case it was required for the sd card before
```
now after a shutdown the sd card/usb can be taken out/diconnected and the
system should boot into linux from emmc on the next boot.

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