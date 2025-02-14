#!/bin/bash

# just put some generic xorg.conf there although xorg does not make sense here yet
# as the lima gpu driver seems to have problems on some boxes, lets disable it by default
cp -v etc/X11/xorg.conf.d.samples/11-modesetting-no-glamor.conf etc/X11/xorg.conf.d
#cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
#cp -v etc/X11/xorg.conf.d.samples/13-lima-meson-swapped-dri-nodes.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/31-monitor-16bit-no-dpms.conf etc/X11/xorg.conf.d
