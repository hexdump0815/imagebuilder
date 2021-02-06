#!/bin/bash

cd `dirname $0`/..
export WORKDIR=`pwd`

. scripts/args-and-arch-check-functions.sh

export BUILD_ROOT=/compile/local/imagebuilder-root
export BUILD_ROOT_CACHE=/compile/local/imagebuilder-${2}-${3}-cache

if [ -d ${BUILD_ROOT} ]; then
  echo ""
  echo "BUILD_ROOT ${BUILD_ROOT} alresdy exists - giving up for safety reasons ..."
  echo ""
  exit 1
fi

# set defaults for the values coming from imagebuilder.conf otherwise
DEFAULT_USERNAME=linux

# get the imagebuilder config
if [ -f ${WORKDIR}/scripts/imagebuilder.conf ]; then
  . ${WORKDIR}/scripts/imagebuilder.conf
fi

if [ ! -d ${BUILD_ROOT_CACHE} ]; then
  echo ""
  echo "root fs cache for ${2} ${3} does not exist, so creating one"
  echo ""
  mkdir -p ${BUILD_ROOT_CACHE}
  cd ${BUILD_ROOT_CACHE}

  if [ "$2" = "armv7l" ]; then
    BOOTSTRAP_ARCH=armhf
  elif [ "$2" = "aarch64" ]; then
    BOOTSTRAP_ARCH=arm64
  fi
  if [ "$3" = "focal" ]; then
    LANG=C debootstrap --variant=minbase --arch=${BOOTSTRAP_ARCH} ${3} ${BUILD_ROOT_CACHE} http://ports.ubuntu.com/
  elif [ "$3" = "bullseye" ]; then
    LANG=C debootstrap --variant=minbase --arch=${BOOTSTRAP_ARCH} ${3} ${BUILD_ROOT_CACHE} http://deb.debian.org/debian/
  fi

  cp ${WORKDIR}/files/${3}-sources.list ${BUILD_ROOT_CACHE}/etc/apt/sources.list
  # parse in the proper ubuntu/debian version
  sed -i "s,UBUNTUVERSION,${3},g" ${BUILD_ROOT_CACHE}/etc/apt/sources.list
  sed -i "s,DEBIANVERSION,${3},g" ${BUILD_ROOT_CACHE}/etc/apt/sources.list
  cp ${WORKDIR}/scripts/create-chroot-stage-0?.sh ${BUILD_ROOT_CACHE}

  mount -o bind /dev ${BUILD_ROOT_CACHE}/dev
  mount -o bind /dev/pts ${BUILD_ROOT_CACHE}/dev/pts
  mount -t sysfs /sys ${BUILD_ROOT_CACHE}/sys
  mount -t proc /proc ${BUILD_ROOT_CACHE}/proc
  cp /proc/mounts ${BUILD_ROOT_CACHE}/etc/mtab
  cp /etc/resolv.conf ${BUILD_ROOT_CACHE}/etc/resolv.conf

  chroot ${BUILD_ROOT_CACHE} /create-chroot-stage-01.sh ${3} ${DEFAULT_USERNAME}

  umount ${BUILD_ROOT_CACHE}/proc ${BUILD_ROOT_CACHE}/sys ${BUILD_ROOT_CACHE}/dev/pts ${BUILD_ROOT_CACHE}/dev
else
  echo ""
  echo "root fs cache for ${2} ${3} exists, so using it"
  echo ""
fi

echo "copying over the root cache to the target root - this may take a while ..."
date
rsync -axADHSX --no-inc-recursive ${BUILD_ROOT_CACHE}/ ${BUILD_ROOT}
date
echo "done"

mount -o bind /dev ${BUILD_ROOT}/dev
mount -o bind /dev/pts ${BUILD_ROOT}/dev/pts
mount -t sysfs /sys ${BUILD_ROOT}/sys
mount -t proc /proc ${BUILD_ROOT}/proc

chroot ${BUILD_ROOT} /create-chroot-stage-02.sh ${3} ${DEFAULT_USERNAME}

cd ${BUILD_ROOT}/
tar --numeric-owner -xhzf ${WORKDIR}/downloads/kernel-${1}-${2}.tar.gz
#if [ -f ${WORKDIR}/downloads/kernel-mali-${1}-${2}.tar.gz ]; then
#  tar --numeric-owner -xhzf ${WORKDIR}/downloads/kernel-mali-${1}-${2}.tar.gz
#fi
#if [ -f ${WORKDIR}/downloads/kernel-mali-b-${1}-${2}.tar.gz ]; then
#  tar --numeric-owner -xhzf ${WORKDIR}/downloads/kernel-mali-b-${1}-${2}.tar.gz
#fi

rm -f create-chroot-stage-0?.sh
if [ -d ${WORKDIR}/files/extra-files ]; then
  ( cd ${WORKDIR}/files/extra-files ; tar cf - . ) | tar xhf -
fi
if [ -d ${WORKDIR}/files/extra-files-${2} ]; then
  ( cd ${WORKDIR}/files/extra-files-${2} ; tar cf - . ) | tar xhf -
fi
if [ -d ${WORKDIR}/files/extra-files-${3} ]; then
  ( cd ${WORKDIR}/files/extra-files-${3} ; tar cf - . ) | tar xhf -
fi
if [ -d ${WORKDIR}/files/extra-files-${2}-${3} ]; then
  ( cd ${WORKDIR}/files/extra-files-${2}-${3} ; tar cf - . ) | tar xhf -
fi
if [ -d ${WORKDIR}/systems/${1}/extra-files ]; then
  ( cd ${WORKDIR}/systems/${1}/extra-files ; tar cf - . ) | tar xhf -
fi
if [ -d ${WORKDIR}/systems/${1}/extra-files-${2} ]; then
  ( cd ${WORKDIR}/systems/${1}/extra-files-${2} ; tar cf - . ) | tar xhf -
fi
if [ -d ${WORKDIR}/systems/${1}/extra-files-${3} ]; then
  ( cd ${WORKDIR}/systems/${1}/extra-files-${3} ; tar cf - . ) | tar xhf -
fi
if [ -d ${WORKDIR}/systems/${1}/extra-files-${2}-${3} ]; then
  ( cd ${WORKDIR}/systems/${1}/extra-files-${2}-${3} ; tar cf - . ) | tar xhf -
fi
if [ -f ${WORKDIR}/systems/${1}/rc-local-additions.txt ]; then
  echo "" >> etc/rc.local
  echo "# additions for ${1}" >> etc/rc.local
  echo "" >> etc/rc.local
  cat ${WORKDIR}/systems/${1}/rc-local-additions.txt >> etc/rc.local
fi
if [ -f ${WORKDIR}/systems/${1}/rc-local-additions-${3}.txt ]; then
  echo "" >> etc/rc.local
  echo "# additions for ${1} ${3}" >> etc/rc.local
  echo "" >> etc/rc.local
  cat ${WORKDIR}/systems/${1}/rc-local-additions-${3}.txt >> etc/rc.local
fi
echo "" >> etc/rc.local
echo "exit 0" >> etc/rc.local

# adjust some config files if they exist
if [ -f ${BUILD_ROOT}/etc/modules-load.d/cups-filters.conf ]; then
  sed -i 's,^lp,#lp,g' ${BUILD_ROOT}/etc/modules-load.d/cups-filters.conf
  sed -i 's,^ppdev,#ppdev,g' ${BUILD_ROOT}/etc/modules-load.d/cups-filters.conf
  sed -i 's,^parport_pc,#parport_pc,g' ${BUILD_ROOT}/etc/modules-load.d/cups-filters.conf
fi
if [ -f ${BUILD_ROOT}/etc/NetworkManager/NetworkManager.conf ]; then
  sed -i 's,^managed=false,managed=true,g' ${BUILD_ROOT}/etc/NetworkManager/NetworkManager.conf
  touch ${BUILD_ROOT}/etc/NetworkManager/conf.d/10-globally-managed-devices.conf
fi
if [ -f ${BUILD_ROOT}/etc/default/numlockx ]; then
  sed -i 's,^NUMLOCK=auto,NUMLOCK=off,g' ${BUILD_ROOT}/etc/default/numlockx
fi
if [ -f ${BUILD_ROOT}/etc/default/apport ]; then
  sed -i 's,^enabled=1,enabled=0,g' ${BUILD_ROOT}/etc/default/apport
fi

# for the arm chromebooks add some useful files to the boot partition
if [ "$1" = "chromebook_snow" ] || [ "$1" = "chromebook_veyron" ] || [ "$1" = "chromebook_nyan" ]; then
  cp -r ${WORKDIR}/files/chromebook-boot ${BUILD_ROOT}/boot
fi

export KERNEL_VERSION=`ls ${BUILD_ROOT}/boot/*Image-* | sed 's,.*Image-,,g' | sort -u`

# hack to get the fsck binaries in properly even in our chroot env
cp -f ${BUILD_ROOT}/usr/share/initramfs-tools/hooks/fsck ${BUILD_ROOT}/tmp/fsck.org
sed -i 's,fsck_types=.*,fsck_types="vfat ext4",g' ${BUILD_ROOT}/usr/share/initramfs-tools/hooks/fsck
chroot ${BUILD_ROOT} update-initramfs -c -k ${KERNEL_VERSION}
mv -f ${BUILD_ROOT}/tmp/fsck.org ${BUILD_ROOT}/usr/share/initramfs-tools/hooks/fsck

cd ${BUILD_ROOT}

# remove the generated ssh keys so that fresh ones are generated on
# first boot for each installed image
rm -f etc/ssh/*key*
# activate the one shot service to recreate them on first boot
mkdir -p etc/systemd/system/multi-user.target.wants
( cd etc/systemd/system/multi-user.target.wants ;  ln -s ../regenerate-ssh-host-keys.service . )

# if a different default user name was set, parse it into the rename user script
sed -i "s,DEFAULT_USERNAME=linux,DEFAULT_USERNAME=${DEFAULT_USERNAME},g" scripts/rename-default-user.sh

# post install script per system
if [ -x ${WORKDIR}/systems/${1}/postinstall.sh ]; then
  ${WORKDIR}/systems/${1}/postinstall.sh
fi
if [ -x ${WORKDIR}/systems/${1}/postinstall-${3}.sh ]; then
  ${WORKDIR}/systems/${1}/postinstall-${3}.sh
fi

chroot ${BUILD_ROOT} ldconfig

cd ${WORKDIR}

umount ${BUILD_ROOT}/proc ${BUILD_ROOT}/sys ${BUILD_ROOT}/dev/pts ${BUILD_ROOT}/dev

echo ""
echo "now run create-image.sh ${1} ${2} ${3} to build the image"
echo ""
