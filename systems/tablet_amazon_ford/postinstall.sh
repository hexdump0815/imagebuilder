#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-fbdev.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/31-monitor-no-dpms.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d

tar xzf postinstall/opt-msm-fb-refresher-${3}-armv7l.tar.gz
tar xzf postinstall/tablet_amazon_ford-firmware.tar.gz
