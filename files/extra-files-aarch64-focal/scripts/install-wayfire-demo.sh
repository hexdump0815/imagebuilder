#!/bin/bash

cd `dirname $0`
. versions.conf

cd /
wget -v https://github.com/hexdump0815/wayfire-arm-build/releases/download/0.6.0.0/opt-wayfire-0.6.0.aarch64.tar.gz -O /tmp/wayfire.tar.gz
tar xzf /tmp/wayfire.tar.gz
rm -f /tmp/wayfire.tar.gz
mkdir /opt/wayfire/sample-config
wget -v https://github.com/hexdump0815/wayfire-arm-build/releases/download/0.6.0.0/wayfire.ini -O /opt/wayfire/sample-config/wayfire.ini
wget -v https://github.com/hexdump0815/wayfire-arm-build/releases/download/0.6.0.0/wf-shell.ini -O /opt/wayfire/sample-config/wf-shell.ini
wget -v https://github.com/hexdump0815/wayfire-arm-build/releases/download/0.6.0.0/wayfire.desktop -O /usr/share/wayland-sessions/wayfire.desktop
apt-get -y install libgtk-layer-shell0 libxcb-composite0 libxcb-xinput0
echo /opt/wayfire/lib/aarch64-linux-gnu > /etc/ld.so.conf.d/wayfire.conf
ldconfig
