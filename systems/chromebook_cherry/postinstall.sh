#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/31-monitor-no-dpms.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d

# disable afbc in mesa until it is fixed from the kernel side
# see: https://github.com/velvet-os/imagebuilder/issues/314
echo 'PAN_MESA_DEBUG=”noafbc”' >> etc/environment
