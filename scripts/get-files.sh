#!/bin/bash
#
# please run this script to fetch some large files from various github releases before starting to build images

if [ "$#" != "2" ]; then
  echo ""
  echo "usage: $0 system arch"
  echo ""
  echo "possible system options:"
  echo "               chromebook_snow (armv7l)"
  echo "               chromebook veyron armv7l) (not implemented yet)"
  echo "               odroid_u3 (armv7l)"
  echo "               orbsmart_s92_beelink_r89 (armv7l)"
  echo "               tinkerboard (armv7l)"
  echo "               raspberry_pi (armv7l)"
  echo "               raspberry_pi (aarch64)"
  echo "               raspberry_pi_4 (armv7l) (not implemented yet)"
  echo "               raspberry_pi_4 (aarch64)"
  echo "               amlogic_gx (armv7l)"
  echo "               amlogic_gx (aarch64)"
  echo "               all (all)"
  echo ""
  echo "possible arch options:"
  echo "- armv7l (32bit) userland"
  echo "- aarch64 (64bit) userland"
  echo "- all (32bit and 64bit) userland"
  echo ""
  echo "examples: $0 odroid_u3 armv7l"
  echo "          $0 all all"
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
chromebook_snow_tree_tag="9051dfe1f2198e2ed41c322359ee8324043d55a9"

odroid_u3_release_version="5.4.14-stb-exy%2B"
#odroid_u3_tree_tag="v5.4.14"
odroid_u3_tree_tag="9051dfe1f2198e2ed41c322359ee8324043d55a9"

orbsmart_s92_beelink_r89_release_version="5.4.14-stb-av7%2B"
#orbsmart_s92_beelink_r89_tree_tag="v5.4.14"
orbsmart_s92_beelink_r89_tree_tag="9051dfe1f2198e2ed41c322359ee8324043d55a9"

tinkerboard_release_version="5.4.14-stb-av7%2B"
#tinkerboard_tree_tag="v5.4.14"
tinkerboard_tree_tag="9051dfe1f2198e2ed41c322359ee8324043d55a9"

raspberry_pi_armv7l_release_version="5.4.14-stb-av7%2B"
#raspberry_pi_armv7l_tree_tag="v5.4.14"
raspberry_pi_armv7l_tree_tag="9051dfe1f2198e2ed41c322359ee8324043d55a9"

raspberry_pi_aarch64_release_version="5.4.14-stb-av8%2B"
#raspberry_pi_aarch64_tree_tag="v5.4.14"
raspberry_pi_aarch64_tree_tag="9051dfe1f2198e2ed41c322359ee8324043d55a9"

raspberry_pi_4_aarch64_release_version="5.4.13-rpi-64b%2B"
#raspberry_pi_4_aarch64_tree_tag="v5.4.13"
raspberry_pi_4_aarch64_tree_tag="d2fc980d27675e5de457a26cc65cb611012a4353"

amlogic_gx_release_version="5.4.14-stb-av8%2B"
#amlogic_gx_tree_tag="v5.4.14"
amlogic_gx_tree_tag="9051dfe1f2198e2ed41c322359ee8324043d55a9"

if ([ "$1" = "all" ] || [ "$1" = "chromebook_snow" ]) && [ "$2" = "armv7l" ]; then
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

if ([ "$1" = "all" ] || [ "$1" = "odroid_u3" ]) && [ "$2" = "armv7l" ]; then
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

if ([ "$1" = "all" ] || [ "$1" = "orbsmart_s92_beelink_r89" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}.tar.gz -O downloads/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
  rm -f downloads/kernel-mali-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}-mali-rk3288.tar.gz -O downloads/kernel-mali-orbsmart_s92_beelink_r89-armv7l.tar.gz
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

if ([ "$1" = "all" ] || [ "$1" = "tinkerboard" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-tinkerboard-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${tinkerboard_release_version}/${tinkerboard_release_version}.tar.gz -O downloads/kernel-tinkerboard-armv7l.tar.gz
  rm -f downloads/kernel-mali-tinkerboard-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${tinkerboard_release_version}/${tinkerboard_release_version}-mali-rk3288.tar.gz -O downloads/kernel-mali-tinkerboard-armv7l.tar.gz
  rm -f downloads/boot-tinkerboard-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_tree_tag}/misc.av7/u-boot/boot-tinkerboard-armv7l.dd -O downloads/boot-tinkerboard-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-tinkerboard-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_tree_tag}/misc/opt-mali-rk3288-armv7l.tar.gz -O downloads/opengl-tinkerboard-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-tinkerboard-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_tree_tag}/misc/opt-mali-rk3288-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-tinkerboard-armv7l.tar.gz
  rm -f downloads/opengl-wayland-tinkerboard-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_tree_tag}/misc/opt-mali-rk3288-wayland-armv7l.tar.gz -O downloads/opengl-wayland-tinkerboard-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "raspberry_pi" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-raspberry_pi-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_armv7l_release_version}/${raspberry_pi_armv7l_release_version}.tar.gz -O downloads/kernel-raspberry_pi-armv7l.tar.gz
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_armv7l_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_armv7l_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-rpi-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_armv7l_tree_tag}/misc/opt-mesa-rpi-armv7l-debian.tar.gz -O downloads/opengl-rpi-armv7l-debian.tar.gz
  rm -f downloads/opengl-rpi-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_armv7l_tree_tag}/misc/opt-mesa-rpi-armv7l-ubuntu.tar.gz -O downloads/opengl-rpi-armv7l-ubuntu.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "raspberry_pi" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-raspberry_pi-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_aarch64_release_version}/${raspberry_pi_aarch64_release_version}.tar.gz -O downloads/kernel-raspberry_pi-aarch64.tar.gz
  rm -f downloads/gl4es-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_aarch64_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O downloads/gl4es-aarch64-debian.tar.gz
  rm -f downloads/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_aarch64_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O downloads/gl4es-aarch64-ubuntu.tar.gz
  rm -f downloads/opengl-rpi-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_aarch64_tree_tag}/misc/opt-mesa-rpi-aarch64-debian.tar.gz -O downloads/opengl-rpi-aarch64-debian.tar.gz
  rm -f downloads/opengl-rpi-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_aarch64_tree_tag}/misc/opt-mesa-rpi-aarch64-ubuntu.tar.gz -O downloads/opengl-rpi-aarch64-ubuntu.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "raspberry_pi_4" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-raspberry_pi_4-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-raspberry-pi-4-kernel/releases/download/${raspberry_pi_4_aarch64_release_version}/${raspberry_pi_4_aarch64_release_version}.tar.gz -O downloads/kernel-raspberry_pi_4-aarch64.tar.gz
  rm -f downloads/gl4es-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_aarch64_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O downloads/gl4es-aarch64-debian.tar.gz
  rm -f downloads/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_aarch64_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O downloads/gl4es-aarch64-ubuntu.tar.gz
  rm -f downloads/opengl-rpi-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_aarch64_tree_tag}/misc/opt-mesa-rpi-aarch64-debian.tar.gz -O downloads/opengl-rpi-aarch64-debian.tar.gz
  rm -f downloads/opengl-rpi-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_aarch64_tree_tag}/misc/opt-mesa-rpi-aarch64-ubuntu.tar.gz -O downloads/opengl-rpi-aarch64-ubuntu.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "amlogic_gx" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-amlogic_gx_armv7l-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}.tar.gz -O downloads/kernel-amlogic_gx-armv7l.tar.gz
  rm -f downloads/kernel-mali-amlogic_gx_armv7l-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}-mali-s905.tar.gz -O downloads/kernel-mali-amlogic_gx-armv7l.tar.gz
  rm -f downloads/boot-amlogic_gx-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc.av8/u-boot/boot-odroid_c2-aarch64.dd -O downloads/boot-amlogic_gx-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-fbdev-amlogic_gx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/opt-mali-s905-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-amlogic_gx-armv7l.tar.gz
  rm -f downloads/opengl-wayland-amlogic_gx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/opt-mali-s905-wayland-armv7l.tar.gz -O downloads/opengl-wayland-amlogic_gx-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "amlogic_gx" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-amlogic_gx_armv7l-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}.tar.gz -O downloads/kernel-amlogic_gx-aarch64.tar.gz
  rm -f downloads/kernel-mali-amlogic_gx_armv7l-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}-mali-s905.tar.gz -O downloads/kernel-mali-amlogic_gx-aarch64.tar.gz
  rm -f downloads/boot-amlogic_gx-aarch64.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc.av8/u-boot/boot-odroid_c2-aarch64.dd -O downloads/boot-amlogic_gx-aarch64.dd
  rm -f downloads/gl4es-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O downloads/gl4es-aarch64-debian.tar.gz
  rm -f downloads/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O downloads/gl4es-aarch64-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/xorg-armsoc-aarch64-debian.tar.gz -O downloads/xorg-armsoc-aarch64-debian.tar.gz
  rm -f downloads/xorg-armsoc-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/xorg-armsoc-aarch64-ubuntu.tar.gz -O downloads/xorg-armsoc-aarch64-ubuntu.tar.gz
  rm -f downloads/opengl-amlogic_gx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/opt-mali-s905-aarch64.tar.gz -O downloads/opengl-amlogic_gx-aarch64.tar.gz
  rm -f downloads/opengl-fbdev-amlogic_gx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/opt-mali-s905-fbdev-aarch64.tar.gz -O downloads/opengl-fbdev-amlogic_gx-aarch64.tar.gz
  rm -f downloads/opengl-wayland-amlogic_gx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_tree_tag}/misc/opt-mali-s905-wayland-aarch64.tar.gz -O downloads/opengl-wayland-amlogic_gx-aarch64.tar.gz
fi
