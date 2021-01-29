#!/bin/bash
#
# please run this script to fetch some large files from various github releases before starting to build images

if [ "$#" != "2" ]; then
  echo ""
  echo "usage: $0 system arch"
  echo ""
  echo "possible system options:"
  echo "               chromebook_snow (armv7l)"
  echo "               chromebook_veyron (armv7l)"
  echo "               chromebook_nyanbig (armv7l)"
  echo "               allwinner_h3 (armv7l)"
  echo "               amlogic_m8 (armv7l)"
  echo "               odroid_u3 (armv7l)"
  echo "               odroid_xu4 (armv7l)"
  echo "               orbsmart_s92_beelink_r89 (armv7l)"
  echo "               rockchip_rk322x (armv7l)"
  echo "               tinkerboard (armv7l)"
  echo "               raspberry_pi (armv7l)"
  echo "               raspberry_pi (aarch64)"
  echo "               raspberry_pi_4 (armv7l) (using a 64bit kernel)"
  echo "               raspberry_pi_4 (aarch64)"
  echo "               amlogic_gx (armv7l) (using a 64bit kernel)"
  echo "               amlogic_gx (aarch64)"
  echo "               allwinner_h6 (armv7l) (using a 64bit kernel)"
  echo "               allwinner_h6 (aarch64)"
  echo "               rockchip_rk33xx (armv7l) (using a 64bit kernel)"
  echo "               rockchip_rk33xx (aarch64)"
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

generic_tree_tag="159a54b4e55cde9f5c19d98496fa5dacd1f13f95"

chromebook_snow_release_version="5.4.58-stb-cbe%2B"
chromebook_snow_uboot_version="v2020.04-cbe"
chromebook_snow_generic_tree_tag=${generic_tree_tag}

chromebook_veyron_release_version="5.4.58-stb-cbr%2B"
chromebook_veyron_uboot_version="v2017.09-cbr"
chromebook_veyron_generic_tree_tag=${generic_tree_tag}

chromebook_nyanbig_release_version="5.4.35-ntg-cbt%2B"
chromebook_nyanbig_uboot_version="v2018.11-cbt"
chromebook_nyanbig_generic_tree_tag=${generic_tree_tag}
chromebook_nyanbig_mesa_release_version="20.1.6"

allwinner_h3_release_version="5.6.13-stb-ah3%2B"
allwinner_h3_generic_tree_tag=${generic_tree_tag}
allwinner_h3_uboot_version="200718-01"

amlogic_m8_release_version="5.6.19-stb-m8x%2B"
amlogic_m8_generic_tree_tag=${generic_tree_tag}

odroid_u3_release_version="5.4.58-stb-exy%2B"
odroid_u3_generic_tree_tag=${generic_tree_tag}
odroid_u3_uboot_version="200821-01"

odroid_xu4_release_version="5.4.58-stb-e54%2B"
odroid_xu4_generic_tree_tag=${generic_tree_tag}
odroid_xu4_mali_tree_tag="4b25cd43f7aa853f35b17033b713d46e785c11cd"
odroid_xu4_uboot_version="200718-01"

orbsmart_s92_beelink_r89_release_version="5.4.58-stb-av7%2B"
orbsmart_s92_beelink_r89_generic_tree_tag=${generic_tree_tag}

rockchip_rk322x_release_version="4.4.194-rkc-322"
rockchip_rk322x_generic_tree_tag=${generic_tree_tag}
rockchip_rk322x_tree_tag="e8c89a16da9860c600e49772db3b7f01331624b9"

tinkerboard_release_version="5.4.58-stb-av7%2B"
tinkerboard_generic_tree_tag=${generic_tree_tag}

raspberry_pi_armv7l_release_version="5.4.58-stb-av7%2B"
raspberry_pi_armv7l_generic_tree_tag=${generic_tree_tag}
raspberry_pi_armv7l_mesa_release_version="20.1.6"

raspberry_pi_aarch64_release_version="5.4.58-stb-av8%2B"
raspberry_pi_aarch64_generic_tree_tag=${generic_tree_tag}
raspberry_pi_aarch64_mesa_release_version="20.1.6"

raspberry_pi_4_armv7l_release_version="5.8.2-rpi-64b%2B"
raspberry_pi_4_armv7l_generic_tree_tag=${generic_tree_tag}
raspberry_pi_4_armv7l_mesa_release_version="20.1.6"

raspberry_pi_4_aarch64_release_version="5.8.2-rpi-64b%2B"
raspberry_pi_4_aarch64_generic_tree_tag=${generic_tree_tag}
raspberry_pi_4_aarch64_mesa_release_version="20.1.6"

amlogic_gx_release_version="5.4.58-stb-av8%2B"
amlogic_gx_generic_tree_tag=${generic_tree_tag}

allwinner_h6_release_version="5.6.13-stb-ah6%2B"
allwinner_h6_generic_tree_tag=${generic_tree_tag}
allwinner_h6_tree_tag="79e45cbdf1bdcbaf0867243c65c99a43990b7bc2"
allwinner_h6_uboot_version="200718-01"

rockchip_rk33xx_release_version="5.6.13-stb-rkc%2B"
rockchip_rk33xx_generic_tree_tag=${generic_tree_tag}
rockchip_rk33xx_tree_tag="6ae92d42b8513626fee96e6b7728666915c85fd5"

if ([ "$1" = "all" ] || [ "$1" = "chromebook_snow" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-chromebook_snow-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_snow_release_version}/${chromebook_snow_release_version}.tar.gz -O downloads/kernel-chromebook_snow-armv7l.tar.gz
  rm -f downloads/boot-chromebook_snow-armv7l.dd
  # we assemble the bootblocks from a prepared chromebook partition table and the proper u-boot kpart image
  cp files/chromebook-boot/cb.dd-single-part downloads/boot-chromebook_snow-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_snow_uboot_version}/uboot.kpart.cbe.gz -O - | gunzip -c >> downloads/boot-chromebook_snow-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_generic_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_generic_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-chromebook_snow-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_generic_tree_tag}/misc/opt-mali-exynos5250-armv7l.tar.gz -O downloads/opengl-chromebook_snow-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-chromebook_snow-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_generic_tree_tag}/misc/opt-mali-exynos5250-fbdev-r5p0-armv7l.tar.gz -O downloads/opengl-fbdev-chromebook_snow-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "chromebook_veyron" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-chromebook_veyron-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_veyron_release_version}/${chromebook_veyron_release_version}.tar.gz -O downloads/kernel-chromebook_veyron-armv7l.tar.gz
  rm -f downloads/boot-chromebook_veyron-armv7l.dd
  # we assemble the bootblocks from a prepared chromebook partition table and the proper u-boot kpart image
  cp files/chromebook-boot/cb.dd-single-part downloads/boot-chromebook_veyron-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_veyron_uboot_version}/uboot.kpart.cbr.gz -O - | gunzip -c >> downloads/boot-chromebook_veyron-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_veyron_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_veyron_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_veyron_generic_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_veyron_generic_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-chromebook_veyron-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_veyron_generic_tree_tag}/misc/opt-mali-rk3288-armv7l.tar.gz -O downloads/opengl-chromebook_veyron-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-chromebook_veyron-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_veyron_generic_tree_tag}/misc/opt-mali-rk3288-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-chromebook_veyron-armv7l.tar.gz
  rm -f downloads/opengl-wayland-chromebook_veyron-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_veyron_generic_tree_tag}/misc/opt-mali-rk3288-wayland-armv7l.tar.gz -O downloads/opengl-wayland-chromebook_veyron-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "chromebook_nyanbig" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-chromebook_nyanbig-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-tegra-k1-kernel/releases/download/${chromebook_nyanbig_release_version}/${chromebook_nyanbig_release_version}.tar.gz -O downloads/kernel-chromebook_nyanbig-armv7l.tar.gz
  rm -f downloads/boot-chromebook_nyanbig-armv7l.dd
  # we assemble the bootblocks from a prepared chromebook partition table and the proper u-boot kpart image
  cp files/chromebook-boot/cb.dd-single-part downloads/boot-chromebook_nyanbig-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyanbig_uboot_version}/uboot.kpart.cbt.gz -O - | gunzip -c >> downloads/boot-chromebook_nyanbig-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_nyanbig_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_nyanbig_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-mesa-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/mesa-etc-build/releases/download/${chromebook_nyanbig_mesa_release_version}/opt-mesa-armv7l-debian.tar.gz -O downloads/opengl-mesa-armv7l-debian.tar.gz
  rm -f downloads/opengl-mesa-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/mesa-etc-build/releases/download/${chromebook_nyanbig_mesa_release_version}/opt-mesa-armv7l-ubuntu.tar.gz -O downloads/opengl-mesa-armv7l-ubuntu.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "allwinner_h3" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-allwinner_h3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h3_release_version}/${allwinner_h3_release_version}.tar.gz -O downloads/kernel-allwinner_h3-armv7l.tar.gz
  rm -f downloads/kernel-mali-allwinner_h3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h3_release_version}/${allwinner_h3_release_version}-mali-sunxi.tar.gz -O downloads/kernel-mali-allwinner_h3-armv7l.tar.gz
  rm -f downloads/boot-allwinner_h3-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h3_uboot_version}/r39-boot.dd.gz -O - | gunzip -c >> downloads/boot-allwinner_h3-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h3_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h3_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-allwinner_h3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h3_generic_tree_tag}/misc/opt-mali-sunxi-armv7l.tar.gz -O downloads/opengl-allwinner_h3-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-allwinner_h3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h3_generic_tree_tag}/misc//opt-mali-sunxi-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-allwinner_h3-armv7l.tar.gz
  rm -f downloads/opengl-wayland-allwinner_h3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h3_generic_tree_tag}/misc//opt-mali-sunxi-wayland-armv7l.tar.gz -O downloads/opengl-wayland-allwinner_h3-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "odroid_u3" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-odroid_u3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${odroid_u3_release_version}/${odroid_u3_release_version}.tar.gz -O downloads/kernel-odroid_u3-armv7l.tar.gz
  rm -f downloads/boot-odroid_u3-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${odroid_u3_uboot_version}/exy-boot.dd.gz -O - | gunzip -c >> downloads/boot-odroid_u3-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_generic_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_generic_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-odroid_u3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_generic_tree_tag}/misc/opt-mali-exynos4412-armv7l.tar.gz -O downloads/opengl-odroid_u3-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-odroid_u3-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_generic_tree_tag}/misc/opt-mali-exynos4412-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-odroid_u3-armv7l.tar.gz
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
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_xu4_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_xu4_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_xu4_generic_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_xu4_generic_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-odroid_xu4-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${odroid_xu4_mali_tree_tag}/misc.e54/opt-mali-exynos5422-armv7l.tar.gz -O downloads/opengl-odroid_xu4-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-odroid_xu4-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${odroid_xu4_mali_tree_tag}/misc.e54/opt-mali-exynos5422-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-odroid_xu4-armv7l.tar.gz
  rm -f downloads/opengl-wayland-odroid_xu4-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${odroid_xu4_mali_tree_tag}/misc.e54/opt-mali-exynos5422-wayland-armv7l.tar.gz -O downloads/opengl-wayland-odroid_xu4-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "orbsmart_s92_beelink_r89" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}.tar.gz -O downloads/kernel-orbsmart_s92_beelink_r89-armv7l.tar.gz
  rm -f downloads/kernel-mali-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${orbsmart_s92_beelink_r89_release_version}/${orbsmart_s92_beelink_r89_release_version}-mali-rk3288.tar.gz -O downloads/kernel-mali-orbsmart_s92_beelink_r89-armv7l.tar.gz
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_generic_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_generic_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_generic_tree_tag}/misc/opt-mali-rk3288-armv7l.tar.gz -O downloads/opengl-orbsmart_s92_beelink_r89-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_generic_tree_tag}/misc/opt-mali-rk3288-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-orbsmart_s92_beelink_r89-armv7l.tar.gz
  rm -f downloads/opengl-wayland-orbsmart_s92_beelink_r89-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${orbsmart_s92_beelink_r89_generic_tree_tag}/misc/opt-mali-rk3288-wayland-armv7l.tar.gz -O downloads/opengl-wayland-orbsmart_s92_beelink_r89-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "rockchip_rk322x" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-rockchip_rk322x-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/releases/download/${rockchip_rk322x_release_version}/${rockchip_rk322x_release_version}.tar.gz -O downloads/kernel-rockchip_rk322x-armv7l.tar.gz
  rm -f downloads/boot-rockchip_rk322x-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/raw/${rockchip_rk322x_tree_tag}/misc.322/u-boot/boot-rockchip_rk3229_r39_4k-armv7l.dd -O downloads/boot-rockchip_rk322x-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk322x_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk322x_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/raw/${rockchip_rk322x_tree_tag}/misc.322/xorg-armsoc-rk322x-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/raw/${rockchip_rk322x_tree_tag}/misc.322/xorg-armsoc-rk322x-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-rockchip_rk322x-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/raw/${rockchip_rk322x_tree_tag}/misc.322/opt-mali-rk322x-armv7l.tar.gz -O downloads/opengl-rockchip_rk322x-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-rockchip_rk322x-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/raw/${rockchip_rk322x_tree_tag}/misc.322/opt-mali-rk322x-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-rockchip_rk322x-armv7l.tar.gz
  rm -f downloads/opengl-wayland-rockchip_rk322x-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-rockchip-rk322x-kernel/raw/${rockchip_rk322x_tree_tag}/misc.322/opt-mali-rk322x-wayland-armv7l.tar.gz -O downloads/opengl-wayland-rockchip_rk322x-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "tinkerboard" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-tinkerboard-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${tinkerboard_release_version}/${tinkerboard_release_version}.tar.gz -O downloads/kernel-tinkerboard-armv7l.tar.gz
  rm -f downloads/kernel-mali-tinkerboard-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${tinkerboard_release_version}/${tinkerboard_release_version}-mali-rk3288.tar.gz -O downloads/kernel-mali-tinkerboard-armv7l.tar.gz
  rm -f downloads/boot-tinkerboard-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_generic_tree_tag}/misc.av7/u-boot/boot-tinkerboard-armv7l.dd -O downloads/boot-tinkerboard-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_generic_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_generic_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-tinkerboard-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_generic_tree_tag}/misc/opt-mali-rk3288-armv7l.tar.gz -O downloads/opengl-tinkerboard-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-tinkerboard-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_generic_tree_tag}/misc/opt-mali-rk3288-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-tinkerboard-armv7l.tar.gz
  rm -f downloads/opengl-wayland-tinkerboard-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${tinkerboard_generic_tree_tag}/misc/opt-mali-rk3288-wayland-armv7l.tar.gz -O downloads/opengl-wayland-tinkerboard-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "raspberry_pi" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-raspberry_pi-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_armv7l_release_version}/${raspberry_pi_armv7l_release_version}.tar.gz -O downloads/kernel-raspberry_pi-armv7l.tar.gz
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_armv7l_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_armv7l_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-mesa-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/mesa-etc-build/releases/download/${raspberry_pi_armv7l_mesa_release_version}/opt-mesa-armv7l-debian.tar.gz -O downloads/opengl-mesa-armv7l-debian.tar.gz
  rm -f downloads/opengl-mesa-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/mesa-etc-build/releases/download/${raspberry_pi_armv7l_mesa_release_version}/opt-mesa-armv7l-ubuntu.tar.gz -O downloads/opengl-mesa-armv7l-ubuntu.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "raspberry_pi" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-raspberry_pi-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_aarch64_release_version}/${raspberry_pi_aarch64_release_version}.tar.gz -O downloads/kernel-raspberry_pi-aarch64.tar.gz
  rm -f downloads/gl4es-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_aarch64_generic_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O downloads/gl4es-aarch64-debian.tar.gz
  rm -f downloads/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_aarch64_generic_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O downloads/gl4es-aarch64-ubuntu.tar.gz
  rm -f downloads/opengl-mesa-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/mesa-etc-build/releases/download/${raspberry_pi_aarch64_mesa_release_version}/opt-mesa-aarch64-debian.tar.gz -O downloads/opengl-mesa-aarch64-debian.tar.gz
  rm -f downloads/opengl-mesa-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/mesa-etc-build/releases/download/${raspberry_pi_aarch64_mesa_release_version}/opt-mesa-aarch64-ubuntu.tar.gz -O downloads/opengl-mesa-aarch64-ubuntu.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "raspberry_pi_4" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-raspberry_pi_4-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-raspberry-pi-4-kernel/releases/download/${raspberry_pi_4_armv7l_release_version}/${raspberry_pi_4_armv7l_release_version}.tar.gz -O downloads/kernel-raspberry_pi_4-armv7l.tar.gz
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_4_armv7l_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_4_armv7l_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-mesa-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/mesa-etc-build/releases/download/${raspberry_pi_4_armv7l_mesa_release_version}/opt-mesa-armv7l-debian.tar.gz -O downloads/opengl-mesa-armv7l-debian.tar.gz
  rm -f downloads/opengl-mesa-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/mesa-etc-build/releases/download/${raspberry_pi_4_armv7l_mesa_release_version}/opt-mesa-armv7l-ubuntu.tar.gz -O downloads/opengl-mesa-armv7l-ubuntu.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "raspberry_pi_4" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-raspberry_pi_4-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-raspberry-pi-4-kernel/releases/download/${raspberry_pi_4_aarch64_release_version}/${raspberry_pi_4_aarch64_release_version}.tar.gz -O downloads/kernel-raspberry_pi_4-aarch64.tar.gz
  rm -f downloads/gl4es-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_4_aarch64_generic_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O downloads/gl4es-aarch64-debian.tar.gz
  rm -f downloads/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${raspberry_pi_4_aarch64_generic_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O downloads/gl4es-aarch64-ubuntu.tar.gz
  rm -f downloads/opengl-mesa-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/mesa-etc-build/releases/download/${raspberry_pi_4_aarch64_mesa_release_version}/opt-mesa-aarch64-debian.tar.gz -O downloads/opengl-mesa-aarch64-debian.tar.gz
  rm -f downloads/opengl-mesa-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/mesa-etc-build/releases/download/${raspberry_pi_4_aarch64_mesa_release_version}/opt-mesa-aarch64-ubuntu.tar.gz -O downloads/opengl-mesa-aarch64-ubuntu.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "amlogic_gx" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-amlogic_gx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}.tar.gz -O downloads/kernel-amlogic_gx-armv7l.tar.gz
  rm -f downloads/kernel-mali-amlogic_gx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}-mali-s905.tar.gz -O downloads/kernel-mali-amlogic_gx-armv7l.tar.gz
  rm -f downloads/boot-amlogic_gx-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc.av8/u-boot/boot-odroid_c2-aarch64.dd -O downloads/boot-amlogic_gx-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-fbdev-amlogic_gx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/opt-mali-s905-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-amlogic_gx-armv7l.tar.gz
  rm -f downloads/opengl-wayland-amlogic_gx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/opt-mali-s905-wayland-armv7l.tar.gz -O downloads/opengl-wayland-amlogic_gx-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "amlogic_gx" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-amlogic_gx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}.tar.gz -O downloads/kernel-amlogic_gx-aarch64.tar.gz
  rm -f downloads/kernel-mali-amlogic_gx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${amlogic_gx_release_version}/${amlogic_gx_release_version}-mali-s905.tar.gz -O downloads/kernel-mali-amlogic_gx-aarch64.tar.gz
  rm -f downloads/boot-amlogic_gx-aarch64.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc.av8/u-boot/boot-odroid_c2-aarch64.dd -O downloads/boot-amlogic_gx-aarch64.dd
  rm -f downloads/gl4es-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O downloads/gl4es-aarch64-debian.tar.gz
  rm -f downloads/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O downloads/gl4es-aarch64-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/xorg-armsoc-aarch64-debian.tar.gz -O downloads/xorg-armsoc-aarch64-debian.tar.gz
  rm -f downloads/xorg-armsoc-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/xorg-armsoc-aarch64-ubuntu.tar.gz -O downloads/xorg-armsoc-aarch64-ubuntu.tar.gz
  rm -f downloads/opengl-amlogic_gx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/opt-mali-s905-aarch64.tar.gz -O downloads/opengl-amlogic_gx-aarch64.tar.gz
  rm -f downloads/opengl-fbdev-amlogic_gx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/opt-mali-s905-fbdev-aarch64.tar.gz -O downloads/opengl-fbdev-amlogic_gx-aarch64.tar.gz
  rm -f downloads/opengl-wayland-amlogic_gx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/opt-mali-s905-wayland-aarch64.tar.gz -O downloads/opengl-wayland-amlogic_gx-aarch64.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "allwinner_h6" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-allwinner_h6-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}.tar.gz -O downloads/kernel-allwinner_h6-armv7l.tar.gz
  rm -f downloads/kernel-mali-allwinner_h6-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}-mali-h6.tar.gz -O downloads/kernel-mali-allwinner_h6-armv7l.tar.gz
  rm -f downloads/boot-allwinner_h6-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h6_uboot_version}/boot-allwinner_h6-aarch64.dd.gz -O - | gunzip -c >> downloads/boot-allwinner_h6-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h6_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h6_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-fbdev-allwinner_h6-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/raw/${allwinner_h6_tree_tag}/misc.ah6//opt-mali-h6-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-allwinner_h6-armv7l.tar.gz
  rm -f downloads/opengl-wayland-allwinner_h6-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/raw/${allwinner_h6_tree_tag}/misc.ah6//opt-mali-h6-wayland-armv7l.tar.gz -O downloads/opengl-wayland-allwinner_h6-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "allwinner_h6" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-allwinner_h6-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}.tar.gz -O downloads/kernel-allwinner_h6-aarch64.tar.gz
  rm -f downloads/kernel-mali-allwinner_h6-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}-mali-h6.tar.gz -O downloads/kernel-mali-allwinner_h6-aarch64.tar.gz
  rm -f downloads/boot-allwinner_h6-aarch64.dd
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h6_uboot_version}/boot-allwinner_h6-aarch64.dd.gz -O - | gunzip -c >> downloads/boot-allwinner_h6-aarch64.dd
  rm -f downloads/gl4es-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h6_generic_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O downloads/gl4es-aarch64-debian.tar.gz
  rm -f downloads/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${allwinner_h6_generic_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O downloads/gl4es-aarch64-ubuntu.tar.gz
  rm -f downloads/opengl-fbdev-allwinner_h6-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/raw/${allwinner_h6_tree_tag}/misc.ah6//opt-mali-h6-fbdev-aarch64.tar.gz -O downloads/opengl-fbdev-allwinner_h6-aarch64.tar.gz
  rm -f downloads/opengl-wayland-allwinner_h6-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h3-h6-kernel/raw/${allwinner_h6_tree_tag}/misc.ah6//opt-mali-h6-wayland-aarch64.tar.gz -O downloads/opengl-wayland-allwinner_h6-aarch64.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "rockchip_rk33xx" ]) && [ "$2" = "armv7l" ]; then
  rm -f downloads/kernel-rockchip_rk33xx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}.tar.gz -O downloads/kernel-rockchip_rk33xx-armv7l.tar.gz
  rm -f downloads/kernel-mali-rockchip_rk33xx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}-mali-rk3328.tar.gz -O downloads/kernel-mali-rockchip_rk33xx-armv7l.tar.gz
  rm -f downloads/kernel-mali-b-rockchip_rk33xx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}-mali-rk3399.tar.gz -O downloads/kernel-mali-b-rockchip_rk33xx-armv7l.tar.gz
  rm -f downloads/boot-rockchip_rk33xx-armv7l.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/u-boot/boot-rk3328_tv_box-aarch64.dd -O downloads/boot-rockchip_rk33xx-armv7l.dd
  rm -f downloads/gl4es-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk33xx_generic_tree_tag}/misc/gl4es-armv7l-debian.tar.gz -O downloads/gl4es-armv7l-debian.tar.gz
  rm -f downloads/gl4es-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk33xx_generic_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O downloads/gl4es-armv7l-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk33xx_generic_tree_tag}/misc/xorg-armsoc-armv7l-debian.tar.gz -O downloads/xorg-armsoc-armv7l-debian.tar.gz
  rm -f downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk33xx_generic_tree_tag}/misc/xorg-armsoc-armv7l-ubuntu.tar.gz -O downloads/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f downloads/opengl-rockchip_rk33xx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc//opt-mali-rk3328-armv7l.tar.gz -O downloads/opengl-rockchip_rk33xx-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-rockchip_rk33xx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc//opt-mali-rk3328-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-rockchip_rk33xx-armv7l.tar.gz
  rm -f downloads/opengl-wayland-rockchip_rk33xx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/opt-mali-rk3328-wayland-armv7l.tar.gz -O downloads/opengl-wayland-rockchip_rk33xx-armv7l.tar.gz
  rm -f downloads/opengl-b-rockchip_rk33xx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/opt-mali-rk3399-armv7l.tar.gz -O downloads/opengl-b-rockchip_rk33xx-armv7l.tar.gz
  rm -f downloads/opengl-fbdev-b-rockchip_rk33xx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/opt-mali-rk3399-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-b-rockchip_rk33xx-armv7l.tar.gz
  rm -f downloads/opengl-wayland-b-rockchip_rk33xx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/opt-mali-rk3399-wayland-armv7l.tar.gz -O downloads/opengl-wayland-b-rockchip_rk33xx-armv7l.tar.gz
  # the amlogic fbdev mali blob works on rk3328 too in gl4es LIBGL_FB=3 mode while the rk3328 one does not
  rm -f downloads/opengl-fbdev-alt-rockchip_rk33xx-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/opt-mali-s905-fbdev-armv7l.tar.gz -O downloads/opengl-fbdev-alt-rockchip_rk33xx-armv7l.tar.gz
fi

if ([ "$1" = "all" ] || [ "$1" = "rockchip_rk33xx" ]) && [ "$2" = "aarch64" ]; then
  rm -f downloads/kernel-rockchip_rk33xx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}.tar.gz -O downloads/kernel-rockchip_rk33xx-aarch64.tar.gz
  rm -f downloads/kernel-mali-rockchip_rk33xx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}-mali-rk3328.tar.gz -O downloads/kernel-mali-rockchip_rk33xx-aarch64.tar.gz
  rm -f downloads/kernel-mali-b-rockchip_rk33xx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk33xx_release_version}/${rockchip_rk33xx_release_version}-mali-rk3399.tar.gz -O downloads/kernel-mali-b-alt-rockchip_rk33xx-aarch64.tar.gz
  rm -f downloads/boot-rockchip_rk33xx-aarch64.dd
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/u-boot/boot-rk3328_tv_box-aarch64.dd -O downloads/boot-rockchip_rk33xx-aarch64.dd
  rm -f downloads/gl4es-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk33xx_generic_tree_tag}/misc/gl4es-aarch64-debian.tar.gz -O downloads/gl4es-aarch64-debian.tar.gz
  rm -f downloads/gl4es-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk33xx_generic_tree_tag}/misc/gl4es-aarch64-ubuntu.tar.gz -O downloads/gl4es-aarch64-ubuntu.tar.gz
  rm -f downloads/xorg-armsoc-aarch64-debian.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk33xx_generic_tree_tag}/misc/xorg-armsoc-aarch64-debian.tar.gz -O downloads/xorg-armsoc-aarch64-debian.tar.gz
  rm -f downloads/xorg-armsoc-aarch64-ubuntu.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${rockchip_rk33xx_generic_tree_tag}/misc/xorg-armsoc-aarch64-ubuntu.tar.gz -O downloads/xorg-armsoc-aarch64-ubuntu.tar.gz
  rm -f downloads/opengl-rockchip_rk33xx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/opt-mali-rk3328-aarch64.tar.gz -O downloads/opengl-rockchip_rk33xx-aarch64.tar.gz
  rm -f downloads/opengl-fbdev-rockchip_rk33xx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/opt-mali-rk3328-fbdev-aarch64.tar.gz -O downloads/opengl-fbdev-rockchip_rk33xx-aarch64.tar.gz
  rm -f downloads/opengl-wayland-rockchip_rk33xx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/opt-mali-rk3328-wayland-aarch64.tar.gz -O downloads/opengl-wayland-rockchip_rk33xx-aarch64.tar.gz
  rm -f downloads/opengl-b-rockchip_rk33xx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/opt-mali-rk3399-aarch64.tar.gz -O downloads/opengl-b-rockchip_rk33xx-aarch64.tar.gz
  rm -f downloads/opengl-fbdev-b-rockchip_rk33xx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/opt-mali-rk3399-fbdev-aarch64.tar.gz -O downloads/opengl-fbdev-b-rockchip_rk33xx-aarch64.tar.gz
  rm -f downloads/opengl-wayland-b-rockchip_rk33xx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk33xx_tree_tag}/misc.rkc/opt-mali-rk3399-wayland-aarch64.tar.gz -O downloads/opengl-wayland-b-rockchip_rk33xx-aarch64.tar.gz
  # the amlogic fbdev mali blob works on rk3328 too in gl4es LIBGL_FB=3 mode while the rk3328 one does not
  rm -f downloads/opengl-fbdev-alt-rockchip_rk33xx-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_generic_tree_tag}/misc/opt-mali-s905-fbdev-aarch64.tar.gz -O downloads/opengl-fbdev-alt-rockchip_rk33xx-aarch64.tar.gz
fi
