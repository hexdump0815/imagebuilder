#!/bin/bash

cd `dirname $0`
. versions.conf

# exit on errors
set -e

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h3_mali_blob_version}/misc/opt-mali-sunxi-armv7l.tar.gz -O /tmp/opengl-allwinner_h3-armv7l.tar.gz
tar xzf /tmp/opengl-allwinner_h3-armv7l.tar.gz
rm -f /tmp/opengl-allwinner_h3-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h3_mali_blob_version}/misc//opt-mali-sunxi-fbdev-armv7l.tar.gz -O /tmp/opengl-fbdev-allwinner_h3-armv7l.tar.gz
tar xzf /tmp/opengl-fbdev-allwinner_h3-armv7l.tar.gz
rm -f /tmp/opengl-fbdev-allwinner_h3-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h3_mali_blob_version}/misc//opt-mali-sunxi-wayland-armv7l.tar.gz -O /tmp/opengl-wayland-allwinner_h3-armv7l.tar.gz
tar xzf /tmp/opengl-wayland-allwinner_h3-armv7l.tar.gz
rm -f /tmp/opengl-wayland-allwinner_h3-armv7l.tar.gz
