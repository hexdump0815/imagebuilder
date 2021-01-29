#!/bin/bash

cd `dirname $0`
. versions.conf

# exit on errors
set -e

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_mali_blob_version}/misc/opt-mali-exynos4412-armv7l.tar.gz -O /tmp/opengl-odroid_u3-armv7l.tar.gz
tar xzf /tmp/opengl-odroid_u3-armv7l.tar.gz
rm -f /tmp/opengl-odroid_u3-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${odroid_u3_mali_blob_version}/misc/opt-mali-exynos4412-fbdev-armv7l.tar.gz -O /tmp/opengl-fbdev-odroid_u3-armv7l.tar.gz
tar xzf /tmp/opengl-fbdev-odroid_u3-armv7l.tar.gz
rm -f /tmp/opengl-fbdev-odroid_u3-armv7l.tar.gz
