#!/bin/bash

rm -rf /opt/wayfire
rm -f /usr/share/wayland-sessions/wayfire.desktop
apt-get -y remove --purge libgtk-layer-shell0 libxcb-composite0 libxcb-xinput0
rm -f /etc/ld.so.conf.d/wayfire.conf
ldconfig
