#!/bin/bash

cd `dirname $0`
. versions.conf

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${gl4es_focal_aarch64_version}/misc/gl4es-aarch64-ubuntu.tar.gz -O /tmp/gl4es-aarch64-focal.tar.gz
tar xzf /tmp/gl4es-aarch64-focal.tar.gz
rm -f /tmp/gl4es-aarch64-focal.tar.gz
