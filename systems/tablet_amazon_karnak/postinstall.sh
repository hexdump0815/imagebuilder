#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-fbdev-rotate-right.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/31-monitor.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d

cp -v etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
