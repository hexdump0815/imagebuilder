#!/bin/bash

cd `dirname $0`
. versions.conf

# exit on errors
set -e

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_mali_blob_version}/misc.rkc/opt-mali-rk3328-aarch64.tar.gz -O /tmp/opengl-rockchip_rk33xx-aarch64.tar.gz
tar xzf /tmp/opengl-rockchip_rk33xx-aarch64.tar.gz
rm -f /tmp/opengl-rockchip_rk33xx-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_mali_blob_version}/misc.rkc/opt-mali-rk3328-fbdev-aarch64.tar.gz -O /tmp/opengl-fbdev-rockchip_rk33xx-aarch64.tar.gz
tar xzf /tmp/opengl-fbdev-rockchip_rk33xx-aarch64.tar.gz
rm -f /tmp/opengl-fbdev-rockchip_rk33xx-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_mali_blob_version}/misc.rkc/opt-mali-rk3328-wayland-aarch64.tar.gz -O /tmp/opengl-wayland-rockchip_rk33xx-aarch64.tar.gz
tar xzf /tmp/opengl-wayland-rockchip_rk33xx-aarch64.tar.gz
rm -f /tmp/opengl-wayland-rockchip_rk33xx-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_mali_blob_version}/misc.rkc/opt-mali-rk3399-aarch64.tar.gz -O /tmp/opengl-b-rockchip_rk33xx-aarch64.tar.gz
tar xzf /tmp/opengl-b-rockchip_rk33xx-aarch64.tar.gz
rm -f /tmp/opengl-b-rockchip_rk33xx-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_mali_blob_version}/misc.rkc/opt-mali-rk3399-fbdev-aarch64.tar.gz -O /tmp/opengl-fbdev-b-rockchip_rk33xx-aarch64.tar.gz
tar xzf /tmp/opengl-fbdev-b-rockchip_rk33xx-aarch64.tar.gz
rm -f /tmp/opengl-fbdev-b-rockchip_rk33xx-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_mali_blob_version}/misc.rkc/opt-mali-rk3399-wayland-aarch64.tar.gz -O /tmp/opengl-wayland-b-rockchip_rk33xx-aarch64.tar.gz
tar xzf /tmp/opengl-wayland-b-rockchip_rk33xx-aarch64.tar.gz
rm -f /tmp/opengl-wayland-b-rockchip_rk33xx-aarch64.tar.gz
# the amlogic fbdev mali blob works on rk3328 too in gl4es LIBGL_FB=3 mode while the rk3328 one does not
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_mali_blob_version}/misc/opt-mali-s905-fbdev-aarch64.tar.gz -O /tmp/opengl-fbdev-alt-rockchip_rk33xx-aarch64.tar.gz
tar xzf /tmp/opengl-fbdev-alt-rockchip_rk33xx-aarch64.tar.gz
rm -f /tmp/opengl-fbdev-alt-rockchip_rk33xx-aarch64.tar.gz
