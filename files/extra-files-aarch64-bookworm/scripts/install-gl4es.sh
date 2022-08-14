#!/bin/bash

cd `dirname $0`
. versions.conf

cd /
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/raw/${gl4es_bookworm_aarch64_version}/misc/gl4es-aarch64-debian.tar.gz -O /tmp/gl4es-aarch64-bookworm.tar.gz
tar xzf /tmp/gl4es-aarch64-bookworm.tar.gz
rm -f /tmp/gl4es-aarch64-bookworm.tar.gz
