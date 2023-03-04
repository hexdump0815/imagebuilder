#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-fbdev.conf etc/X11/xorg.conf.d
# later after installing the firmware files from windows, this is used instead
#cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d
