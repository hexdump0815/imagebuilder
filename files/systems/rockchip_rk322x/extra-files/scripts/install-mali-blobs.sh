#!/bin/bash

cd `dirname $0`
. versions.conf

# exit on errors
set -e

cd /
wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/raw/${rockchip_rk322x_mali_blob_version}/misc.322/opt-mali-rk322x-armv7l.tar.gz -O /tmp/opengl-rockchip_rk322x-armv7l.tar.gz
tar xzf /tmp/opengl-rockchip_rk322x-armv7l.tar.gz
rm -f /tmp/opengl-rockchip_rk322x-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/raw/${rockchip_rk322x_mali_blob_version}/misc.322/opt-mali-rk322x-fbdev-armv7l.tar.gz -O /tmp/opengl-fbdev-rockchip_rk322x-armv7l.tar.gz
tar xzf /tmp/opengl-fbdev-rockchip_rk322x-armv7l.tar.gz
rm -f /tmp/opengl-fbdev-rockchip_rk322x-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/raw/${rockchip_rk322x_mali_blob_version}/misc.322/opt-mali-rk322x-wayland-armv7l.tar.gz -O /tmp/opengl-wayland-rockchip_rk322x-armv7l.tar.gz
tar xzf /tmp/opengl-wayland-rockchip_rk322x-armv7l.tar.gz
rm -f /tmp/opengl-wayland-rockchip_rk322x-armv7l.tar.gz
