#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
# this is not needed anymore here as its done in /etc/lightdm/dellvenue8pro.sh already now
#cp -v etc/X11/xorg.conf.d.samples/31-monitor-no-dpms-rotate-right.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d
