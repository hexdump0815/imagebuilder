#!/bin/bash -x

if [ "$#" != "3" ]; then
  echo ""
  echo "usage: $0 system armversion ubuntu/debian"
  echo ""
  echo "possible system options:"
  echo "- chromebook_snow (armv7l)"
  echo "- odroid_u3 (armv7l)"
  echo ""
  echo "possible armversion options:"
  echo "- armv7l (32bit) userland"
  echo "- aarch64 (64bit) userland"
  echo ""
  exit 1
fi

export BUILD_ROOT=/compile/local/imagebuilder-root
export IMAGE_DIR=/compile/local/imagebuilder-diskimage
export MOUNT_POINT=/mnt

cd `dirname $0`/..
export WORKDIR=`pwd`

# check that everything is there and set
if [ ! -f files/mbr-partitions-${1}-${2}.txt ] && [ ! -f files/gpt-partitions-${1}-${2}.txt ]; then
  echo ""
  echo "files/mbr-partitions-${1}-${2}.txt or files/gpt-partitions-${1}-${2}.txt does not exist - giving up"
  echo ""
  exit 1
fi
if [ ! -f files/partition-mapping-${1}-${2}.txt ]; then
  echo ""
  echo "files/partition-mapping-${1}-${2}.txt does not exist - giving up"
  echo ""
  exit 1
else
  # get partition mapping info
  . files/partition-mapping-${1}-${2}.txt
  # check that all required variables are set
  if [ "$BOOTFS" != "" ]; then
    echo "BOOTFS=$BOOTFS"
  else
    echo ""
    echo "BOOTFS is not set in files/partition-mapping-${1}-${2}.txt - giving up"
    echo ""
    exit
  fi
  if [ "$BOOTPART" != "" ]; then
    echo "BOOTPART=$BOOTPART"
  else
    echo ""
    echo "BOOTPART is not set in files/partition-mapping-${1}-${2}.txt - giving up"
    echo ""
    exit
  fi
  if [ "$ROOTPART" != "" ]; then
    echo "ROOTPART=$ROOTPART"
  else
    echo ""
    echo "ROOTPART is not set in files/partition-mapping-${1}-${2}.txt - giving up"
    echo ""
    exit
  fi
  if [ "$SWAPPART" != "" ]; then
    echo "SWAPPART=$SWAPPART"
  else
    echo ""
    echo "SWAPPART is not set in files/partition-mapping-${1}-${2}.txt - giving up"
    echo ""
    exit
  fi
fi

mkdir -p ${IMAGE_DIR}

# we use less than the marketing capacity of the sd card as it is usually lower in reality
# 7g for an 8g card and 14g for a 16g card - it can easily be extended to full size later
dd if=/dev/zero of=${IMAGE_DIR}/${1}-${2}-${3}.img bs=1024k count=1 seek=$((7*1024)) status=progress
#dd if=/dev/zero of=${IMAGE_DIR}/${1}-${2}-${3}.img bs=1024k count=1 seek=$((14*1024)) status=progress

losetup /dev/loop0 ${IMAGE_DIR}/${1}-${2}-${3}.img

if [ -f ${WORKDIR}/boot/boot-${1}-${2}.dd ]; then
  dd if=${WORKDIR}/boot/boot-${1}-${2}.dd of=/dev/loop0
fi

# for the chromebook snow an initial partition table is already in the boot.dd which needs to be fixed up now
if [ "$1" = "chromebook_snow" ]; then
  # fix
  sgdisk -C -e -G /dev/loop0
  # verify
  sgdisk -v /dev/loop0
fi

# old way ...
# input file created with sfdisk -d ...
# sfdisk ${IMAGE_DIR}/${1}-${2}-${3}.img < files/dos-partitions-${1}-${2}.txt
# new way - inspired by https://github.com/jeromebrunet/libretech-image-builder/blob/libretech-cc-xenial-4.13/linux-image.sh
if [ -f files/mbr-partitions-${1}-${2}.txt ]; then
  fdisk /dev/loop0 < files/mbr-partitions-${1}-${2}.txt
elif [ -f files/gpt-partitions-${1}-${2}.txt ]; then
  fdisk /dev/loop0 < files/gpt-partitions-${1}-${2}.txt
fi

# this is to make sure we really use the new partition table and have all partitions around
partprobe /dev/loop0
losetup -d /dev/loop0
losetup --partscan /dev/loop0 ${IMAGE_DIR}/${1}-${2}-${3}.img

if [ "$BOOTFS" = "fat" ]; then
  mkfs -t fat -F32 -n bootpart /dev/loop0p$BOOTPART
elif [ "$BOOTFS" = "ext4" ]; then
  mkfs -t ext4 -O ^has_journal -m 0 -L bootpart /dev/loop0p$BOOTPART
fi
mkswap -L swappart /dev/loop0p$SWAPPART
mkfs -t ext4 -O ^has_journal -L rootpart /dev/loop0p$ROOTPART

mount /dev/loop0p$ROOTPART ${MOUNT_POINT}
mkdir ${MOUNT_POINT}/boot
mount /dev/loop0p$BOOTPART ${MOUNT_POINT}/boot

rsync -a ${BUILD_ROOT}/ ${MOUNT_POINT}

ROOT_PARTUUID=$(blkid | grep "/dev/loop0p$ROOTPART" | awk '{print $5}' | sed 's,",,g')

if [ -f ${MOUNT_POINT}/boot/extlinux/extlinux.conf ]; then
  sed -i "s,ROOT_PARTUUID,$ROOT_PARTUUID,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
fi
if [ -f ${MOUNT_POINT}/boot/menu/extlinux.conf ]; then
  sed -i "s,ROOT_PARTUUID,$ROOT_PARTUUID,g" ${MOUNT_POINT}/boot/menu/extlinux.conf
fi

umount ${MOUNT_POINT}/boot 
umount ${MOUNT_POINT}

losetup -d /dev/loop0

echo ""
echo "the image is now ready at ${IMAGE_DIR}/${1}-${2}-${3}.img"
echo ""
