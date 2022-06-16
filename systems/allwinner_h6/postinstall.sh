#!/bin/bash

# for some strange reason mesa is broken on jammy - both the shipped 22.0 as well
# as the self built 22.1 is so full of display errors, that it is unuseable ...
# bullseye works quite well with the same versions - so disable gpu accel in this
# case - hopefully later versions of mesa will fix this
if [ "${3}" = "jammy" ]; then
  cp -v etc/X11/xorg.conf.d.samples/11-modesetting-no-glamor.conf etc/X11/xorg.conf.d
else
  cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
fi
cp -v etc/X11/xorg.conf.d.samples/31-monitor-no-dpms.conf etc/X11/xorg.conf.d
