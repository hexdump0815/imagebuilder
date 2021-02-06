#!/bin/bash

cd `dirname $0`
. versions.conf

# exit on errors
set -e

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_mali_blob_version}/misc/opt-mali-exynos5250-armv7l.tar.gz -O /tmp/opengl-chromebook_snow-armv7l.tar.gz
tar xzf /tmp/opengl-chromebook_snow-armv7l.tar.gz
rm -f /tmp/opengl-chromebook_snow-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${chromebook_snow_mali_blob_version}/misc/opt-mali-exynos5250-fbdev-r5p0-armv7l.tar.gz -O /tmp/opengl-fbdev-chromebook_snow-armv7l.tar.gz
tar xzf /tmp/opengl-fbdev-chromebook_snow-armv7l.tar.gz
rm -f /tmp/opengl-fbdev-chromebook_snow-armv7l.tar.gz
