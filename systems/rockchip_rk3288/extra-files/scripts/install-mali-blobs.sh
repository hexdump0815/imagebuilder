#!/bin/bash

cd `dirname $0`
. versions.conf

# exit on errors
set -e

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk3288_mali_blob_version}/misc/opt-mali-rk3288-armv7l.tar.gz -O /tmp/opengl-rockchip_rk3288-armv7l.tar.gz
tar xzf /tmp/opengl-rockchip_rk3288-armv7l.tar.gz
rm -f /tmp/opengl-rockchip_rk3288-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk3288_mali_blob_version}/misc/opt-mali-rk3288-fbdev-armv7l.tar.gz -O /tmp/opengl-fbdev-rockchip_rk3288-armv7l.tar.gz
tar xzf /tmp/opengl-fbdev-rockchip_rk3288-armv7l.tar.gz
rm -f /tmp/opengl-fbdev-rockchip_rk3288-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk3288_mali_blob_version}/misc/opt-mali-rk3288-wayland-armv7l.tar.gz -O /tmp/opengl-wayland-rockchip_rk3288-armv7l.tar.gz
tar xzf /tmp/opengl-wayland-rockchip_rk3288-armv7l.tar.gz
rm -f /tmp/opengl-wayland-rockchip_rk3288-armv7l.tar.gz
