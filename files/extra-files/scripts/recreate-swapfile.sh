#!/bin/bash

if [ "$#" != "1" ]; then
  echo ""
  echo "usage: $0 <size>"
  echo ""
  echo "size can be in M or G for megabytes or gigabytes"
  echo "example: $0 2G"
  echo ""
  exit 1
fi

swapoff /swap/file.0

rm /swap/file.0
truncate -s 0 /swap/file.0
fallocate -l ${1} /swap/file.0
chmod 600 /swap/file.0
mkswap -L swapfile.0 /swap/file.0

swapon /swap/file.0
