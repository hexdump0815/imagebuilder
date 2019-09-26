#!/bin/bash
#
# please run this script to fetch some large files from various github releases before starting to build images

if [ "$#" != "1" ]; then
  echo ""
  echo "usage: $0 chromebook_snow|odroid_u3|all"
  echo ""
  echo "examples: $0 odroid_u3"
  echo "          $0 all"
  echo ""
  exit 1
fi

cd `dirname $0`/..

if [ "$1" = "all" ] || [ "$1" = "chromebook_snow" ]; then
  rm -f boot/kernel-chromebook_snow-armv7l.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-samsung-snow-chromebook/releases/download/5.3.1-stb-cbe%2B/5.3.1-stb-cbe+.tar.gz -O boot/kernel-chromebook_snow-armv7l.tar.gz
  rm -f boot/boot-chromebook_snow-armv7l.dd
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-samsung-snow-chromebook/raw/master/misc.cbe/boot/boot-chromebook_snow-armv7l.dd -O boot/boot-chromebook_snow-armv7l.dd
  rm -f files/gl4es-armv7l-debian.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-samsung-snow-chromebook/raw/master/misc.cbe/gl4es-armv7l-debian.tar.gz -O files/gl4es-armv7l-debian.tar.gz
  rm -f files/gl4es-armv7l-ubuntu.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-samsung-snow-chromebook/raw/master/misc.cbe/gl4es-armv7l-ubuntu.tar.gz -O files/gl4es-armv7l-ubuntu.tar.gz
  rm -f files/xorg-armsoc-armv7l-debian.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-samsung-snow-chromebook/raw/master/misc.cbe/xorg-armsoc-armv7l-debian.tar.gz -O files/xorg-armsoc-armv7l-debian.tar.gz
  rm -f files/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-samsung-snow-chromebook/raw/master/misc.cbe/xorg-armsoc-armv7l-ubuntu.tar.gz -O files/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f files/opengl-chromebook_snow-armv7l.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-samsung-snow-chromebook/raw/master/misc.cbe/opt-mali-exynos5250.tar.gz -O files/opengl-chromebook_snow-armv7l.tar.gz
  rm -f files/opengl-fbdev-chromebook_snow-armv7l.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-samsung-snow-chromebook/raw/master/misc.cbe/opt-mali-exynos5250-fbdev-r5p0.tar.gz -O files/opengl-fbdev-chromebook_snow-armv7l.tar.gz
fi

if [ "$1" = "all" ] || [ "$1" = "odroid_u3" ]; then
  rm -f boot/kernel-odroid_u3-armv7l.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-odroid-u3/releases/download/5.3.1-stb-exy%2B/5.3.1-stb-exy+.tar.gz -O boot/kernel-odroid_u3-armv7l.tar.gz
  rm -f boot/boot-odroid_u3-armv7l.dd
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-odroid-u3/raw/master/misc.exy/u-boot/boot-odroid_u3-armv7l.dd -O boot/boot-odroid_u3-armv7l.dd
  rm -f files/gl4es-armv7l-debian.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-odroid-u3/raw/master/misc.exy/gl4es-armv7l-debian.tar.gz -O files/gl4es-armv7l-debian.tar.gz
  rm -f files/gl4es-armv7l-ubuntu.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-odroid-u3/raw/master/misc.exy/gl4es-armv7l-ubuntu.tar.gz -O files/gl4es-armv7l-ubuntu.tar.gz
  rm -f files/xorg-armsoc-armv7l-debian.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-odroid-u3/raw/master/misc.exy/xorg-armsoc-armv7l-debian.tar.gz -O files/xorg-armsoc-armv7l-debian.tar.gz
  rm -f files/xorg-armsoc-armv7l-ubuntu.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-odroid-u3/raw/master/misc.exy/xorg-armsoc-armv7l-ubuntu.tar.gz -O files/xorg-armsoc-armv7l-ubuntu.tar.gz
  rm -f files/opengl-odroid_u3-armv7l.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-odroid-u3/raw/master/misc.exy/opt-mali-exynos4412.tar.gz -O files/opengl-odroid_u3-armv7l.tar.gz
  rm -f files/opengl-fbdev-odroid_u3-armv7l.tar.gz
  wget -nv https://github.com/hexdump0815/linux-mainline-and-mali-on-odroid-u3/raw/master/misc.exy/opt-mali-exynos4412-fbdev.tar.gz -O files/opengl-fbdev-odroid_u3-armv7l.tar.gz
fi
