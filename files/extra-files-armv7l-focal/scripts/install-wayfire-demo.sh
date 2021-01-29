#!/bin/bash

cd `dirname $0`
. versions.conf

cd /
wget -v https://github.com/hexdump0815/wayfire-arm-build/releases/download/0.6.0.0/opt-wayfire-0.6.0.armv7l.tar.gz -O /tmp/wayfire.tar.gz
tar xzf /tmp/wayfire.tar.gz
rm -f /tmp/wayfire.tar.gz
mkdir /opt/wayfire-armv7l/sample-config
wget -v https://github.com/hexdump0815/wayfire-arm-build/releases/download/0.6.0.0/wayfire.ini -O /opt/wayfire-armv7l/sample-config/wayfire.ini
wget -v https://github.com/hexdump0815/wayfire-arm-build/releases/download/0.6.0.0/wf-shell.ini -O /opt/wayfire-armv7l/sample-config/wf-shell.ini
wget -v https://github.com/hexdump0815/wayfire-arm-build/releases/download/0.6.0.0/wayfire.desktop -O /usr/share/wayland-sessions/wayfire.desktop
