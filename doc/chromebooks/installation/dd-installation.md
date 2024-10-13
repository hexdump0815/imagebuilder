# This is a legacy method

it is not recommended unless if directly fits your usecase

### regular dd installation (all chromebooks except veyron)
_Note. look below for veyron variant_

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

### veyron is special

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

after booting the system you can run ```/scripts/extend-rootfs.sh``` as root to extend rootfs onto the entire disk