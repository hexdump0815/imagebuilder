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

export BUILD_ROOT=/local/imagebuilder-root

cd `dirname $0`/..
export WORKDIR=`pwd`

mkdir -p ${BUILD_ROOT}
cd ${BUILD_ROOT}

if [ "$2" = "armv7l" ]; then 
  BOOTSTRAP_ARCH=armhf
elif [ "$2" = "aarch64" ]; then 
  BOOTSTRAP_ARCH=arm64
fi
if [ "$3" = "ubuntu" ]; then 
  LANG=C debootstrap --variant=minbase --arch=${BOOTSTRAP_ARCH} bionic ${BUILD_ROOT} http://ports.ubuntu.com/
elif [ "$3" = "debian" ]; then 
  LANG=C debootstrap --variant=minbase --arch=${BOOTSTRAP_ARCH} buster ${BUILD_ROOT} http://deb.debian.org/debian/
fi

cp ${WORKDIR}/files/${3}-sources.list ${BUILD_ROOT}/etc/apt/sources.list
cp ${WORKDIR}/scripts/create-chroot.sh ${BUILD_ROOT}

mount -o bind /dev ${BUILD_ROOT}/dev
mount -o bind /dev/pts ${BUILD_ROOT}/dev/pts
mount -t sysfs /sys ${BUILD_ROOT}/sys
mount -t proc /proc ${BUILD_ROOT}/proc
cp /proc/mounts ${BUILD_ROOT}/etc/mtab  
cp /etc/resolv.conf ${BUILD_ROOT}/etc/resolv.conf 

chroot ${BUILD_ROOT} /create-chroot.sh ${3}

cd ${BUILD_ROOT}/
tar --numeric-owner -xzf ${WORKDIR}/boot/kernel-${1}-${2}.tar.gz
if [ -f ${WORKDIR}/boot/kernel-mali-${1}-${2}.tar.gz ]; then
  tar --numeric-owner -xzf ${WORKDIR}/boot/kernel-mali-${1}-${2}.tar.gz
fi
cp -r ${WORKDIR}/boot/boot-${1}-${2}/* boot

rm -f create-chroot.sh
( cd ${WORKDIR}/files/extra-files ; tar cf - . ) | tar xf -
if [ -d ${WORKDIR}/files/extra-files-${2} ]; then
  ( cd ${WORKDIR}/files/extra-files-${2} ; tar cf - . ) | tar xf -
fi
if [ -d ${WORKDIR}/files/extra-files-${3} ]; then
  ( cd ${WORKDIR}/files/extra-files-${3} ; tar cf - . ) | tar xf -
fi
if [ -d ${WORKDIR}/files/extra-files-${1}-${2} ]; then
  ( cd ${WORKDIR}/files/extra-files-${1}-${2} ; tar cf - . ) | tar xf -
fi
if [ -d ${WORKDIR}/files/extra-files-${1}-${2}-${3} ]; then
  ( cd ${WORKDIR}/files/extra-files-${1}-${2}-${3} ; tar cf - . ) | tar xf -
fi
if [ -f ${WORKDIR}/files/opengl-${1}-${2}.tar.gz ]; then
  tar --numeric-owner -xzf ${WORKDIR}/files/opengl-${1}-${2}.tar.gz
fi
if [ -f ${WORKDIR}/files/opengl-fbdev-${1}-${2}.tar.gz ]; then
  tar --numeric-owner -xzf ${WORKDIR}/files/opengl-fbdev-${1}-${2}.tar.gz
fi
if [ -f ${WORKDIR}/files/opengl-wayland-${1}-${2}.tar.gz ]; then
  tar --numeric-owner -xzf ${WORKDIR}/files/opengl-wayland-${1}-${2}.tar.gz
fi
if [ -f ${WORKDIR}/files/xorg-armsoc-${2}-${3}.tar.gz ]; then
  tar --numeric-owner -xzf ${WORKDIR}/files/xorg-armsoc-${2}-${3}.tar.gz
fi
if [ -f ${WORKDIR}/files/gl4es-${2}-${3}.tar.gz ]; then
  tar --numeric-owner -xzf ${WORKDIR}/files/gl4es-${2}-${3}.tar.gz
fi
if [ -f ${WORKDIR}/files/rc-local-additions-${1}-${2}-${3}.txt ]; then
  echo "" >> etc/rc.local
  echo "# additions for ${1}-${2}-${3}" >> etc/rc.local
  echo "" >> etc/rc.local
  cat ${WORKDIR}/files/rc-local-additions-${1}-${2}-${3}.txt >> etc/rc.local
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

export KERNEL_VERSION=`ls ${BUILD_ROOT}/boot/*Image-* | sed 's,.*Image-,,g' | sort -u`

# hack to get the fsck binaries in properly even in our chroot env
cp -f ${BUILD_ROOT}/usr/share/initramfs-tools/hooks/fsck ${BUILD_ROOT}/tmp/fsck.org
sed -i 's,fsck_types=.*,fsck_types="vfat ext4",g' ${BUILD_ROOT}/usr/share/initramfs-tools/hooks/fsck
chroot ${BUILD_ROOT} update-initramfs -c -k ${KERNEL_VERSION}
mv -f ${BUILD_ROOT}/tmp/fsck.org ${BUILD_ROOT}/usr/share/initramfs-tools/hooks/fsck

cd ${WORKDIR}

# post install script per system
if [ -x ${WORKDIR}/files/postinstall-${1}-${2}-${3}.sh ]; then
  ${WORKDIR}/files/postinstall-${1}-${2}-${3}.sh
fi

cd ${WORKDIR}

umount ${BUILD_ROOT}/proc ${BUILD_ROOT}/sys ${BUILD_ROOT}/dev/pts ${BUILD_ROOT}/dev

echo ""
echo "now run create-image.sh ${1} ${2} ${3} to build the image"
echo ""