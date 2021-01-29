#!/bin/bash

cd `dirname $0`
. versions.conf

# exit on errors
set -e

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${odroid_xu4_mali_blob_version}/misc.e54/opt-mali-exynos5422-armv7l.tar.gz -O /tmp/opengl-odroid_xu4-armv7l.tar.gz
tar xzf /tmp/opengl-odroid_xu4-armv7l.tar.gz
rm -f /tmp/opengl-odroid_xu4-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${odroid_xu4_mali_blob_version}/misc.e54/opt-mali-exynos5422-fbdev-armv7l.tar.gz -O /tmp/opengl-fbdev-odroid_xu4-armv7l.tar.gz
tar xzf /tmp/opengl-fbdev-odroid_xu4-armv7l.tar.gz
rm -f /tmp/opengl-fbdev-odroid_xu4-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-exynos5422-kernel/raw/${odroid_xu4_mali_blob_version}/misc.e54/opt-mali-exynos5422-wayland-armv7l.tar.gz -O /tmp/opengl-wayland-odroid_xu4-armv7l.tar.gz
tar xzf /tmp/opengl-wayland-odroid_xu4-armv7l.tar.gz
rm -f /tmp/opengl-wayland-odroid_xu4-armv7l.tar.gz
