#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
# use gxl as default
cp -v etc/X11/xorg.conf.d.samples/13-lima-meson-swapped-dri-nodes.conf etc/X11/xorg.conf.d

# use gxl as default
cp -v boot/extra/gxl-tv-box-u-boot.bin boot/efi/u-boot.bin
cp -v boot/efi/s905_autoscript-mmc boot/efi/s905_autoscript
