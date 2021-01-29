#!/bin/bash

if [ "$#" != "3" ]; then
  echo ""
  echo "usage: $0 system arch release"
  echo ""
  echo "possible system options:"
  echo "- chromebook_snow (armv7l) (not yet supported)"
  echo "- chromebook_veyron (armv7l) (not yet supported)"
  echo "- chromebook_nyan (armv7l) (not yet supported)"
  echo "- allwinner_h6 (armv7l) (not yet supported)"
  echo "- amlogic_m8 (armv7l) (not yet supported)"
  echo "- odroid_u3 (armv7l)"
  echo "- odroid_xu4 (armv7l) (not yet supported)"
  echo "- orbsmart_s92_beelink_r89 (armv7l) (not yet supported)"
  echo "- rockchip_rk322x (armv7l) (not yet supported)"
  echo "- tinkerboard (armv7l) (not yet supported)"
  echo "- raspberry_pi_2 (armv7l) (not yet supported)"
  echo "- raspberry_pi_(aarch64) (not yet supported)"
  echo "- raspberry_pi_4 (aarch64) (not yet supported)"
  echo "- amlogic_gx (aarch64)"
  echo "- allwinner_h6 (aarch64) (not yet supported)"
  echo "- rockchip_rk33xx (aarch64)"
  echo ""
  echo "possible arch options:"
  echo "- armv7l (32bit)"
  echo "- aarch64 (64bit)"
  echo ""
  echo "possible release options:"
  echo "- focal (ubuntu)"
  echo "- bullseye (debian) (not yet supported)"
  echo ""
  echo "example: $0 odroid_u3 armv7l focal"
  echo ""
  exit 1
fi

export BUILD_ROOT=/compile/local/imagebuilder-root
export IMAGE_DIR=/compile/local/imagebuilder-diskimage
export MOUNT_POINT=/tmp/imagebuilder-mnt

cd `dirname $0`/..
export WORKDIR=`pwd`

# check that everything is there and set
if [ ! -f files/systems/${1}/mbr-partitions.txt ] && [ ! -f files/systems/${1}/gpt-partitions.txt ]; then
  echo ""
  echo "files/systems/${1}/mbr-partitions.txt or files/systems/${1}/gpt-partitions.txt does not exist - giving up"
  echo ""
  exit 1
fi
if [ ! -f files/systems/${1}/partition-mapping.txt ]; then
  echo ""
  echo "files/systems/${1}/partition-mapping.txt does not exist - giving up"
  echo ""
  exit 1
else
  # get partition mapping info
  . files/systems/${1}/partition-mapping.txt
  # check that all required variables are set
  if [ "$BOOTFS" != "" ]; then
    echo "BOOTFS=$BOOTFS"
  else
    echo ""
    echo "BOOTFS is not set in files/systems/${1}/partition-mapping.txt - giving up"
    echo ""
    exit
  fi
  if [ "$ROOTFS" != "" ]; then
    echo "ROOTFS=$ROOTFS"
  else
    echo ""
    echo "ROOTFS is not set in files/systems/${1}/partition-mapping.txt - giving up"
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
    echo "BOOTPART is not set in files/systems/${1}/partition-mapping.txt - giving up"
    echo ""
    exit
  fi
  if [ "$ROOTPART" != "" ]; then
    echo "ROOTPART=$ROOTPART"
  else
    echo ""
    echo "ROOTPART is not set in files/systems/${1}/partition-mapping.txt - giving up"
    echo ""
    exit
  fi
  if [ "$SWAPPART" != "" ]; then
    echo "SWAPPART=$SWAPPART"
  else
    echo ""
    echo "INFO: SWAPPART is not set in files/systems/${1}/partition-mapping.txt - this is ok"
    echo ""
  fi
fi

mkdir -p ${IMAGE_DIR}
mkdir -p ${MOUNT_POINT}

if [ -f ${IMAGE_DIR}/${1}-${2}-${3}.img ]; then
  echo ""
  echo "image file ${IMAGE_DIR}/${1}-${2}-${3}.img alresdy exists - giving up for safety reasons ..."
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

if [ -f ${WORKDIR}/downloads/boot-${1}-${2}.dd ]; then
  dd if=${WORKDIR}/downloads/boot-${1}-${2}.dd of=/dev/loop0
fi

# for the arm chromebooks an initial partition table is already in the boot.dd which needs to be fixed up now
if [ "$1" = "chromebook_snow" ] || [ "$1" = "chromebook_veyron" ] || [ "$1" = "chromebook_nyan" ]; then
  # fix
  sgdisk -C -e -G /dev/loop0
  # verify
  sgdisk -v /dev/loop0
fi

# inspired by https://github.com/jeromebrunet/libretech-image-builder/blob/libretech-cc-xenial-4.13/linux-image.sh
if [ -f files/systems/${1}/mbr-partitions.txt ]; then
  fdisk /dev/loop0 < files/systems/${1}/mbr-partitions.txt
elif [ -f files/systems/${1}/gpt-partitions.txt ]; then
  fdisk /dev/loop0 < files/systems/${1}/gpt-partitions.txt
fi

# this is to make sure we really use the new partition table and have all partitions around
partprobe /dev/loop0
losetup -d /dev/loop0
losetup --partscan /dev/loop0 ${IMAGE_DIR}/${1}-${2}-${3}.img

if [ "$BOOTFS" = "fat" ]; then
  mkfs.vfat -F32 -n BOOTPART /dev/loop0p$BOOTPART
elif [ "$BOOTFS" = "ext4" ]; then
  mkfs -t ext4 -O ^has_journal -m 0 -L bootpart /dev/loop0p$BOOTPART
fi

if [ "$ROOTFS" = "btrfs" ]; then
  mkfs -t btrfs -L rootpart /dev/loop0p$ROOTPART
  mount -o compress-force=zstd,noatime,nodiratime /dev/loop0p$ROOTPART ${MOUNT_POINT}
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
