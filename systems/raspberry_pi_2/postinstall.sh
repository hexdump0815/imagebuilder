#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d

mv -v boot/extra/rpi_2-u-boot.bin boot/kernel.img
rmdir boot/extra
