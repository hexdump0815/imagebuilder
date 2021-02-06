#!/bin/bash

cd `dirname $0`
. versions.conf

# exit on errors
set -e

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_mali_blob_version}/misc/opt-mali-s905-aarch64.tar.gz -O /tmp/opengl-amlogic_gx-aarch64.tar.gz
tar xzf /tmp/opengl-amlogic_gx-aarch64.tar.gz
rm -f /tmp/opengl-amlogic_gx-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_mali_blob_version}/misc/opt-mali-s905-fbdev-aarch64.tar.gz -O /tmp/opengl-fbdev-amlogic_gx-aarch64.tar.gz
tar xzf /tmp/opengl-fbdev-amlogic_gx-aarch64.tar.gz
rm -f /tmp/opengl-fbdev-amlogic_gx-aarch64.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${amlogic_gx_mali_blob_version}/misc/opt-mali-s905-wayland-aarch64.tar.gz -O /tmp/opengl-wayland-amlogic_gx-aarch64.tar.gz
tar xzf /tmp/opengl-wayland-amlogic_gx-aarch64.tar.gz
rm -f /tmp/opengl-wayland-amlogic_gx-aarch64.tar.gz
