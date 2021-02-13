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
  echo ""
  echo "possible release options:"
  echo "- focal - ubuntu"
  echo "- bullseye - debian (not yet supported)"
  echo ""
  echo "example: $0 armv7l focal"
  echo ""
  exit 1
fi

if [ $(uname -m) != ${1} ]; then
  echo ""
  echo "the target arch ${1} is not the same arch this system is running on: $(uname -m) - giving up"
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
    BOOTSTRAP_ARCH=armhf
  elif [ "${1}" = "aarch64" ]; then
    BOOTSTRAP_ARCH=arm64
  fi
  if [ "${2}" = "focal" ]; then
    LANG=C debootstrap --variant=minbase --arch=${BOOTSTRAP_ARCH} ${2} ${BUILD_ROOT_CACHE} http://ports.ubuntu.com/
  elif [ "${2}" = "bullseye" ]; then
    LANG=C debootstrap --variant=minbase --arch=${BOOTSTRAP_ARCH} ${2} ${BUILD_ROOT_CACHE} http://deb.debian.org/debian/
  fi

  cp ${WORKDIR}/files/${2}-sources.list ${BUILD_ROOT_CACHE}/etc/apt/sources.list
  # parse in the proper ubuntu/debian version
  sed -i "s,UBUNTUVERSION,${2},g" ${BUILD_ROOT_CACHE}/etc/apt/sources.list
  sed -i "s,DEBIANVERSION,${2},g" ${BUILD_ROOT_CACHE}/etc/apt/sources.list
  cp ${WORKDIR}/scripts/create-chroot-stage-0?.sh ${BUILD_ROOT_CACHE}

  mount -o bind /dev ${BUILD_ROOT_CACHE}/dev
  mount -o bind /dev/pts ${BUILD_ROOT_CACHE}/dev/pts
  mount -t sysfs /sys ${BUILD_ROOT_CACHE}/sys
  mount -t proc /proc ${BUILD_ROOT_CACHE}/proc
  cp /proc/mounts ${BUILD_ROOT_CACHE}/etc/mtab
  cp /etc/resolv.conf ${BUILD_ROOT_CACHE}/etc/resolv.conf

  chroot ${BUILD_ROOT_CACHE} /create-chroot-stage-01.sh ${2}

  umount ${BUILD_ROOT_CACHE}/proc ${BUILD_ROOT_CACHE}/sys ${BUILD_ROOT_CACHE}/dev/pts ${BUILD_ROOT_CACHE}/dev
else
  echo ""
  echo "root fs cache for ${1} ${2} exists - please delete ${BUILD_ROOT_CACHE} to create a fresh one"
  echo ""
fi
