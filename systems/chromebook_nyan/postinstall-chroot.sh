#!/bin/bash

# disable default xorg server and use the own built one instead
apt-mark hold xserver-xorg-core
mv -v /usr/lib/xorg/Xorg /usr/lib/xorg/Xorg.org
ln -sv /opt/xserver/bin/Xorg /usr/lib/xorg/Xorg
