#!/bin/bash

cd `dirname $0`
. versions.conf

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${gl4es_focal_armv7l_tree_tag}/misc/gl4es-armv7l-ubuntu.tar.gz -O /tmp/gl4es-armv7l-focal.tar.gz
tar xzf /tmp/gl4es-armv7l-focal.tar.gz
rm -f /tmp/gl4es-armv7l-focal.tar.gz
