#!/bin/bash

cd `dirname $0`/..
export WORKDIR=`pwd`

if [ "$#" != "2" ]; then
  echo ""
  echo "usage: $0 arch release"
  echo ""
  echo "possible arch options:"
  echo "- armv7l - 32bit"
  echo "- aarch64 - 64bit"
  echo "- i686 - 32bit"
  echo "- x86_64 - 64bit"
  echo "- riscv64 - 64bit (wip and works only with sidriscv below)"
  echo ""
  echo "possible release options:"
  echo "- focal - ubuntu focal (no longer supported)"
  echo "- jammy - ubuntu jammy (should work)"
  echo "- bullseye - debian bullseye (no longer supported)"
  echo "- bookworm - debian bookworm (recommended)"
  echo "- sidriscv - debian sid (wip and riscv only as bookworm is not useable yet"
  echo ""
  echo "example: $0 armv7l focal"
  echo ""
  exit 1
fi

if [ "${1}" = "i686" ] && [ "${2}" = "focal" ] || [ "${1}" = "i686" ] && [ "${2}" = "jammy" ]; then
  echo ""
  echo "the target arch i686 is only supported for debian bullseye and bookworm as there is no i686 build of ubuntu focal or jammy - giving up"
  echo ""
  exit 1
fi

if [ "${1}" = "armv7l" ] || [ "${1}" = "aarch64" ]; then
  POSSIBLE_TARGET_HOST="aarch64"
fi

if [ "${1}" = "i686" ] || [ "${1}" = "x86_64" ]; then
  POSSIBLE_TARGET_HOST="x86_64"
fi

# check if the given arch matches the supported arch for the selected system
if [ $(uname -m) = ${1} ] || [ $(uname -m) = ${POSSIBLE_TARGET_HOST} ]; then
  echo ""
  echo "the target arch ${1} is supported for the selected system - moving on"
  echo ""
else
  echo ""
  echo "the target arch ${1} is not supported for the selected system - giving up"
  echo ""
  exit 1
fi

export BUILD_ROOT_CACHE=/compile/local/imagebuilder-${1}-${2}-cache

if [ -f ${WORKDIR}/scripts/imagebuilder.conf ]; then
  . ${WORKDIR}/scripts/imagebuilder.conf
fi

if [ ! -d ${BUILD_ROOT_CACHE} ]; then
  echo ""
  echo "root fs cache for ${1} ${2} does not exist, so creating one"
  echo ""
  mkdir -p ${BUILD_ROOT_CACHE}
  cd ${BUILD_ROOT_CACHE}

  if [ "${1}" = "armv7l" ]; then
    BOOTSTRAP_ARCH="armhf"
    SERVER_PREFIX="ports."
    SERVER_POSTFIX=""
  elif [ "${1}" = "aarch64" ]; then
    BOOTSTRAP_ARCH="arm64"
    SERVER_PREFIX="ports."
    SERVER_POSTFIX=""
  elif [ "${1}" = "i686" ]; then
    BOOTSTRAP_ARCH="i386"
    SERVER_PREFIX="archive."
    SERVER_POSTFIX="ubuntu/"
  elif [ "${1}" = "x86_64" ]; then
    BOOTSTRAP_ARCH="amd64"
    SERVER_PREFIX="archive."
    SERVER_POSTFIX="ubuntu/"
  elif [ "${1}" = "riscv64" ]; then
    BOOTSTRAP_ARCH="riscv64"
    SERVER_PREFIX="ports."
    SERVER_POSTFIX=""
  fi
  mkdir -p ${BUILD_ROOT_CACHE}/etc/apt
  if [ "${2}" = "focal" ]; then
    LANG=C debootstrap --variant=minbase --arch=${BOOTSTRAP_ARCH} ${2} ${BUILD_ROOT_CACHE} http://${SERVER_PREFIX}ubuntu.com/${SERVER_POSTFIX}
    # exit if debootstrap failed for some reason
    if [ "$?" != "0" ]; then
      echo ""
      echo "error while running debootstrap - giving up"
      echo ""
      rm -rf ${BUILD_ROOT_CACHE}
      exit 1
    fi
    cp ${WORKDIR}/files/focal-${BOOTSTRAP_ARCH}-sources.list ${BUILD_ROOT_CACHE}/etc/apt/sources.list
    # parse in the proper ubuntu version
    sed -i "s,UBUNTUVERSION,focal,g" ${BUILD_ROOT_CACHE}/etc/apt/sources.list
  elif [ "${2}" = "jammy" ]; then
    LANG=C debootstrap --variant=minbase --arch=${BOOTSTRAP_ARCH} ${2} ${BUILD_ROOT_CACHE} http://${SERVER_PREFIX}ubuntu.com/${SERVER_POSTFIX}
    # exit if debootstrap failed for some reason
    if [ "$?" != "0" ]; then
      echo ""
      echo "error while running debootstrap - giving up"
      echo ""
      rm -rf ${BUILD_ROOT_CACHE}
      exit 1
    fi
    cp ${WORKDIR}/files/focal-${BOOTSTRAP_ARCH}-sources.list ${BUILD_ROOT_CACHE}/etc/apt/sources.list
    # parse in the proper ubuntu version
    sed -i "s,UBUNTUVERSION,jammy,g" ${BUILD_ROOT_CACHE}/etc/apt/sources.list
  elif [ "${2}" = "bullseye" ]; then
    wget https://ftp-master.debian.org/keys/release-11.asc -qO- | gpg --import --no-default-keyring --keyring ${DOWNLOAD_DIR}/debian-release-11.gpg
    LANG=C debootstrap --keyring=${DOWNLOAD_DIR}/debian-release-11.gpg --variant=minbase --arch=${BOOTSTRAP_ARCH} ${2} ${BUILD_ROOT_CACHE} http://deb.debian.org/debian/
    # exit if debootstrap failed for some reason
    if [ "$?" != "0" ]; then
      echo ""
      echo "error while running debootstrap - giving up"
      echo ""
      rm -rf ${BUILD_ROOT_CACHE}
      exit 1
    fi
    cp ${WORKDIR}/files/bullseye-${BOOTSTRAP_ARCH}-sources.list ${BUILD_ROOT_CACHE}/etc/apt/sources.list
    # parse in the proper debian version
    sed -i "s,DEBIANVERSION,bullseye,g" ${BUILD_ROOT_CACHE}/etc/apt/sources.list
  elif [ "${2}" = "bookworm" ]; then
    wget https://ftp-master.debian.org/keys/release-11.asc -qO- | gpg --import --no-default-keyring --keyring ${DOWNLOAD_DIR}/debian-release-11.gpg
    LANG=C debootstrap --keyring=${DOWNLOAD_DIR}/debian-release-11.gpg --no-check-certificate --variant=minbase --arch=${BOOTSTRAP_ARCH} ${2} ${BUILD_ROOT_CACHE} http://deb.debian.org/debian/
    LANG=C debootstrap --variant=minbase --arch=${BOOTSTRAP_ARCH} ${2} ${BUILD_ROOT_CACHE} http://deb.debian.org/debian/
    # exit if debootstrap failed for some reason
    if [ "$?" != "0" ]; then
      echo ""
      echo "error while running debootstrap - giving up"
      echo ""
      rm -rf ${BUILD_ROOT_CACHE}
      exit 1
    fi
    cp ${WORKDIR}/files/bookworm-${BOOTSTRAP_ARCH}-sources.list ${BUILD_ROOT_CACHE}/etc/apt/sources.list
    # parse in the proper debian version
    sed -i "s,DEBIANVERSION,bookworm,g" ${BUILD_ROOT_CACHE}/etc/apt/sources.list
  elif [ "${2}" = "sidriscv" ]; then
    apt -y install debootstrap debian-ports-archive-keyring --no-install-recommends
    LANG=C debootstrap --arch=${BOOTSTRAP_ARCH} --foreign --keyring /usr/share/keyrings/debian-ports-archive-keyring.gpg --include=debian-ports-archive-keyring --no-check-certificate --variant=minbase sid ${BUILD_ROOT_CACHE} http://deb.debian.org/debian-ports
    # exit if debootstrap failed for some reason
    if [ "$?" != "0" ]; then
      echo ""
      echo "error while running debootstrap - giving up"
      echo ""
      rm -rf ${BUILD_ROOT_CACHE}
      exit 1
    fi
    cp ${WORKDIR}/files/sidriscv-${BOOTSTRAP_ARCH}-sources.list ${BUILD_ROOT_CACHE}/etc/apt/sources.list
    # this seems to be required to not need special options to apt commands when installing from the ports repo
    echo 'APT::Get::AllowUnauthenticated "true";' > ${BUILD_ROOT_CACHE}/etc/apt/apt.conf.d/99unauthenticated
  elif [ "${2}" = "sonaremin" ]; then
    LANG=C debootstrap --variant=minbase --arch=${BOOTSTRAP_ARCH} focal ${BUILD_ROOT_CACHE} http://ports.ubuntu.com/
    # exit if debootstrap failed for some reason
    if [ "$?" != "0" ]; then
      echo ""
      echo "error while running debootstrap - giving up"
      echo ""
      rm -rf ${BUILD_ROOT_CACHE}
      exit 1
    fi
    cp ${WORKDIR}/files/focal-${BOOTSTRAP_ARCH}-sources.list ${BUILD_ROOT_CACHE}/etc/apt/sources.list
    # parse in the proper ubuntu version
    sed -i "s,UBUNTUVERSION,focal,g" ${BUILD_ROOT_CACHE}/etc/apt/sources.list
  fi

  cp ${WORKDIR}/scripts/create-chroot-stage-01.sh ${BUILD_ROOT_CACHE}

  # in case of a leftover debootstrap dir move it out of the way to /tmp
  # this way the logs are still around and it will be cleaned on first boot
  if [ -d ${BUILD_ROOT_CACHE}/debootstrap ]; then
    mv ${BUILD_ROOT_CACHE}/debootstrap ${BUILD_ROOT_CACHE}/tmp
  fi

  mount -o bind /dev ${BUILD_ROOT_CACHE}/dev
  mount -o bind /dev/pts ${BUILD_ROOT_CACHE}/dev/pts
  mount -t sysfs /sys ${BUILD_ROOT_CACHE}/sys
  mount -t proc /proc ${BUILD_ROOT_CACHE}/proc
  cp /proc/mounts ${BUILD_ROOT_CACHE}/etc/mtab
  cp /etc/resolv.conf ${BUILD_ROOT_CACHE}/etc/resolv.conf

  chroot ${BUILD_ROOT_CACHE} /create-chroot-stage-01.sh ${2} ${1}

  umount ${BUILD_ROOT_CACHE}/proc ${BUILD_ROOT_CACHE}/sys ${BUILD_ROOT_CACHE}/dev/pts ${BUILD_ROOT_CACHE}/dev
else
  echo ""
  echo "root fs cache for ${1} ${2} exists - please delete ${BUILD_ROOT_CACHE} to create a fresh one"
  echo ""
fi
