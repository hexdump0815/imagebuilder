#!/bin/bash

cd `dirname $0`/..
export WORKDIR=`pwd`

. scripts/args-and-arch-check-functions.sh

export BUILD_ROOT=/compile/local/imagebuilder-root
export DOWNLOAD_DIR=/compile/local/imagebuilder-download
export IMAGE_DIR=/compile/local/imagebuilder-diskimage
export MOUNT_POINT=/tmp/imagebuilder-mnt

# check that everything is there and set
if [ ! -f systems/${1}/mbr-partitions.txt ] && [ ! -f systems/${1}/gpt-partitions.txt ]; then
  echo ""
  echo "systems/${1}/mbr-partitions.txt or systems/${1}/gpt-partitions.txt does not exist - giving up"
  echo ""
  exit 1
fi
if [ ! -f systems/${1}/partition-mapping.txt ]; then
  echo ""
  echo "systems/${1}/partition-mapping.txt does not exist - giving up"
  echo ""
  exit 1
else
  # get partition mapping info
  . systems/${1}/partition-mapping.txt
  # check that all required variables are set
  if [ "$BOOTFS" != "" ]; then
    echo "BOOTFS=$BOOTFS"
  else
    echo ""
    echo "BOOTFS is not set in systems/${1}/partition-mapping.txt - giving up"
    echo ""
    exit
  fi
  if [ "$ROOTFS" != "" ]; then
    echo "ROOTFS=$ROOTFS"
  else
    echo ""
    echo "ROOTFS is not set in systems/${1}/partition-mapping.txt - giving up"
    echo ""
    exit
  fi
  if [ "$ROOTFS" = "btrfs" ]; then
    if [ ! -x /bin/mkfs.btrfs ]; then
      echo ""
      echo "/bin/mkfs.btrfs is not available - please install the btrfs-progs package"
      echo ""
      exit 1
    fi
  fi
  if [ "$BOOTPART" != "" ]; then
    echo "BOOTPART=$BOOTPART"
  else
    echo ""
    echo "BOOTPART is not set in systems/${1}/partition-mapping.txt - giving up"
    echo ""
    exit
  fi
  if [ "$ROOTPART" != "" ]; then
    echo "ROOTPART=$ROOTPART"
  else
    echo ""
    echo "ROOTPART is not set in systems/${1}/partition-mapping.txt - giving up"
    echo ""
    exit
  fi
  if [ "$SWAPPART" != "" ]; then
    echo "SWAPPART=$SWAPPART"
  else
    echo ""
    echo "INFO: SWAPPART is not set in systems/${1}/partition-mapping.txt - this is ok"
    echo ""
  fi
fi

mkdir -p ${IMAGE_DIR}
mkdir -p ${MOUNT_POINT}

if [ -f ${IMAGE_DIR}/${1}-${2}-${3}.img ]; then
  echo ""
  echo "image file ${IMAGE_DIR}/${1}-${2}-${3}.img already exists - giving up for safety reasons ..."
  echo ""
  exit 1
fi

# we use less than the marketing capacity of the sd card as it is usually lower in reality 3.5/5.5gb
truncate -s 0 ${IMAGE_DIR}/${1}-${2}-${3}.img
# the compressed btrfs root needs less space on disk
if [ "$ROOTFS" = "btrfs" ]; then
  fallocate -l 3.5G ${IMAGE_DIR}/${1}-${2}-${3}.img
else
  fallocate -l 5.5G ${IMAGE_DIR}/${1}-${2}-${3}.img
fi

losetup /dev/loop0 ${IMAGE_DIR}/${1}-${2}-${3}.img

# the arm chromebooks have some special boot partition setup
if [ "$1" = "chromebook_snow" ] || [ "$1" = "chromebook_veyron" ] || \
   [ "$1" = "chromebook_nyan" ] || [ "$1" = "chromebook_elm" ] || \
   [ "$1" = "chromebook_kukui" ] || [ "$1" = "chromebook_peach" ]; then

  # the fllowing part is based on
  # https://github.com/eballetbo/chromebooks/blob/master/chromebook-setup.sh
  # https://github.com/Maccraft123/Cadmium/blob/master/fs/install-to-emmc-begin

  # clear the partition table and reread it via partprobe
  sgdisk -Z /dev/loop0
  partprobe /dev/loop0

  # create a fresh partition table and reread it via partprobe
  sgdisk -C -e -G /dev/loop0
  partprobe /dev/loop0

  # create the chomeos partition structure and reread it via partprobe
  cgpt create /dev/loop0
  partprobe /dev/loop0

  # create two boot partitions and set them as bootable
  # two to have a second one to play around just in case - it just costs 32m
  cgpt add -i 1 -t kernel -b 8192 -s 65536 -l KernelA -S 1 -T 2 -P 10 /dev/loop0
  cgpt add -i 2 -t kernel -b 73728 -s 65536 -l KernelB -S 0 -T 2 -P 5 /dev/loop0

# for all others the boot block is simply written to the beginning of the disk image
else
  if [ -f ${DOWNLOAD_DIR}/boot-${1}-${2}.dd ]; then
    dd if=${DOWNLOAD_DIR}/boot-${1}-${2}.dd of=/dev/loop0
  fi
fi

# inspired by https://github.com/jeromebrunet/libretech-image-builder/blob/libretech-cc-xenial-4.13/linux-image.sh
if [ -f systems/${1}/mbr-partitions.txt ]; then
  fdisk /dev/loop0 < systems/${1}/mbr-partitions.txt
elif [ -f systems/${1}/gpt-partitions.txt ]; then
  fdisk /dev/loop0 < systems/${1}/gpt-partitions.txt
fi

# this is to make sure we really use the new partition table and have all partitions around
partprobe /dev/loop0
losetup -d /dev/loop0
losetup --partscan /dev/loop0 ${IMAGE_DIR}/${1}-${2}-${3}.img

# for chromebooks write the kernel to the first kernel partition
if [ "$1" = "chromebook_snow" ] || [ "$1" = "chromebook_veyron" ] || \
   [ "$1" = "chromebook_nyan" ] || [ "$1" = "chromebook_elm" ] || \
   [ "$1" = "chromebook_kukui" ] || [ "$1" = "chromebook_peach" ]; then
  dd if=${DOWNLOAD_DIR}/boot-${1}-${2}.dd of=/dev/loop0p1 status=progress
fi

if [ "$BOOTFS" = "fat" ]; then
  mkfs.vfat -F32 -n BOOTPART /dev/loop0p$BOOTPART
elif [ "$BOOTFS" = "ext4" ]; then
  mkfs -t ext4 -O ^has_journal -m 0 -L bootpart /dev/loop0p$BOOTPART
fi

if [ "$ROOTFS" = "btrfs" ]; then
  mkfs -t btrfs -m single -L rootpart /dev/loop0p$ROOTPART
  mount -o ssd,compress-force=zstd,noatime,nodiratime /dev/loop0p$ROOTPART ${MOUNT_POINT}
else
  mkfs -t ext4 -O ^has_journal -m 2 -L rootpart /dev/loop0p$ROOTPART
  mount /dev/loop0p$ROOTPART ${MOUNT_POINT}
fi
mkdir ${MOUNT_POINT}/boot
mount /dev/loop0p$BOOTPART ${MOUNT_POINT}/boot

echo "copying over the root fs to the target image - this may take a while ..."
date
rsync -axADHSX --no-inc-recursive ${BUILD_ROOT}/ ${MOUNT_POINT}
date
echo "done"

if [ "$SWAPPART" != "" ]; then
  mkswap -L swappart /dev/loop0p$SWAPPART
else
  if [ "$ROOTFS" = "btrfs" ]; then
    btrfs subvolume create ${MOUNT_POINT}/swap
    chmod 755 ${MOUNT_POINT}/swap
    chattr -R +C ${MOUNT_POINT}/swap
    btrfs property set ${MOUNT_POINT}/swap compression none
  else
    mkdir ${MOUNT_POINT}/swap
  fi
  truncate -s 0 ${MOUNT_POINT}/swap/file.0
  if [ "$ROOTFS" = "btrfs" ]; then
    btrfs property set ${MOUNT_POINT}/swap/file.0 compression none
  fi
  fallocate -l 512M ${MOUNT_POINT}/swap/file.0
  chmod 600 ${MOUNT_POINT}/swap/file.0
  mkswap -L swapfile.0 ${MOUNT_POINT}/swap/file.0
  sed -i 's,LABEL=swappart,/swap/file.0,g' ${MOUNT_POINT}/etc/fstab
fi

# create a customized fstab file
FSTAB_EXT4_BOOT="LABEL=bootpart /boot ext4 defaults,noatime,nodiratime,errors=remount-ro 0 2"
FSTAB_VFAT_BOOT="LABEL=BOOTPART /boot vfat defaults,rw,owner,flush,umask=000 0 0"
FSTAB_BTRFS_ROOT="LABEL=rootpart / btrfs defaults,ssd,compress-force=zstd,noatime,nodiratime 0 1"
FSTAB_EXT4_ROOT="LABEL=rootpart / ext4 defaults,noatime,nodiratime,errors=remount-ro 0 1"
FSTAB_SWAP_FILE="/swap/file.0 none swap sw 0 0"
FSTAB_SWAP_PART="LABEL=swappart none swap sw 0 0"

if [ "$BOOTFS" = "ext4" ]; then
  echo $FSTAB_EXT4_BOOT > ${MOUNT_POINT}/etc/fstab
else
  echo $FSTAB_VFAT_BOOT > ${MOUNT_POINT}/etc/fstab
fi
if [ "$ROOTFS" = "btrfs" ]; then
  echo $FSTAB_BTRFS_ROOT >> ${MOUNT_POINT}/etc/fstab
else
  echo $FSTAB_EXT4_ROOT >> ${MOUNT_POINT}/etc/fstab
fi
if [ "$SWAPPART" = "" ]; then
  echo $FSTAB_SWAP_FILE >> ${MOUNT_POINT}/etc/fstab
else
  echo $FSTAB_SWAP_PART >> ${MOUNT_POINT}/etc/fstab
fi

export KERNEL_VERSION=`ls ${BUILD_ROOT}/boot/*Image-* | sed 's,.*Image-,,g' | sort -u`
if [ "$PARTUUID_ROOT" = "YES" ]; then
  ROOT_PARTUUID=$(blkid | grep "/dev/loop0p$ROOTPART" | awk '{print $5}' | sed 's,",,g')
  if [ -f ${MOUNT_POINT}/boot/extlinux/extlinux.conf ]; then
    sed -i "s,ROOT_PARTUUID,$ROOT_PARTUUID,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
    sed -i "s,KERNEL_VERSION,$KERNEL_VERSION,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
  fi
  if [ -f ${MOUNT_POINT}/boot/menu/extlinux.conf ]; then
    sed -i "s,ROOT_PARTUUID,$ROOT_PARTUUID,g" ${MOUNT_POINT}/boot/menu/extlinux.conf
    sed -i "s,KERNEL_VERSION,$KERNEL_VERSION,g" ${MOUNT_POINT}/boot/menu/extlinux.conf
  fi
  if [ -f ${MOUNT_POINT}/boot/uEnv.ini ]; then
    sed -i "s,ROOT_PARTUUID,$ROOT_PARTUUID,g" ${MOUNT_POINT}/boot/uEnv.ini
    sed -i "s,KERNEL_VERSION,$KERNEL_VERSION,g" ${MOUNT_POINT}/boot/uEnv.ini
  fi
else
  if [ -f ${MOUNT_POINT}/boot/extlinux/extlinux.conf ]; then
    sed -i "s,ROOT_PARTUUID,LABEL=rootpart,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
    sed -i "s,KERNEL_VERSION,$KERNEL_VERSION,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
  fi
  if [ -f ${MOUNT_POINT}/boot/menu/extlinux.conf ]; then
    sed -i "s,ROOT_PARTUUID,LABEL=rootpart,g" ${MOUNT_POINT}/boot/menu/extlinux.conf
    sed -i "s,KERNEL_VERSION,$KERNEL_VERSION,g" ${MOUNT_POINT}/boot/menu/extlinux.conf
  fi
  if [ -f ${MOUNT_POINT}/boot/uEnv.ini ]; then
    sed -i "s,ROOT_PARTUUID,LABEL=rootpart,g" ${MOUNT_POINT}/boot/uEnv.ini
    sed -i "s,KERNEL_VERSION,$KERNEL_VERSION,g" ${MOUNT_POINT}/boot/uEnv.ini
  fi
fi

# for the orbsmart s92 / beelink r89 the boot loader has to be written in a special way to the disk
if [ "$1" = "orbsmart_s92_beelink_r89" ]; then
  ${WORKDIR}/scripts/orbsmart_s92_beelink_r89-prepare-boot.sh ${KERNEL_VERSION}
  ${WORKDIR}/scripts/orbsmart_s92_beelink_r89-create-boot.sh
fi

# for the amlogic m8x we will have to shorten the kernel and initrd filenames due to a 23 char limit
if [ "$1" = "amlogic_m8" ]; then
  ${MOUNT_POINT}/boot/shorten-filenames.sh
fi

df -h ${MOUNT_POINT} ${MOUNT_POINT}/boot
umount ${MOUNT_POINT}/boot 
umount ${MOUNT_POINT}

losetup -d /dev/loop0

rmdir ${MOUNT_POINT}

echo ""
echo "the image is now ready at ${IMAGE_DIR}/${1}-${2}-${3}.img"
echo ""
