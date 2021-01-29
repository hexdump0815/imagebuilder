#!/bin/bash

cd `dirname $0`
. versions.conf

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${armsoc_focal_armv7l_version}/misc/xorg-armsoc-aarch64-ubuntu.tar.gz -O /tmp/xorg-armsoc-aarch64-focal.tar.gz
tar xzf /tmp/xorg-armsoc-aarch64-focal.tar.gz
rm -f /tmp/xorg-armsoc-aarch64-focal.tar.gz
