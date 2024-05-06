#!/bin/bash

cd `dirname $0`/..
export WORKDIR=`pwd`

. scripts/args-and-arch-check-functions-tiny.sh

# get the imagebuilder config
if [ -f scripts/imagebuilder.conf ]; then
  . scripts/imagebuilder.conf
fi

export BUILD_ROOT=/compile/local/imagebuilder-root
export DOWNLOAD_DIR=/compile/local/imagebuilder-download
export IMAGE_DIR=/compile/local/imagebuilder-diskimage
export MOUNT_POINT=/tmp/imagebuilder-mnt

if [ ! -d ${BUILD_ROOT} ]; then
  echo ""
  echo "build root dir ${BUILD_ROOT} does not exists - please run create-fs.sh first ..."
  echo ""
  exit 1
fi

if [ ! -d ${DOWNLOAD_DIR} ]; then
  echo ""
  echo "download dir ${DOWNLOAD_DIR} does not exists - please run get-files.sh first ..."
  echo ""
  exit 1
fi

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
    if [ ! -x /bin/mkfs.btrfs ] && [ ! -x /usr/sbin/mkfs.btrfs ] && [ ! -x /sbin/mkfs.btrfs ] ; then
      echo ""
      echo "mkfs.btrfs is not available - please install the btrfs-progs package"
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
  if [ "$UEFI64ARM" != "" ]; then
    echo "UEFI64ARM=$UEFI64ARM"
  fi
  if [ "$IMAGESIZETINY" != "" ]; then
    echo "IMAGESIZETINY=$IMAGESIZETINY"
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

# we use less than the marketing capacity of the sd card as it is usually lower in reality 2.0/3.0gb
# the compressed btrfs root needs less space on disk
if [ "$IMAGESIZETINY" != "" ]; then
    truncate -s ${IMAGESIZETINY} ${IMAGE_DIR}/${1}-${2}-${3}.img
else
  if [ "$ROOTFS" = "btrfs" ]; then
    truncate -s 2048M ${IMAGE_DIR}/${1}-${2}-${3}.img
  else
    truncate -s 3072M ${IMAGE_DIR}/${1}-${2}-${3}.img
  fi
fi

losetup /dev/loop0 ${IMAGE_DIR}/${1}-${2}-${3}.img

# the boot block is simply written to the beginning of the disk image
if [ -f ${DOWNLOAD_DIR}/boot-${1}-${2}.dd ]; then
  dd if=${DOWNLOAD_DIR}/boot-${1}-${2}.dd of=/dev/loop0
fi

BOOTPARTLABEL="bootpart"
ROOTPARTLABEL="rootpart"

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

if [ "$BOOTFS" = "fat" ]; then
  mkfs.vfat -F32 -n BOOTPART /dev/loop0p$BOOTPART
elif [ "$BOOTFS" = "ext2" ]; then
  mkfs -t ext2 -m 0 -L $BOOTPARTLABEL /dev/loop0p$BOOTPART
elif [ "$BOOTFS" = "ext4" ]; then
  mkfs -t ext4 -O ^has_journal -m 0 -L $BOOTPARTLABEL /dev/loop0p$BOOTPART
fi

if [ "$ROOTFS" = "btrfs" ]; then
  mkfs -t btrfs -m single -L $ROOTPARTLABEL /dev/loop0p$ROOTPART
  mount -o ssd,compress-force=zstd,noatime,nodiratime /dev/loop0p$ROOTPART ${MOUNT_POINT}
else
  mkfs -t ext4 -O ^has_journal -m 2 -L $ROOTPARTLABEL /dev/loop0p$ROOTPART
  mount /dev/loop0p$ROOTPART ${MOUNT_POINT}
fi
mkdir ${MOUNT_POINT}/boot
mount /dev/loop0p$BOOTPART ${MOUNT_POINT}/boot
if [ "${UEFI64ARM}" = "true" ]; then
  mkfs -t vfat -F 32 -n EFI /dev/loop0p1
  mkdir -p ${MOUNT_POINT}/boot/efi
  mount /dev/loop0p1 ${MOUNT_POINT}/boot/efi
fi

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
  fallocate -l 64M ${MOUNT_POINT}/swap/file.0
  chmod 600 ${MOUNT_POINT}/swap/file.0
  mkswap -L swapfile.0 ${MOUNT_POINT}/swap/file.0
  sed -i 's,LABEL=swappart,/swap/file.0,g' ${MOUNT_POINT}/etc/fstab
fi

# create a customized fstab file
cp /dev/null ${MOUNT_POINT}/etc/fstab
FSTAB_EXT4_BOOT="LABEL=$BOOTPARTLABEL /boot ext4 defaults,noatime,nodiratime,errors=remount-ro 0 2"
FSTAB_EXT2_BOOT="LABEL=$BOOTPARTLABEL /boot ext2 defaults,noatime,nodiratime,errors=remount-ro 0 2"
FSTAB_VFAT_BOOT="LABEL=BOOTPART /boot vfat defaults,rw,flush,umask=000 0 0"
FSTAB_BTRFS_ROOT="LABEL=$ROOTPARTLABEL / btrfs defaults,ssd,compress-force=zstd,noatime,nodiratime 0 1"
FSTAB_EXT4_ROOT="LABEL=$ROOTPARTLABEL / ext4 defaults,noatime,nodiratime,errors=remount-ro 0 1"
FSTAB_SWAP_FILE="/swap/file.0 none swap sw 0 0"
FSTAB_SWAP_PART="LABEL=swappart none swap sw 0 0"
if [ "${UEFI64ARM}" = "true" ]; then
  FSTAB_VFAT_EFI="LABEL=EFI /boot/efi vfat umask=0077 0 1"
  echo $FSTAB_VFAT_EFI >> ${MOUNT_POINT}/etc/fstab
fi

if [ "$BOOTFS" = "ext4" ]; then
  echo $FSTAB_EXT4_BOOT >> ${MOUNT_POINT}/etc/fstab
elif [ "$BOOTFS" = "ext2" ]; then
  echo $FSTAB_EXT2_BOOT >> ${MOUNT_POINT}/etc/fstab
else
  echo $FSTAB_VFAT_BOOT >> ${MOUNT_POINT}/etc/fstab
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

if [ "${2}" = "armv7l" ] || [ "${2}" = "aarch64" ]; then
  export KERNEL_VERSION=`ls ${BUILD_ROOT}/boot/*Image-* | sed 's,.*Image-,,g' | sort -u`
  if [ "$PARTUUID_ROOT" = "YES" ]; then
    ROOT_PARTUUID=$(blkid | grep "/dev/loop0p$ROOTPART" | awk '{print $5}' | sed 's,",,g')
    if [ -f ${MOUNT_POINT}/boot/extlinux/extlinux.conf ]; then
      sed -i "s,ROOT_PARTUUID,$ROOT_PARTUUID,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
      sed -i "s,KERNEL_VERSION,$KERNEL_VERSION,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
    fi
  else
    if [ -f ${MOUNT_POINT}/boot/extlinux/extlinux.conf ]; then
      sed -i "s,ROOT_PARTUUID,LABEL=$ROOTPARTLABEL,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
      sed -i "s,KERNEL_VERSION,$KERNEL_VERSION,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
    fi
  fi
elif [ "${2}" = "riscv64" ]; then
  export KERNEL_VERSION=`ls ${BUILD_ROOT}/boot/*Image-* | sed 's,.*Image-,,g' | sort -u`
  # in case we did not get a kernel version, try it again with the vmlinuz
  if [ "$KERNEL_VERSION" = "" ]; then
    echo "trying vmlinuz as kernel name instead of *Image:"
    export KERNEL_VERSION=`ls ${BUILD_ROOT}/boot/vmlinuz-* | sed 's,.*vmlinuz-,,g' | sort -u`
  fi
  if [ "$KERNEL_VERSION" = "" ]; then
    echo ""
    echo "no KERNEL_VERSION detected - this is most probably a problem and should be fixed"
    echo ""
  fi
  if [ "$PARTUUID_ROOT" = "YES" ]; then
    ROOT_PARTUUID=$(blkid | grep "/dev/loop0p$ROOTPART" | awk '{print $5}' | sed 's,",,g')
    if [ -f ${MOUNT_POINT}/boot/extlinux/extlinux.conf ]; then
      sed -i "s,ROOT_PARTUUID,$ROOT_PARTUUID,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
      sed -i "s,KERNEL_VERSION,$KERNEL_VERSION,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
    fi
  else
    if [ -f ${MOUNT_POINT}/boot/extlinux/extlinux.conf ]; then
      sed -i "s,ROOT_PARTUUID,LABEL=$ROOTPARTLABEL,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
      sed -i "s,KERNEL_VERSION,$KERNEL_VERSION,g" ${MOUNT_POINT}/boot/extlinux/extlinux.conf
    fi
  fi
fi

# prepare for a complete chroot env partially needed by the following steps
mount -o bind /dev ${MOUNT_POINT}/dev
mount -o bind /dev/pts ${MOUNT_POINT}/dev/pts
mount -t sysfs /sys ${MOUNT_POINT}/sys
mount -t proc /proc ${MOUNT_POINT}/proc

# do this to avoid failing apt installs due to a too old fs-cache
chroot ${MOUNT_POINT} apk update

# TODO: maybe move the update-initramfs from create-fs here ...

if [ "${UEFI64ARM}" = "true" ]; then
  # grub config script per system
  if [ -f ${WORKDIR}/systems/${1}/grubconfig.sh ]; then
    cp ${WORKDIR}/systems/${1}/grubconfig.sh ${MOUNT_POINT}/grubconfig.sh
    chmod a+x ${MOUNT_POINT}/grubconfig.sh
    chroot ${MOUNT_POINT} /grubconfig.sh
    rm -f ${MOUNT_POINT}/grubconfig.sh
  fi
  chroot ${MOUNT_POINT} update-grub
fi

# finalize script which is run chrooted per system
if [ -f ${WORKDIR}/systems/${1}/finalize-chroot.sh ]; then
  cp ${WORKDIR}/systems/${1}/finalize-chroot.sh ${MOUNT_POINT}/finalize-chroot.sh
  chmod a+x ${MOUNT_POINT}/finalize-chroot.sh
  chroot ${MOUNT_POINT} /finalize-chroot.sh ${1} ${2} ${3}
  rm -f ${MOUNT_POINT}/finalize-chroot.sh
fi

# create a useable default /etc/resolv.conf instead of the one from the build system
# it will usually be overwritten with something more useful via dhcp etc.
echo "nameserver 1.1.1.1" > ${MOUNT_POINT}/etc/resolv.conf

# umount all the extra stuff mounted for chroot usage as we are done with chroots now
umount ${MOUNT_POINT}/proc ${MOUNT_POINT}/sys ${MOUNT_POINT}/dev/pts ${MOUNT_POINT}/dev

if [ "${UEFI64ARM}" = "true" ]; then
  df -h ${MOUNT_POINT} ${MOUNT_POINT}/boot ${MOUNT_POINT}/boot/efi
  umount ${MOUNT_POINT}/boot/efi
else
  df -h ${MOUNT_POINT} ${MOUNT_POINT}/boot
fi
umount ${MOUNT_POINT}/boot
umount ${MOUNT_POINT}

losetup -d /dev/loop0

rmdir ${MOUNT_POINT}

echo ""
echo "the image is now ready at ${IMAGE_DIR}/${1}-${2}-${3}.img"
echo ""
