#!/bin/bash
#
# please run this script to fetch some large files from various github releases before starting to build images

if [ "$#" != "3" ]; then
  echo ""
  echo "usage: $0 system arch release"
  echo ""
  echo "possible system options:"
  echo "               chromebook_snow (armv7l) (not yet supported)"
  echo "               chromebook_veyron (armv7l) (not yet supported)"
  echo "               chromebook_nyan (armv7l) (not yet supported)"
  echo "               allwinner_h3 (armv7l) (not yet supported)"
  echo "               amlogic_m8 (armv7l) (not yet supported)"
  echo "               odroid_u3 (armv7l)"
  echo "               odroid_xu4 (armv7l) (not yet supported)"
  echo "               orbsmart_s92_beelink_r89 (armv7l) (not yet supported)"
  echo "               rockchip_rk322x (armv7l) (not yet supported)"
  echo "               tinkerboard (armv7l) (not yet supported)"
  echo "               raspberry_pi_2 (armv7l) (not yet supported)"
  echo "               raspberry_pi_3 (aarch64) (not yet supported)"
  echo "               raspberry_pi_4 (aarch64) (not yet supported)"
  echo "               amlogic_gx (aarch64)"
  echo "               allwinner_h6 (aarch64) (not yet supported)"
  echo "               rockchip_rk33xx (aarch64)"
  echo "               all (all) (not yet supported)"
  echo ""
  echo "possible arch options:"
  echo "- armv7l (32bit)"
  echo "- aarch64 (64bit)"
  echo "- all (32bit and 64bit)"
  echo ""
  echo "possible release options:"
  echo "- focal (ubuntu)"
  echo "- bullseye (debian) (not yet supported)"
  echo "- all (ubuntu and debian) (not yet supported)"
  echo ""
  echo "examples: $0 odroid_u3 armv7l focal"
  echo "          $0 all all all"
  echo ""
  exit 1
fi

cd `dirname $0`/..

# create downloads dir
mkdir downloads

# exit on errors
set -e

# get version information for below
. scripts/versions.conf

if ([ "$1" = "all" ] || [ "$1" = "chromebook_snow" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-chromebook_snow-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_snow_release_version}/${chromebook_snow_release_version}.tar.gz -O downloads/kernel-chromebook_snow-armv7l.tar.gz
  rm -f downloads/boot-chromebook_snow-armv7l.dd
  # we assemble the bootblocks from a prepared chromebook partition table and the proper u-boot kpart image
  cp files/chromebook-boot/cb.dd-single-part downloads/boot-chromebook_snow-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_snow_uboot_version}/uboot.kpart.cbe.gz -O - | gunzip -c >> downloads/boot-chromebook_snow-armv7l.dd
fi

if ([ "$1" = "all" ] || [ "$1" = "chromebook_veyron" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-chromebook_veyron-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_veyron_release_version}/${chromebook_veyron_release_version}.tar.gz -O downloads/kernel-chromebook_veyron-armv7l.tar.gz
  rm -f downloads/boot-chromebook_veyron-armv7l.dd
  # we assemble the bootblocks from a prepared chromebook partition table and the proper u-boot kpart image
  cp files/chromebook-boot/cb.dd-single-part downloads/boot-chromebook_veyron-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_veyron_uboot_version}/uboot.kpart.cbr-jerry.gz -O - | gunzip -c >> downloads/boot-chromebook_veyron-armv7l.dd
fi

if ([ "$1" = "all" ] || [ "$1" = "chromebook_nyan" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-chromebook_nyan-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-tegra-k1-kernel/releases/download/${chromebook_nyan_release_version}/${chromebook_nyan_release_version}.tar.gz -O downloads/kernel-chromebook_nyan-armv7l.tar.gz
  rm -f downloads/boot-chromebook_nyan-armv7l.dd
  # we assemble the bootblocks from a prepared chromebook partition table and the proper u-boot kpart image
  cp files/chromebook-boot/cb.dd-single-part downloads/boot-chromebook_nyan-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_uboot_version}/uboot.kpart.cbt.gz -O - | gunzip -c >> downloads/boot-chromebook_nyan-armv7l.dd
fi

if ([ "$1" = "all" ] || [ "$1" = "allwinner_h3" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-allwinner_h3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h3_release_version}/${allwinner_h3_release_version}.tar.gz -O downloads/kernel-allwinner_h3-armv7l.tar.gz
#  rm -f downloads/kernel-mali-allwinner_h3-armv7l.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h3_release_version}/${allwinner_h3_release_version}-mali-sunxi.tar.gz -O downloads/kernel-mali-allwinner_h3-armv7l.tar.gz
  rm -f downloads/boot-allwinner_h3-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h3_uboot_version}/r39-boot.dd.gz -O - | gunzip -c >> downloads/boot-allwinner_h3-armv7l.dd
fi

if ([ "$1" = "all" ] || [ "$1" = "odroid_u3" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-odroid_u3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${odroid_u3_release_version}/${odroid_u3_release_version}.tar.gz -O downloads/kernel-odroid_u3-armv7l.tar.gz
  rm -f downloads/boot-odroid_u3-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${odroid_u3_uboot_version}/exy-boot.dd.gz -O - | gunzip -c >> downloads/boot-odroid_u3-armv7l.dd
fi

if ([ "$1" = "all" ] || [ "$1" = "amlogic_m8" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-amlogic_m8-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-amlogic-kernel/releases/download/${amlogic_m8_release_version}/${amlogic_m8_release_version}.tar.gz -O downloads/kernel-amlogic_m8-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "odroid_xu4" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-odroid_xu4-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/releases/download/${odroid_xu4_release_version}/${odroid_xu4_release_version}.tar.gz -O downloads/kernel-odroid_xu4-armv7l.tar.gz
  rm -f downloads/boot-odroid_xu4-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${odroid_xu4_uboot_version}/e54-boot.dd.gz -O - | gunzip -c >> downloads/boot-odroid_xu4-armv7l.dd
fi

if ([ "$1" = "all" ] || [ "$1" = "orbsmart_s92_beelink_r89" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}.tar.gz -O downloads/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
#  rm -f downloads/kernel-mali-orbsmart_s92_beelink_r89-armv7l.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}-mali-rk3288.tar.gz -O downloads/kernel-mali-orbsmart_s92_beelink_r89-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "rockchip_rk322x" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-rockchip_rk322x-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/releases/download/${rockchip_rk322x_release_version}/${rockchip_rk322x_release_version}.tar.gz -O downloads/kernel-rockchip_rk322x-armv7l.tar.gz
  rm -f downloads/boot-rockchip_rk322x-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/raw/${rockchip_rk322x_tree_tag}/misc.322/u-boot/boot-rockchip_rk3229_r39_4k-armv7l.dd -O downloads/boot-rockchip_rk322x-armv7l.dd
fi

if ([ "$1" = "all" ] || [ "$1" = "tinkerboard" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-tinkerboard-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${tinkerboard_release_version}/${tinkerboard_release_version}.tar.gz -O downloads/kernel-tinkerboard-armv7l.tar.gz
#  rm -f downloads/kernel-mali-tinkerboard-armv7l.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${tinkerboard_release_version}/${tinkerboard_release_version}-mali-rk3288.tar.gz -O downloads/kernel-mali-tinkerboard-armv7l.tar.gz
  rm -f downloads/boot-tinkerboard-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_generic_tree_tag}/misc.av7/u-boot/boot-tinkerboard-armv7l.dd -O downloads/boot-tinkerboard-armv7l.dd
fi

if ([ "$1" = "all" ] || [ "$1" = "raspberry_pi_2" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-raspberry_pi-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_2_release_version}/${raspberry_pi_2_release_version}.tar.gz -O downloads/kernel-raspberry_pi-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "raspberry_pi_3" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-raspberry_pi-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_3_release_version}/${raspberry_pi_3_release_version}.tar.gz -O downloads/kernel-raspberry_pi-aarch64.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "raspberry_pi_4" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-raspberry_pi_4-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-raspberry-pi-4-kernel/releases/download/${raspberry_pi_4_release_version}/${raspberry_pi_4_release_version}.tar.gz -O downloads/kernel-raspberry_pi_4-aarch64.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "amlogic_gx" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-amlogic_gx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}.tar.gz -O downloads/kernel-amlogic_gx-aarch64.tar.gz
#  rm -f downloads/kernel-mali-amlogic_gx-aarch64.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}-mali-s905.tar.gz -O downloads/kernel-mali-amlogic_gx-aarch64.tar.gz
  rm -f downloads/boot-amlogic_gx-aarch64.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc.av8/u-boot/boot-odroid_c2-aarch64.dd -O downloads/boot-amlogic_gx-aarch64.dd
fi

if ([ "$1" = "all" ] || [ "$1" = "allwinner_h6" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-allwinner_h6-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}.tar.gz -O downloads/kernel-allwinner_h6-aarch64.tar.gz
#  rm -f downloads/kernel-mali-allwinner_h6-aarch64.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}-mali-h6.tar.gz -O downloads/kernel-mali-allwinner_h6-aarch64.tar.gz
  rm -f downloads/boot-allwinner_h6-aarch64.dd
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h6_uboot_version}/boot-allwinner_h6-aarch64.dd.gz -O - | gunzip -c >> downloads/boot-allwinner_h6-aarch64.dd
fi

if ([ "$1" = "all" ] || [ "$1" = "rockchip_rk33xx" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-rockchip_rk33xx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}.tar.gz -O downloads/kernel-rockchip_rk33xx-aarch64.tar.gz
#  rm -f downloads/kernel-mali-rockchip_rk33xx-aarch64.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}-mali-rk3328.tar.gz -O downloads/kernel-mali-rockchip_rk33xx-aarch64.tar.gz
#  rm -f downloads/kernel-mali-b-rockchip_rk33xx-aarch64.tar.gz
#  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}-mali-rk3399.tar.gz -O downloads/kernel-mali-b-alt-rockchip_rk33xx-aarch64.tar.gz
  rm -f downloads/boot-rockchip_rk33xx-aarch64.dd
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${rockchip_rk33xx_uboot_version}/boot-rk3328-ddrbin-spl-aarch64.dd.gz -O - | gunzip -c >> downloads/boot-rockchip_rk33xx-aarch64.dd
fi
