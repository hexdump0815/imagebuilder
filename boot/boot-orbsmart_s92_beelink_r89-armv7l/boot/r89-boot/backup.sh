#!/bin/bash

# exit on error
set -e

MYDISK="/dev/mmcblk0"

if [ "$#" = "0" ]; then
  echo ""
  echo "usage: $0 kernel-version"
  echo ""
  echo "example: $0 4.19.32-stb-av7+"
  echo ""
  exit 1
fi

export kver=$1

dd if=${MYDISK} skip=64 count=262080 | gzip -9 > /boot/r89-boot-gz.dd-${kver}
