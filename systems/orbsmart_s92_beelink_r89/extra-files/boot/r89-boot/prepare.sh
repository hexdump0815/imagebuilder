#!/bin/bash

MYTMPDIR="/tmp/r89-boot-tmp"

if [ "$#" = "0" ]; then
  echo ""
  echo "usage: $0 kernel-version"
  echo ""
  echo "example: $0 4.19.32-stb-av7+"
  echo ""
  exit 1
fi

export kver=$1

if [ ! -f /boot/zImage-${kver} ]; then
  echo ""
  echo "cannot find kernel image /boot/zImage-${kver} - giving up"
  echo ""
  exit 1
fi

if [ ! -f /boot/initrd.img-${kver} ]; then
  echo ""
  echo "cannot find initrd image /boot/initrd.img-${kver} - giving up"
  echo ""
  exit 1
fi

if [ ! -f /boot/dtb-${kver}/rk3288-r89.dtb ]; then
  echo ""
  echo "cannot find dtb file /boot/dtb-${kver}/rk3288-r89.dtb - giving up"
  echo ""
  exit 1
fi

rm ${MYTMPDIR}/*

mkdir -p ${MYTMPDIR}
echo "- creating kernel image"
/boot/r89-boot/mkkrnlimg -a /boot/zImage-${kver} ${MYTMPDIR}/kernel-linux.img
file /boot/initrd.img-${kver} | grep -qi "gzip compressed"
if [ "$?" = "0" ]; then
  cp /boot/initrd.img-${kver} ${MYTMPDIR}/initrd.img-${kver}.gz
  gunzip ${MYTMPDIR}/initrd.img-${kver}.gz
else
  file /boot/initrd.img-${kver} | grep -qi "lz4 compressed"
  if [ "$?" = "0" ]; then
    cp /boot/initrd.img-${kver} ${MYTMPDIR}/initrd.img-${kver}.lz4
    unlz4 ${MYTMPDIR}/initrd.img-${kver}.lz4
  else
    file /boot/initrd.img-${kver} | grep -qi "Zstandard compressed data"
    if [ "$?" = "0" ]; then
      cp /boot/initrd.img-${kver} ${MYTMPDIR}/initrd.img-${kver}.zst
      unzstd ${MYTMPDIR}/initrd.img-${kver}.zst
    else
      file /boot/initrd.img-${kver} | grep -qi "XZ compressed data"
      if [ "$?" = "0" ]; then
        cp /boot/initrd.img-${kver} ${MYTMPDIR}/initrd.img-${kver}.xz
        unxz ${MYTMPDIR}/initrd.img-${kver}.xz
      else
        echo ""
        echo "unsupported initrd format - only gzip, lz4, xz and zstd are supported - giving up"
        echo ""
        exit 1
      fi
    fi
  fi
fi
echo "- creating initrd image"
/boot/r89-boot/mkkrnlimg -a ${MYTMPDIR}/initrd.img-${kver} ${MYTMPDIR}/boot-linux.img
rm ${MYTMPDIR}/initrd.img-${kver}
cp /boot/dtb-${kver}/rk3288-r89.dtb ${MYTMPDIR}/rk-kernel.dtb
echo "- creating resource image"
( cd ${MYTMPDIR} && /boot/r89-boot/resource_tool rk-kernel.dtb && mv resource.img resource-linux.img )
rm ${MYTMPDIR}/rk-kernel.dtb
