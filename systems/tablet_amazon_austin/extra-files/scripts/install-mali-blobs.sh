#!/bin/bash

cd `dirname $0`
. versions.conf

# exit on errors
set -e

cd /
wget -v https://github.com/hexdump0815/linux-amazon-mediatek-mt8127-kernel/raw/${amazon_austin_mali_blob_version}/misc/opt-mali-meson-r4p0-armv7l.tar.gz -O /tmp/opengl-tablet_amazon_ford-armv7l.tar.gz
tar xzf /tmp/opengl-tablet_amazon_ford-armv7l.tar.gz
rm -f /tmp/opengl-tablet_amazon_ford-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-amazon-mediatek-mt8127-kernel/raw/${amazon_austin_mali_blob_version}/misc/opt-mali-meson-fbdev-r4p0-armv7l.tar.gz -O /tmp/opengl-fbdev-tablet_amazon_ford-armv7l.tar.gz
tar xzf /tmp/opengl-fbdev-tablet_amazon_ford-armv7l.tar.gz
rm -f /tmp/opengl-fbdev-tablet_amazon_ford-armv7l.tar.gz
