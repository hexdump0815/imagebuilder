# The regular installation

in this approach we do not dump the image file onto the emmc but instead simply sync the contents of the running system onto newly created filesystems on the emmc. the advantages over legacy dd installation are:
- internet not required - no network connection required and the running system has everything required
- ability to preconfigure - the running image can already be a bit preconfigured and all changes to it will also be synced to emmc (maybe useful when installing on multiple identical systems)
- no uuid conflict - the filesystems on the emmc will get new filesystem uuids and also the labels of the filesystems can be easily adjusted, so no risk of a conflict with a booted rescue system from sd card/usb

_Note. **before proceeding** with installation it is recommended to first [set gbb flags](../setting_gbb_flags.md)_

## Time to just do it

_Important. it is asummed you do all this as root use ```su root``` or ```sudo -i``` (root password is "changeme")_

1. start by listing all available disks

```
lsblk
```
the output should look like this
```
NAME         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
mtdblock0     31:0    0     8M  0 disk 
sda          179:0    0 116,5G  0 disk <- this is the booted drive
├─sda1       179:1    0    64M  0 part <- this is a partition
├─sda2       179:2    0    64M  0 part 
├─sda3       179:3    0   512M  0 part /boot
├─sda4       179:4    0 107,9G  0 part / <- it has current root partition
└─sda5       179:5    0     8G  0 part 
mmcblk1      179:0    0 116,5G  0 disk <- this is an internal disk
├─mmcblk1p1  179:1    0    64M  0 part <- this is a partition
├─mmcblk1p2  179:2    0    64M  0 part 
├─mmcblk1p3  179:3    0   512M  0 part
├─mmcblk1p4  179:4    0 107,9G  0 part
└─mmcblk1p5  179:5    0     8G  0 part 
mmcblk1boot0 179:32   0     4M  1 disk 
mmcblk1boot1 179:64   0     4M  1 disk
```

_Tip. the chromebook partiotion will be the one without partition with "/"_

emmc disks can usually easily identified by the fact that there are also the following two (not to be used) devices for them as well: mmcblkxboot0, mmcblkxboot1

_Note. the internal memory is often (but not always) ```mmcblk1``` or ```mmcblk0``` but_

2. Export the target disk

if you want to install onto ```mmcblk0``` or ```mmcblk1``` (number is diffent on diffrent chromebooks)
```
export disk=mmcblk0
export part=mmcblk0p
```
or
```
export disk=mmcblk1
export part=mmcblk1p
```
respecitively

if you want to install on sda or similar
```
export disk=sda
export part=sda
```

3. Export the source disk

if the booted device is ```mmcblk0``` or ```mmcblk1``` (number is diffent on diffrent chromebooks)
```
export srcPart=mmcblk0p
```
or
```
export srcPart=mmcblk1p
```
respecitively

if the booted device is sda or similar
```
export srcPart=sda
```


4. Wipe the partition table on the target disk
```
sgdisk -Z /dev/$disk
partprobe /dev/$disk
sgdisk -C -e -G /dev/$disk
partprobe /dev/$disk
```
5. Create a new partition table
```
cgpt create /dev/$disk
```
6. Create the two kernel partitions
```
cgpt add -i 1 -t kernel -b 8192 -s 65536 -l KernelA -S 1 -T 2 -P 10 /dev/$disk
cgpt add -i 2 -t kernel -b 73728 -s 65536 -l KernelB -S 0 -T 2 -P 5 /dev/$disk
```

_Note. on veyron you need to run ```cgpt repair /dev/$disk``` after each command_

7. Create remaining partitions
```
wget https://raw.githubusercontent.com/hexdump0815/imagebuilder/main/systems/chromebook_veyron/gpt-partitions.txt
```
_Note. but in theory all arm chromebooks should use the same setup here_
```
fdisk /dev/$disk < gpt-partitions.txt
```
8. Create the boot and root filesystems and mount them
```
mkfs -t ext4 -O ^has_journal -m 0 -L bootemmc /dev/${part}3
mkfs -t btrfs -m single -L rootemmc /dev/${part}4
mount -o ssd,compress-force=zstd,noatime,nodiratime /dev/${part}4 /mnt
mkdir -p /mnt/boot
mount /dev/${part}3 /mnt/boot
```
9. copy the kernel partition to the target emmc
```
dd if=/dev/${srcPart}1 of=/dev/${part}1 bs=1024k status=progress
```
_Note. the second kernel partition is by default unused initially_

10. sync over the boot and root filesystems
```
rsync -axADHSX --no-inc-recursive --delete /boot/ /mnt/boot
rsync -axADHSX --no-inc-recursive --delete --exclude='/swap/*' / /mnt
```
11. create a new 2gb swapfile (optional)
```
rm -rf /mnt/swap
btrfs subvolume create /mnt/swap
chmod 755 /mnt/swap
chattr -R +C /mnt/swap
btrfs property set /mnt/swap compression none
cd /mnt/swap
truncate -s 0 ./file.0; btrfs property set ./file.0 compression none; fallocate -l 2G file.0; chmod 600 ./file.0; mkswap -L file.0 ./file.0
```
_Note. you can also create a swap partition_

12.  adjust the filesystem labels in the new etc/fstab
```
sed -i 's,bootpart,bootemmc,g;s,rootpart,rootemmc,g' /mnt/etc/fstab
```
13.  do the same in the u-boot config file if it exists (on 32bit arm chromebooks only)
```
sed -i 's,rootpart,rootemmc,g' /mnt/boot/extlinux/extlinux.conf
```
14.  umount everything
```
umount /mnt/boot /mnt
```
now after a shutdown the sd card/usb can be taken out/diconnected and the system should boot into linux from emmc on the next boot.

# What now?

now after the system is installed onto memory you might want to [tweak it a lil bit](../post-installation.md)