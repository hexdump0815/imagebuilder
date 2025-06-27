#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
# as longs as there is only ciri for geralt we can just rotate the screen by default
cp -v etc/X11/xorg.conf.d.samples/31-monitor-rotate-left.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d
