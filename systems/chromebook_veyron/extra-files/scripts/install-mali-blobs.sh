#!/bin/bash

cd `dirname $0`
. versions.conf

# exit on errors
set -e

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_veyron_mali_blob_version}/misc/opt-mali-rk3288-armv7l.tar.gz -O /tmp/opengl-chromebook_veyron-armv7l.tar.gz
tar xzf /tmp/opengl-chromebook_veyron-armv7l.tar.gz
rm -f /tmp/opengl-chromebook_veyron-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_veyron_mali_blob_version}/misc/opt-mali-rk3288-fbdev-armv7l.tar.gz -O /tmp/opengl-fbdev-chromebook_veyron-armv7l.tar.gz
tar xzf /tmp/opengl-fbdev-chromebook_veyron-armv7l.tar.gz
rm -f /tmp/opengl-fbdev-chromebook_veyron-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_veyron_mali_blob_version}/misc/opt-mali-rk3288-wayland-armv7l.tar.gz -O /tmp/opengl-wayland-chromebook_veyron-armv7l.tar.gz
tar xzf /tmp/opengl-wayland-chromebook_veyron-armv7l.tar.gz
rm -f /tmp/opengl-wayland-chromebook_veyron-armv7l.tar.gz
