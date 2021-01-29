#!/bin/bash

cd `dirname $0`
. versions.conf

# exit on errors
set -e

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/raw/${allwinner_h6_mali_blob_version}/misc.ah6//opt-mali-h6-fbdev-aarch64.tar.gz -O /tmp/opengl-fbdev-allwinner_h6-aarch64.tar.gz
tar xzf /tmp/opengl-fbdev-allwinner_h6-aarch64.tar.gz
rm -f /tmp/opengl-fbdev-allwinner_h6-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/raw/${allwinner_h6_mali_blob_version}/misc.ah6//opt-mali-h6-wayland-aarch64.tar.gz -O /tmp/opengl-wayland-allwinner_h6-aarch64.tar.gz
tar xzf /tmp/opengl-wayland-allwinner_h6-aarch64.tar.gz
rm -f /tmp/opengl-wayland-allwinner_h6-aarch64.tar.gz
