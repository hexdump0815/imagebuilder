#!/bin/bash
#
# install some packages required for the imagebuilder framework
#

apt-get -y install debootstrap btrfs-progs
if [ "$(uname -m)" != "riscv64" ]; then
  apt-get -y install vboot-kernel-utils cgpt
fi
