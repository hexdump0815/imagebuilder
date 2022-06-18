#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/13-lima-meson.conf etc/X11/xorg.conf.d

cp -v boot/extra/gxl-tv-box-u-boot.bin boot/u-boot.bin
