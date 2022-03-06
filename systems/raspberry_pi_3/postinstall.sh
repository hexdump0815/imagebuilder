#!/bin/bash

echo "snd_bcm2835" >> etc/modules

cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d

cp -v postinstall/* boot
