#!/bin/bash
#
# please run this script to fetch some large files from various github releases before starting to build images

if [ "$#" != "1" ]; then
  echo ""
  echo "usage: $0 system"
  echo "system can be: chromebook_snow"
  echo "               odroid_u3"
  echo "               orbsmart_s92_beelink_r89"
  echo "               raspberry_pi_3_32"
  echo "               raspberry_pi_3_64"
  echo "               amlogic_s905_w_x_tv_box_32"
  echo "               amlogic_s905_w_x_tv_box"
  echo "               all"
  echo ""
  echo "examples: $0 odroid_u3"
  echo "          $0 all"
  echo ""
  exit 1
fi

cd `dirname $0`/..

chromebook_snow_release_version="5.4.14-stb-cbe%2B"
chromebook_snow_tree_tag="v5.4.14"

odroid_u3_release_version="5.4.14-stb-exy%2B"
odroid_u3_tree_tag="v5.4.14"

orbsmart_s92_beelink_r89_release_version="5.4.14-stb-av7%2B"
orbsmart_s92_beelink_r89_tree_tag="v5.4.14"

raspberry_pi_3_32_release_version="5.4.14-stb-av7%2B"
raspberry_pi_3_32_tree_tag="v5.4.14"

raspberry_pi_3_64_release_version="5.4.14-stb-av8%2B"
raspberry_pi_3_64_tree_tag="v5.4.14"

raspberry_pi_4_64_release_version="5.4.13-rpi-64b%2B"
raspberry_pi_4_64_tree_tag="v5.4.13"

amlogic_s905_w_x_tv_box_release_version="5.4.14-stb-av8%2B"
amlogic_s905_w_x_tv_box_tree_tag="v5.4.14"

if [ "$1" = "all" ] || [ "$1" = "chromebook_snow" ]; then
  rm -f boot/kernel-chromebook_snow-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_snow_release_version}/${chromebook_snow_release_version}.tar.gz -O boot/kernel-chromebook_snow-armv7l.tar.gz
  rm -f boot/boot-chromebook_snow-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc.cbe/boot/boot-chromebook_snow-armv7l.dd -O boot/boot-chromebook_snow-armv7l.dd
  rm -f files/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O files/gl4es-armv7l-debian.tar.gz
  rm -f files/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O files/gl4es-armv7l-ubuntu.tar.gz
  rm -f files/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O files/xorg-armsoc-armv7l-debian.tar.gz
  rm -f files/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O files/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f files/opengl-chromebook_snow-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/opt-mali-exynos5250.tar.gz -O files/opengl-chromebook_snow-armv7l.tar.gz
  rm -f files/opengl-fbdev-chromebook_snow-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_tree_tag}/misc/opt-mali-exynos5250-fbdev-r5p0.tar.gz -O files/opengl-fbdev-chromebook_snow-armv7l.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "odroid_u3" ]; then
  rm -f boot/kernel-odroid_u3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${odroid_u3_release_version}/${odroid_u3_release_version}.tar.gz -O boot/kernel-odroid_u3-armv7l.tar.gz
  rm -f boot/boot-odroid_u3-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc.exy/u-boot/boot-odroid_u3-armv7l.dd -O boot/boot-odroid_u3-armv7l.dd
  rm -f files/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O files/gl4es-armv7l-debian.tar.gz
  rm -f files/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O files/gl4es-armv7l-ubuntu.tar.gz
  rm -f files/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O files/xorg-armsoc-armv7l-debian.tar.gz
  rm -f files/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O files/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f files/opengl-odroid_u3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/opt-mali-exynos4412.tar.gz -O files/opengl-odroid_u3-armv7l.tar.gz
  rm -f files/opengl-fbdev-odroid_u3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_tree_tag}/misc/opt-mali-exynos4412-fbdev.tar.gz -O files/opengl-fbdev-odroid_u3-armv7l.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "orbsmart_s92_beelink_r89" ]; then
  rm -f boot/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}.tar.gz -O boot/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
  rm -f files/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O files/gl4es-armv7l-debian.tar.gz
  rm -f files/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O files/gl4es-armv7l-ubuntu.tar.gz
  rm -f files/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O files/xorg-armsoc-armv7l-debian.tar.gz
  rm -f files/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O files/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f files/opengl-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/opt-mali-rk3288.tar.gz -O files/opengl-orbsmart_s92_beelink_r89-armv7l.tar.gz
  rm -f files/opengl-fbdev-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/opt-mali-rk3288-fbdev.tar.gz -O files/opengl-fbdev-orbsmart_s92_beelink_r89-armv7l.tar.gz
  rm -f files/opengl-wayland-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_tree_tag}/misc/opt-mali-rk3288-wayland.tar.gz -O files/opengl-wayland-orbsmart_s92_beelink_r89-armv7l.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "raspberry_pi_3_32" ]; then
  rm -f boot/kernel-raspberry_pi_3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_3_32_release_version}/${raspberry_pi_3_32_release_version}.tar.gz -O boot/kernel-raspberry_pi_3-armv7l.tar.gz
#  rm -f files/gl4es-armv7l-debian.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_32_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O files/gl4es-armv7l-debian.tar.gz
#  rm -f files/gl4es-armv7l-ubuntu.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_32_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O files/gl4es-armv7l-ubuntu.tar.gz
#  rm -f files/opengl-raspberry_pi-armv7l.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_32_tree_tag}/misc/opt-mesa-raspberry-pi-armv7l.tar.gz -O files/opengl-raspberry_pi-armv7l.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "raspberry_pi_3_64" ]; then
  rm -f boot/kernel-raspberry_pi_3-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_3_64_release_version}/${raspberry_pi_3_64_release_version}.tar.gz -O boot/kernel-raspberry_pi_3-aarch64.tar.gz
#  rm -f files/gl4es-aarch64-debian.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_64_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O files/gl4es-aarch64-debian.tar.gz
#  rm -f files/gl4es-aarch64-ubuntu.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_64_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O files/gl4es-aarch64-ubuntu.tar.gz
#  rm -f files/opengl-raspberry_pi-aarch64.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_3_64_tree_tag}/misc/opt-mesa-raspberry-pi-aarch64.tar.gz -O files/opengl-raspberry_pi-aarch64.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "raspberry_pi_4_64" ]; then
  rm -f boot/kernel-raspberry_pi_4-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-raspberry-pi-4-64bit-kernel/releases/download/${raspberry_pi_4_64_release_version}/${raspberry_pi_4_64_release_version}.tar.gz -O boot/kernel-raspberry_pi_4-aarch64.tar.gz
#  rm -f files/gl4es-aarch64-debian.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-raspberry-pi-4-64bit-kernel/raw/${raspberry_pi_4_64_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O files/gl4es-aarch64-debian.tar.gz
#  rm -f files/gl4es-aarch64-ubuntu.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-raspberry-pi-4-64bit-kernel/raw/${raspberry_pi_4_64_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O files/gl4es-aarch64-ubuntu.tar.gz
#  rm -f files/opengl-raspberry_pi-aarch64.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-raspberry-pi-4-64bit-kernel/raw/${raspberry_pi_4_64_tree_tag}/misc/opt-mesa-raspberry-pi-aarch64.tar.gz -O files/opengl-raspberry_pi-aarch64.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "amlogic_s905_w_x_tv_box_32" ]; then
  rm -f boot/kernel-amlogic_s905_w_x_tv_box_32-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_s905_w_x_tv_box_release_version}/${amlogic_s905_w_x_tv_box_release_version}.tar.gz -O boot/kernel-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  rm -f boot/kernel-mali-amlogic_s905_w_x_tv_box_32-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_s905_w_x_tv_box_release_version}/${amlogic_s905_w_x_tv_box_release_version}-mali-s905.tar.gz -O boot/kernel-mali-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  rm -f files/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O files/gl4es-armv7l-debian.tar.gz
  rm -f files/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O files/gl4es-armv7l-ubuntu.tar.gz
  rm -f files/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O files/xorg-armsoc-armv7l-debian.tar.gz
  rm -f files/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O files/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f files/opengl-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/opt-mali-s905-32.tar.gz -O files/opengl-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  rm -f files/opengl-fbdev-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/opt-mali-s905-fbdev-32.tar.gz -O files/opengl-fbdev-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  rm -f files/opengl-wayland-amlogic_s905_w_x_tv_box-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/opt-mali-s905-wayland-32.tar.gz -O files/opengl-wayland-amlogic_s905_w_x_tv_box-armv7l.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "amlogic_s905_w_x_tv_box" ]; then
  rm -f boot/kernel-amlogic_s905_w_x_tv_box_32-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_s905_w_x_tv_box_release_version}/${amlogic_s905_w_x_tv_box_release_version}.tar.gz -O boot/kernel-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  rm -f boot/kernel-mali-amlogic_s905_w_x_tv_box_32-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_s905_w_x_tv_box_release_version}/${amlogic_s905_w_x_tv_box_release_version}-mali-s905.tar.gz -O boot/kernel-mali-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  rm -f files/gl4es-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O files/gl4es-aarch64-debian.tar.gz
  rm -f files/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O files/gl4es-aarch64-ubuntu.tar.gz
  rm -f files/xorg-armsoc-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/xorg-armsoc-aarch64-debian.tar.gz -O files/xorg-armsoc-aarch64-debian.tar.gz
  rm -f files/xorg-armsoc-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/xorg-armsoc-aarch64-ubuntu.tar.gz -O files/xorg-armsoc-aarch64-ubuntu.tar.gz
  rm -f files/opengl-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/opt-mali-s905.tar.gz -O files/opengl-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  rm -f files/opengl-fbdev-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/opt-mali-s905-fbdev.tar.gz -O files/opengl-fbdev-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  rm -f files/opengl-wayland-amlogic_s905_w_x_tv_box-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_s905_w_x_tv_box_tree_tag}/misc/opt-mali-s905-wayland.tar.gz -O files/opengl-wayland-amlogic_s905_w_x_tv_box-aarch64.tar.gz
fi
