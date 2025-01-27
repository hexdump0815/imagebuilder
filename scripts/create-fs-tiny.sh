#!/bin/bash

cd `dirname $0`/..
export WORKDIR=`pwd`

. scripts/args-and-arch-check-functions-tiny.sh

export BUILD_ROOT=/compile/local/imagebuilder-root
export BUILD_ROOT_CACHE=/compile/local/imagebuilder-${2}-${3}-cache
export DOWNLOAD_DIR=/compile/local/imagebuilder-download

if [ -d ${BUILD_ROOT} ]; then
  echo ""
  echo "build root ${BUILD_ROOT} already exists - giving up for safety reasons ..."
  echo ""
  exit 1
fi

if [ ! -d ${DOWNLOAD_DIR} ]; then
  echo ""
  echo "download dir ${DOWNLOAD_DIR} does not exists - please run get-files.sh first ..."
  echo ""
  exit 1
fi

if [ "${1}" != "$(cat ${DOWNLOAD_DIR}/system.txt)" ] || \
   [ "${2}" != "$(cat ${DOWNLOAD_DIR}/arch.txt)" ] || \
   [ "${3}" != "$(cat ${DOWNLOAD_DIR}/release.txt)" ]; then
  echo ""
  echo "system, arch and release given on the cmdline (${1} ${2} ${3})"
  echo "do not match the ones of the download folder ${DOWNLOAD_DIR}"
  echo "($(cat ${DOWNLOAD_DIR}/system.txt) $(cat ${DOWNLOAD_DIR}/arch.txt) $(cat ${DOWNLOAD_DIR}/release.txt)) - please fix the download dir first - giving up"
  echo ""
  exit 1
fi

if [ ! -f systems/${1}/partition-mapping.txt ]; then
  echo ""
  echo "systems/${1}/partition-mapping.txt does not exist - giving up"
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
  ${WORKDIR}/scripts/create-fs-cache-tiny.sh ${2} ${3}
else
  echo ""
  echo "root fs cache for ${2} ${3} exists, so using it"
  echo ""
fi

# give up of the cache creation script failed
if [ "$?" = "1" ]; then
  exit 1
fi

echo ""
echo "copying over the root cache to the target root - this may take a while ..."
date
rsync -axADHSX --no-inc-recursive ${BUILD_ROOT_CACHE}/ ${BUILD_ROOT}
date
echo "done"
echo ""

mount -o bind /dev ${BUILD_ROOT}/dev
mount -o bind /dev/pts ${BUILD_ROOT}/dev/pts
mount -t sysfs /sys ${BUILD_ROOT}/sys
mount -t proc /proc ${BUILD_ROOT}/proc

# do this to avoid failing apk installs due to a too old fs-cache
chroot ${BUILD_ROOT} apk update

cp ${WORKDIR}/scripts/create-chroot-stage-02-tiny.sh ${BUILD_ROOT}

chroot ${BUILD_ROOT} /create-chroot-stage-02-tiny.sh ${3} ${DEFAULT_USERNAME}

cd ${BUILD_ROOT}/

rm -f create-chroot-stage-0?-tiny.sh

if [ -f ${DOWNLOAD_DIR}/kernel-${1}-${2}.tar.gz ]; then
  tar --numeric-owner -xhzf ${DOWNLOAD_DIR}/kernel-${1}-${2}.tar.gz
fi

if [ -d ${DOWNLOAD_DIR}/boot-extra-${1} ]; then
  mkdir -p boot/extra
  cp -r ${DOWNLOAD_DIR}/boot-extra-${1}/* boot/extra
fi

# TODOTINY - maybe extra-files-alpine?
# if [ -d ${WORKDIR}/files/extra-files ]; then
#   ( cd ${WORKDIR}/files/extra-files ; tar cf - . ) | tar xhf -
# fi
# if [ -d ${WORKDIR}/files/extra-files-${2} ]; then
#   ( cd ${WORKDIR}/files/extra-files-${2} ; tar cf - . ) | tar xhf -
# fi
if [ -d ${WORKDIR}/files/extra-files-${3} ]; then
  ( cd ${WORKDIR}/files/extra-files-${3} ; tar cf - . ) | tar xhf -
fi
if [ -d ${WORKDIR}/files/extra-files-${2}-${3} ]; then
  ( cd ${WORKDIR}/files/extra-files-${2}-${3} ; tar cf - . ) | tar xhf -
fi
if [ -d ${WORKDIR}/systems/${1}/extra-files ]; then
  ( cd ${WORKDIR}/systems/${1}/extra-files ; tar cf - . ) | tar xhf -
fi
# if [ -d ${WORKDIR}/systems/${1}/extra-files-${2} ]; then
#   ( cd ${WORKDIR}/systems/${1}/extra-files-${2} ; tar cf - . ) | tar xhf -
# fi
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

# TODOTINY: how to do this for alpine?
# # remove the generated ssh keys so that fresh ones are generated on
# # first boot for each installed image
# rm -f etc/ssh/*key*
# # activate the one shot service to recreate them on first boot
# mkdir -p etc/systemd/system/multi-user.target.wants
# ( cd etc/systemd/system/multi-user.target.wants ;  ln -s ../regenerate-ssh-host-keys.service . )

# TODOTINY: is this required for alpine?
# # delete random-seed and machine-id according to https://systemd.io/BUILDING_IMAGES/
# # so that they get created unique per machine on first boot
# # inspired by: https://github.com/armbian/build/pull/3774
# echo "uninitialized" > etc/machine-id
# rm -f var/lib/systemd/random-seed var/lib/dbus/machine-id

# TODOTINY: how to do this for alpine?
# # if a different default user name was set, parse it into the rename user script
# sed -i "s,DEFAULT_USERNAME=linux,DEFAULT_USERNAME=${DEFAULT_USERNAME},g" scripts/rename-default-user.sh

# TODOTINY: is this required for alpine?
# # create an empty xorg.conf.d dir where the xorg config files can go to
# mkdir -p ${BUILD_ROOT}/etc/X11/xorg.conf.d

# add some imagebuilder version info as /etc/imagebuilder-info
IMAGEBUILDER_VERSION=$(cd ${WORKDIR}; git rev-parse --verify HEAD)
echo ${1} ${2} ${3} ${IMAGEBUILDER_VERSION} > ${BUILD_ROOT}/etc/imagebuilder-info

# copy postinstall files into the build root if there are any
if [ -d ${DOWNLOAD_DIR}/postinstall-${1} ]; then
  cp -r ${DOWNLOAD_DIR}/postinstall-${1} ${BUILD_ROOT}/postinstall
fi

# post install script per system
if [ -f ${WORKDIR}/systems/${1}/postinstall.sh ]; then
  bash ${WORKDIR}/systems/${1}/postinstall.sh ${1} ${2} ${3}
fi

# post install script which is run chrooted per system
if [ -f ${WORKDIR}/systems/${1}/postinstall-chroot.sh ]; then
  cp ${WORKDIR}/systems/${1}/postinstall-chroot.sh ${BUILD_ROOT}/postinstall-chroot.sh
  chmod a+x ${BUILD_ROOT}/postinstall-chroot.sh
  chroot ${BUILD_ROOT} /postinstall-chroot.sh ${1} ${2} ${3}
  rm -f ${BUILD_ROOT}/postinstall-chroot.sh
fi

# cleanup postinstall files
if [ -d ${BUILD_ROOT}/postinstall ]; then
  rm -rf ${BUILD_ROOT}/postinstall
fi

chroot ${BUILD_ROOT} ldconfig

export KERNEL_VERSION=`ls ${BUILD_ROOT}/boot/*Image-* | sed 's,.*Image-,,g' | sort -u`

# in case we did not get a kernel version, try it again with the vmlinuz
if [ "$KERNEL_VERSION" = "" ]; then
  echo "trying vmlinuz as kernel name instead of *Image:"
  export KERNEL_VERSION=`ls ${BUILD_ROOT}/boot/vmlinuz-* | sed 's,.*vmlinuz-,,g' | sort -u`
fi

if [ "$KERNEL_VERSION" = "" ]; then
  echo "no KERNEL_VERSION - lets assume this is intended and ignore the initramfs rebuild"
else
  # TODOTINY: how to do this for alpine?
  echo "initramfs rebuild still to be fixed for alpine ..."
  # # hack to get the fsck binaries in properly even in our chroot env
  # cp -f usr/share/initramfs-tools/hooks/fsck tmp/fsck.org
  # sed -i 's,fsck_types=.*,fsck_types="vfat ext4",g' usr/share/initramfs-tools/hooks/fsck
  # chroot ${BUILD_ROOT} update-initramfs -c -k ${KERNEL_VERSION}
  # mv -f tmp/fsck.org usr/share/initramfs-tools/hooks/fsck
fi

cd ${WORKDIR}

umount ${BUILD_ROOT}/proc ${BUILD_ROOT}/sys ${BUILD_ROOT}/dev/pts ${BUILD_ROOT}/dev

echo ""
echo "now run create-image-tiny.sh ${1} ${2} ${3} to build the image"
echo ""
