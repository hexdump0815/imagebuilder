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
  echo "- riscv64 - 64bit (wip and works only with sidriscv below)"
  echo ""
  echo "possible release options:"
  echo "- alpine - this is the only release option for tiny images"
  echo ""
  echo "example: $0 riscv64 alpine"
  echo ""
  exit 1
fi

if [ "${1}" = "armv7l" ] || [ "${1}" = "aarch64" ]; then
  POSSIBLE_TARGET_HOST="aarch64"
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
    BOOTSTRAP_ARCH="armv7"
  elif [ "${1}" = "aarch64" ]; then
    BOOTSTRAP_ARCH="aarch64"
  elif [ "${1}" = "riscv64" ]; then
    BOOTSTRAP_ARCH="riscv64"
  fi

  if [ "${2}" = "alpine" ]; then
    # partially inspired by https://arvanta.net/alpine/alpine-on-visionfive/
    # and https://wiki.alpinelinux.org/wiki/Alpine_Linux_in_a_chroot
    APK_KEY="alpine-devel@lists.alpinelinux.org-60ac2099.rsa.pub"
    APK_MIRROR="https://dl-cdn.alpinelinux.org/alpine"
    # the version of the apk-tools-static package changes over time,
    # so lets get the correct one at any time directly
    APK_PKG=$(wget -q ${APK_MIRROR}/edge/main/${BOOTSTRAP_ARCH}/ -O - | grep apk-tools-static | sed 's,.*apk-tools-static-,apk-tools-static-,g;s,\.apk.*,.apk,g')
    if [ "$APK_PKG" == "" ]; then
      echo "error: could not determine the latest apk-tools-static pacakge version from"
      echo "${APK_MIRROR}/edge/main/${BOOTSTRAP_ARCH} - giving up"
      exit 1
    fi
    mkdir -p etc/apk/keys bootstrap proc sys
    wget -v https://alpinelinux.org/keys/${APK_KEY} -O etc/apk/keys/${APK_KEY}
    echo ${APK_MIRROR}/edge/main > etc/apk/repositories
    echo ${APK_MIRROR}/edge/community >> etc/apk/repositories
    echo ${APK_MIRROR}/edge/testing >> etc/apk/repositories
    wget -v ${APK_MIRROR}/edge/main/${BOOTSTRAP_ARCH}/${APK_PKG} -O bootstrap/apk-tools-static.apk
    cd bootstrap
    tar xzf apk-tools-static.apk sbin/apk.static
    cd ..
    ./bootstrap/sbin/apk.static --allow-untrusted --root ${BUILD_ROOT_CACHE} --arch ${BOOTSTRAP_ARCH} --initdb add \
      alpine-base alpine-baselayout alpine-conf kmod openrc dbus util-linux blkid chrony sysfsutils ssl_client \
      ca-certificates-bundle alpine-keys ethtool e2fsprogs e2fsprogs-extra libudev-zero libudev-zero-helper iwd \
      mkinitfs agetty openresolv tar tzdata openssh wget
  else
    echo ""
    echo "${2} is not supported as release - giving up!"
    echo ""
    exit 1
  fi

  cp ${WORKDIR}/scripts/create-chroot-stage-01-tiny.sh ${BUILD_ROOT_CACHE}

  mount -o bind /dev ${BUILD_ROOT_CACHE}/dev
  mount -o bind /dev/pts ${BUILD_ROOT_CACHE}/dev/pts
  mount -t sysfs /sys ${BUILD_ROOT_CACHE}/sys
  mount -t proc /proc ${BUILD_ROOT_CACHE}/proc
  if [ ! -L /etc/mtab ]; then
    cp /proc/mounts ${BUILD_ROOT_CACHE}/etc/mtab
  fi
  # this is to have some useable resolver values during image build - it will be overwritten later
  cp /etc/resolv.conf ${BUILD_ROOT_CACHE}/etc/resolv.conf

  chroot ${BUILD_ROOT_CACHE} /create-chroot-stage-01-tiny.sh ${2} ${1}

  umount ${BUILD_ROOT_CACHE}/proc ${BUILD_ROOT_CACHE}/sys ${BUILD_ROOT_CACHE}/dev/pts ${BUILD_ROOT_CACHE}/dev
else
  echo ""
  echo "root fs cache for ${1} ${2} exists - please delete ${BUILD_ROOT_CACHE} to create a fresh one"
  echo ""
fi
