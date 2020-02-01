#!/bin/bash
#
# please run this script to fetch some large files from various github releases before starting to build images

if [ "$#" != "1" ]; then
  echo ""
  echo "usage: $0 system"
  echo "system can be: chromebook_snow"
  echo "               chromebook veyron (not implemented yet)"
  echo "               odroid_u3"
  echo "               orbsmart_s92_beelink_r89"
  echo "               raspberry_pi_3-armv7l"
  echo "               raspberry_pi_3-aarch64"
  echo "               raspberry_pi_4-armv7 (not implemented yet)"
  echo "               raspberry_pi_4-aarch64"
  echo "               amlogic_s905_w_x_tv_box-armv7l"
  echo "               amlogic_s905_w_x_tv_box-aarch64"
  echo "               all"
  echo ""
  echo "examples: $0 odroid_u3"
  echo "          $0 all"
  echo ""
  exit 1
fi

cd `dirname $0`/..

# create downloads dir
mkdir downloads

# exit on errors
set -e

chromebook_snow_release_version="5.4.14-stb-cbe%2B"
#chromebook_snow_tree_tag="v5.4.14"
chromebook_snow_tree_tag="master"

odroid_u3_release_version="5.4.14-stb-exy%2B"
#odroid_u3_tree_tag="v5.4.14"
odroid_u3_tree_tag="master"

orbsmart_s92_beelink_r89_release_version="5.4.14-stb-av7%2B"
#orbsmart_s92_beelink_r89_tree_tag="v5.4.14"
orbsmart_s92_beelink_r89_tree_tag="master"

raspberry_pi_3_armv7l_release_version="5.4.14-stb-av7%2B"
#raspberry_pi_3_armv7l_tree_tag="v5.4.14"
raspberry_pi_3_armv7l_tree_tag="master"

raspberry_pi_3_aarch64_release_version="5.4.14-stb-av8%2B"
#raspberry_pi_3_aarch64_tree_tag="v5.4.14"
raspberry_pi_3_aarch64_tree_tag="master"

raspberry_pi_4_aarch64_release_version="5.4.13-rpi-64b%2B"
#raspberry_pi_4_aarch64_tree_tag="v5.4.13"
raspberry_pi_4_aarch64_tree_tag="master"

amlogic_s905_w_x_tv_box_release_version="5.4.14-stb-av8%2B"
#amlogic_s905_w_x_tv_box_tree_tag="v5.4.14"
amlogic_s905_w_x_tv_box_tree_tag="master"

if [ "$1" = "all" ] || [ "$1" = "chromebook_snow" ]; then
  rm -f downloads/kernel-chromebook_snow-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_snow_release_version}/${chromebook_snow_release_version}.tar.gz -O downloads/kernel-chromebook_snow-armv7l.tar.gz
  rm -f downloads/boot-chromebook_snow-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc.cbe/boot/boot-chromebook_snow-armv7l.dd -O downloads/boot-chromebook_snow-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-chromebook_snow-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/opt-mali-exynos5250-armv7l.tar.gz -O downloads/opengl-chromebook_snow-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-chromebook_snow-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/opt-mali-exynos5250-fbdev-r5p0-armv7l.tar.gz -O downloads/opengl-fbdev-chromebook_snow-armv7l.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "odroid_u3" ]; then
  rm -f downloads/kernel-odroid_u3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${odroid_u3_release_version}/${odroid_u3_release_version}.tar.gz -O downloads/kernel-odroid_u3-armv7l.tar.gz
  rm -f downloads/boot-odroid_u3-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc.exy/u-boot/boot-odroid_u3-armv7l.dd -O downloads/boot-odroid_u3-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-odroid_u3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/opt-mali-exynos4412-armv7l.tar.gz -O downloads/opengl-odroid_u3-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-odroid_u3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/opt-mali-exynos4412-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-odroid_u3-armv7l.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "orbsmart_s92_beelink_r89" ]; then
  rm -f downloads/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}.tar.gz -O downloads/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/opt-mali-rk3288-armv7l.tar.gz -O downloads/opengl-orbsmart_s92_beelink_r89-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/opt-mali-rk3288-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-orbsmart_s92_beelink_r89-armv7l.tar.gz
  rm -f downloads/opengl-wayland-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/opt-mali-rk3288-wayland-armv7l.tar.gz -O downloads/opengl-wayland-orbsmart_s92_beelink_r89-armv7l.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "raspberry_pi_3-armv7l" ]; then
  rm -f downloads/kernel-raspberry_pi_3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_3_armv7l_release_version}/${raspberry_pi_3_armv7l_release_version}.tar.gz -O downloads/kernel-raspberry_pi_3-armv7l.tar.gz
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_armv7l_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_armv7l_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
#  rm -f downloads/opengl-rpi-armv7l-debian.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_armv7l_tree_tag}/misc/opt-mesa-rpi-armv7l-debian.tar.gz -O downloads/opengl-rpi-armv7l-debian.tar.gz
  rm -f downloads/opengl-rpi-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_armv7l_tree_tag}/misc/opt-mesa-rpi-armv7l-ubuntu.tar.gz -O downloads/opengl-rpi-armv7l-ubuntu.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "raspberry_pi_3-aarch64" ]; then
  rm -f downloads/kernel-raspberry_pi_3-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_3_aarch64_release_version}/${raspberry_pi_3_aarch64_release_version}.tar.gz -O downloads/kernel-raspberry_pi_3-aarch64.tar.gz
#  rm -f downloads/gl4es-aarch64-debian.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_aarch64_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O downloads/gl4es-aarch64-debian.tar.gz
  rm -f downloads/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_aarch64_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O downloads/gl4es-aarch64-ubuntu.tar.gz
#  rm -f downloads/opengl-rpi-aarch64-debian.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_aarch64_tree_tag}/misc/opt-mesa-rpi-aarch64-debian.tar.gz -O downloads/opengl-rpi-aarch64-debian.tar.gz
  rm -f downloads/opengl-rpi-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_aarch64_tree_tag}/misc/opt-mesa-rpi-aarch64-ubuntu.tar.gz -O downloads/opengl-rpi-aarch64-ubuntu.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "raspberry_pi_4-aarch64" ]; then
  rm -f downloads/kernel-raspberry_pi_4-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-raspberry-pi-4-kernel/releases/download/${raspberry_pi_4_aarch64_release_version}/${raspberry_pi_4_aarch64_release_version}.tar.gz -O downloads/kernel-raspberry_pi_4-aarch64.tar.gz
#  rm -f downloads/gl4es-aarch64-debian.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_4_aarch64_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O downloads/gl4es-aarch64-debian.tar.gz
  rm -f downloads/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_4_aarch64_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O downloads/gl4es-aarch64-ubuntu.tar.gz
#  rm -f downloads/opengl-rpi-aarch64-debian.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_aarch64_tree_tag}/misc/opt-mesa-rpi-aarch64-debian.tar.gz -O downloads/opengl-rpi-aarch64-debian.tar.gz
  rm -f downloads/opengl-rpi-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_aarch64_tree_tag}/misc/opt-mesa-rpi-aarch64-ubuntu.tar.gz -O downloads/opengl-rpi-aarch64-ubuntu.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "amlogic_s905_w_x_tv_box-armv7l" ]; then
  rm -f downloads/kernel-amlogic_s905_w_x_tv_box_armv7l-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_s905_w_x_tv_box_release_version}/${amlogic_s905_w_x_tv_box_release_version}.tar.gz -O downloads/kernel-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  rm -f downloads/kernel-mali-amlogic_s905_w_x_tv_box_armv7l-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_s905_w_x_tv_box_release_version}/${amlogic_s905_w_x_tv_box_release_version}-mali-s905.tar.gz -O downloads/kernel-mali-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-fbdev-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/opt-mali-s905-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  rm -f downloads/opengl-wayland-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/opt-mali-s905-wayland-armv7l.tar.gz -O downloads/opengl-wayland-amlogic_s905_w_x_tv_box-armv7l.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "amlogic_s905_w_x_tv_box-aarch64" ]; then
  rm -f downloads/kernel-amlogic_s905_w_x_tv_box_armv7l-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_s905_w_x_tv_box_release_version}/${amlogic_s905_w_x_tv_box_release_version}.tar.gz -O downloads/kernel-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  rm -f downloads/kernel-mali-amlogic_s905_w_x_tv_box_armv7l-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_s905_w_x_tv_box_release_version}/${amlogic_s905_w_x_tv_box_release_version}-mali-s905.tar.gz -O downloads/kernel-mali-amlogic_s905_w_x_tv_box-aarch64.tar.gz
#  rm -f downloads/gl4es-aarch64-debian.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O downloads/gl4es-aarch64-debian.tar.gz
  rm -f downloads/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O downloads/gl4es-aarch64-ubuntu.tar.gz
#  rm -f downloads/xorg-armsoc-aarch64-debian.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/xorg-armsoc-aarch64-debian.tar.gz -O downloads/xorg-armsoc-aarch64-debian.tar.gz
  rm -f downloads/xorg-armsoc-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/xorg-armsoc-aarch64-ubuntu.tar.gz -O downloads/xorg-armsoc-aarch64-ubuntu.tar.gz
  rm -f downloads/opengl-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/opt-mali-s905-aarch64.tar.gz -O downloads/opengl-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  rm -f downloads/opengl-fbdev-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/opt-mali-s905-fbdev-aarch64.tar.gz -O downloads/opengl-fbdev-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  rm -f downloads/opengl-wayland-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/opt-mali-s905-wayland-aarch64.tar.gz -O downloads/opengl-wayland-amlogic_s905_w_x_tv_box-aarch64.tar.gz
fi
