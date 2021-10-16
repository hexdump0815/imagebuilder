#!/bin/bash

cd `dirname $0`/..
export WORKDIR=`pwd`

. scripts/args-and-arch-check-functions.sh

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

# from partition-mapping it is clear if this is a chromebook or not via CROSPARTS
# in theory this can go now that the old chromebook-boot dir is gone, but lets keep
# it around as a differentiator for chromebooks as it useful still in this new role
if [ ! -f systems/${1}/partition-mapping.txt ]; then
  echo ""
  echo "systems/${1}/partition-mapping.txt does not exist - giving up"
  echo ""
  exit 1
else
  # get partition mapping info
  . systems/${1}/partition-mapping.txt
  if [ "$CROSPARTS" != "" ]; then
    echo "CROSPARTS=$CROSPARTS"
    export CROSPARTS
  fi
  if [ "$PMOSKERNEL" != "" ]; then
    echo "PMOSKERNEL=$PMOSKERNEL"
    export PMOSKERNEL
  fi
fi

# set defaults for the values coming from imagebuilder.conf otherwise
DEFAULT_USERNAME=linux

# get the imagebuilder config
if [ -f ${WORKDIR}/scripts/imagebuilder.conf ]; then
  . ${WORKDIR}/scripts/imagebuilder.conf
fi

if [ ! -d ${BUILD_ROOT_CACHE} ]; then
  ${WORKDIR}/scripts/create-fs-cache.sh ${2} ${3}
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

# do this to avoid failing apt installs due to a too old fs-cache
chroot ${BUILD_ROOT} apt-get update

chroot ${BUILD_ROOT} /create-chroot-stage-02.sh ${3} ${DEFAULT_USERNAME}

cd ${BUILD_ROOT}/

rm -f create-chroot-stage-0?.sh

if [ -f ${DOWNLOAD_DIR}/kernel-${1}-${2}.tar.gz ]; then
  # this might be used later in the scripts to distinguish between own and dist kernel
  export OWN_KERNEL="true"
  tar --numeric-owner -xhzf ${DOWNLOAD_DIR}/kernel-${1}-${2}.tar.gz
  if [ -f ${DOWNLOAD_DIR}/kernel-mali-${1}-${2}.tar.gz ]; then
    tar --numeric-owner -xhzf ${DOWNLOAD_DIR}/kernel-mali-${1}-${2}.tar.gz
  fi
fi

# if there is no own kernel, then install the dist kernel
if [ "$3" = "focal" ] || [ "$3" = "sonaremin" ]; then
  if [ "$2" = "x86_64" ] && [ "${OWN_KERNEL}" != "true" ]; then
    chroot ${BUILD_ROOT} apt-get -yq install linux-image-generic
  fi
elif [ "$3" = "bullseye" ]; then
  if [ "$2" = "i686" ] && [ "${OWN_KERNEL}" != "true" ]; then
    chroot ${BUILD_ROOT} apt-get -yq install linux-image-686
  # in the chromebook octopus case there is an own special cros kernel
  elif [ "$2" = "x86_64" ] && [ "${OWN_KERNEL}" != "true" ]; then
    chroot ${BUILD_ROOT} apt-get -yq install linux-image-amd64
  fi
fi

if [ -d ${DOWNLOAD_DIR}/boot-extra-${1} ]; then
  mkdir -p boot/extra
  cp -r ${DOWNLOAD_DIR}/boot-extra-${1}/* boot/extra
fi

# install the self built fresher mesa version if one is there
if [ -f ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz ]; then
  tar --numeric-owner -xzf ${DOWNLOAD_DIR}/opt-mesa-${3}-${2}.tar.gz
fi

# some systems need a fresher xorg server
if [ -f ${DOWNLOAD_DIR}/opt-xserver-${3}-${2}.tar.gz ]; then
  tar --numeric-owner -xzf ${DOWNLOAD_DIR}/opt-xserver-${3}-${2}.tar.gz
  # TODO: more stuff needed here - see:
  # https://github.com/hexdump0815/mesa-etc-build/blob/master/misc-build.txt#L33-L68
fi

if [ -f ${DOWNLOAD_DIR}/opengl-${1}-${2}.tar.gz ]; then
  tar --numeric-owner -xzf ${DOWNLOAD_DIR}/opengl-${1}-${2}.tar.gz
fi
if [ -f ${DOWNLOAD_DIR}/opengl-fbdev-${1}-${2}.tar.gz ]; then
  tar --numeric-owner -xzf ${DOWNLOAD_DIR}/opengl-fbdev-${1}-${2}.tar.gz
fi
if [ -f ${DOWNLOAD_DIR}/opengl-wayland-${1}-${2}.tar.gz ]; then
  tar --numeric-owner -xzf ${DOWNLOAD_DIR}/opengl-wayland-${1}-${2}.tar.gz
fi
if [ -f ${DOWNLOAD_DIR}/gl4es-${2}-${3}.tar.gz ]; then
  tar --numeric-owner -xzf ${DOWNLOAD_DIR}/gl4es-${2}-${3}.tar.gz
fi

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
if [ -f etc/modules-load.d/cups-filters.conf ]; then
  sed -i 's,^lp,#lp,g' etc/modules-load.d/cups-filters.conf
  sed -i 's,^ppdev,#ppdev,g' etc/modules-load.d/cups-filters.conf
  sed -i 's,^parport_pc,#parport_pc,g' etc/modules-load.d/cups-filters.conf
fi
if [ -f etc/NetworkManager/NetworkManager.conf ]; then
  sed -i 's,^managed=false,managed=true,g' etc/NetworkManager/NetworkManager.conf
  touch etc/NetworkManager/conf.d/10-globally-managed-devices.conf
fi
if [ -f etc/default/numlockx ]; then
  sed -i 's,^NUMLOCK=auto,NUMLOCK=off,g' etc/default/numlockx
fi
if [ -f etc/default/apport ]; then
  sed -i 's,^enabled=1,enabled=0,g' etc/default/apport
fi

# remove the generated ssh keys so that fresh ones are generated on
# first boot for each installed image
rm -f etc/ssh/*key*
# activate the one shot service to recreate them on first boot
mkdir -p etc/systemd/system/multi-user.target.wants
( cd etc/systemd/system/multi-user.target.wants ;  ln -s ../regenerate-ssh-host-keys.service . )

# if a different default user name was set, parse it into the rename user script
sed -i "s,DEFAULT_USERNAME=linux,DEFAULT_USERNAME=${DEFAULT_USERNAME},g" scripts/rename-default-user.sh

# create an empty xorg.conf.d dir where the xorg config files can go to
mkdir -p ${BUILD_ROOT}/etc/X11/xorg.conf.d

# add support for self built fresher mesa
if [ "${2}" = "armv7l" ]; then
  echo "LD_LIBRARY_PATH=/opt/mesa/lib/arm-linux-gnueabihf/dri:/usr/lib/arm-linux-gnueabihf/dri" > etc/environment.d/50opt-mesa.conf
  echo "LIBGL_DRIVERS_PATH=/opt/mesa/lib/arm-linux-gnueabihf/dri:/usr/lib/arm-linux-gnueabihf/dri" >> etc/environment.d/50opt-mesa.conf
  echo "GBM_DRIVERS_PATH=/opt/mesa/lib/arm-linux-gnueabihf/dri:/usr/lib/arm-linux-gnueabihf/dri" >> etc/environment.d/50opt-mesa.conf
  echo "/opt/mesa/lib/arm-linux-gnueabihf" > etc/ld.so.conf.d/aaa-mesa.conf
elif [ "${2}" = "aarch64" ]; then
  echo "LD_LIBRARY_PATH=/opt/mesa/lib/aarch64-linux-gnu/dri:/usr/lib/aarch64-linux-gnu/dri" > etc/environment.d/50opt-mesa.conf
  echo "LIBGL_DRIVERS_PATH=/opt/mesa/lib/aarch64-linux-gnu/dri:/usr/lib/aarch64-linux-gnu/dri" >> etc/environment.d/50opt-mesa.conf
  echo "GBM_DRIVERS_PATH=/opt/mesa/lib/aarch64-linux-gnu/dri:/usr/lib/aarch64-linux-gnu/dri" >> etc/environment.d/50opt-mesa.conf
  echo "/opt/mesa/lib/aarch64-linux-gnu" > etc/ld.so.conf.d/aaa-mesa.conf
elif [ "${2}" = "i686" ]; then
  echo "LD_LIBRARY_PATH=/opt/mesa/lib/i386-linux-gnu/dri:/usr/lib/i386-linux-gnu/dri" > etc/environment.d/50opt-mesa.conf
  echo "LIBGL_DRIVERS_PATH=/opt/mesa/lib/i386-linux-gnu/dri:/usr/lib/i386-linux-gnu/dri" >> etc/environment.d/50opt-mesa.conf
  echo "GBM_DRIVERS_PATH=/opt/mesa/lib/i386-linux-gnu/dri:/usr/lib/i386-linux-gnu/dri" >> etc/environment.d/50opt-mesa.conf
  echo "/opt/mesa/lib/i386-linux-gnu" > etc/ld.so.conf.d/aaa-mesa.conf
elif [ "${2}" = "x86_64" ]; then
  echo "LD_LIBRARY_PATH=/opt/mesa/lib/x86_64-linux-gnu/dri:/usr/lib/x86_64-linux-gnu/dri" > etc/environment.d/50opt-mesa.conf
  echo "LIBGL_DRIVERS_PATH=/opt/mesa/lib/x86_64-linux-gnu/dri:/usr/lib/x86_64-linux-gnu/dri" >> etc/environment.d/50opt-mesa.conf
  echo "GBM_DRIVERS_PATH=/opt/mesa/lib/x86_64-linux-gnu/dri:/usr/lib/x86_64-linux-gnu/dri" >> etc/environment.d/50opt-mesa.conf
  echo "/opt/mesa/lib/x86_64-linux-gnu" > etc/ld.so.conf.d/aaa-mesa.conf
fi
cp etc/environment.d/50opt-mesa.conf etc/X11/Xsession.d/50opt-mesa.conf
echo "export LD_LIBRARY_PATH LIBGL_DRIVERS_PATH GBM_DRIVERS_PATH" >> etc/X11/Xsession.d/50opt-mesa.conf

# add some imagebuilder version info as /etc/imagebuilder-info
IMAGEBUILDER_VERSION=$(cd ${WORKDIR}; git rev-parse --verify HEAD)
echo ${1} ${2} ${3} ${IMAGEBUILDER_VERSION} > ${BUILD_ROOT}/etc/imagebuilder-info

# post install script per system
if [ -x ${WORKDIR}/systems/${1}/postinstall.sh ]; then
  ${WORKDIR}/systems/${1}/postinstall.sh
fi
if [ -x ${WORKDIR}/systems/${1}/postinstall-${3}.sh ]; then
  ${WORKDIR}/systems/${1}/postinstall-${3}.sh
fi

# post install script which is run chrooted per system
if [ -x ${WORKDIR}/systems/${1}/postinstall-chroot.sh ]; then
  cp ${WORKDIR}/systems/${1}/postinstall-chroot.sh ${BUILD_ROOT}/postinstall-chroot.sh
  chroot ${BUILD_ROOT} /postinstall-chroot.sh ${1} ${2} ${3}
  rm -f ${BUILD_ROOT}/postinstall-chroot.sh ${1}
fi
if [ -x ${WORKDIR}/systems/${1}/postinstall-chroot-${3}.sh ]; then
  cp ${WORKDIR}/systems/${1}/postinstall-chroot-${3}.sh ${BUILD_ROOT}/postinstall-chroot-${3}.sh
  chroot ${BUILD_ROOT} /postinstall-chroot-${3}.sh ${1} ${2} ${3}
  rm -f ${BUILD_ROOT}/postinstall-chroot-${3}.sh
fi

chroot ${BUILD_ROOT} ldconfig

if [ ${PMOSKERNEL} != "true" ]; then
  export KERNEL_VERSION=`ls ${BUILD_ROOT}/boot/*Image-* | sed 's,.*Image-,,g' | sort -u`

  # in case we did not get a kernel version, try it again with the vmlinuz
  if [ "$KERNEL_VERSION" = "" ]; then
    echo "trying vmlinuz as kernel name instead of *Image:"
    export KERNEL_VERSION=`ls ${BUILD_ROOT}/boot/vmlinuz-* | sed 's,.*vmlinuz-,,g' | sort -u`
  fi
  
  # hack to get the fsck binaries in properly even in our chroot env
  cp -f usr/share/initramfs-tools/hooks/fsck tmp/fsck.org
  sed -i 's,fsck_types=.*,fsck_types="vfat ext4",g' usr/share/initramfs-tools/hooks/fsck
  chroot ${BUILD_ROOT} update-initramfs -c -k ${KERNEL_VERSION}
  mv -f tmp/fsck.org usr/share/initramfs-tools/hooks/fsck
fi

cd ${WORKDIR}

umount ${BUILD_ROOT}/proc ${BUILD_ROOT}/sys ${BUILD_ROOT}/dev/pts ${BUILD_ROOT}/dev

echo ""
echo "now run create-image.sh ${1} ${2} ${3} to build the image"
echo ""
