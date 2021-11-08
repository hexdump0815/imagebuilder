#!/bin/bash

echo "" >> etc/pulse/default.pa
echo "# required for working pulseaudio on suez - audio input has not been tested yet" >> etc/pulse/default.pa
echo "load-module module-alsa-sink device=sysdefault" >> etc/pulse/default.pa
echo "#load-module module-alsa-source device=sysdefault" >> etc/pulse/default.pa

cp -v etc/X11/xorg.conf.d.samples/11-fbdev-rotate-right.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/31-monitor-no-dpms.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d
