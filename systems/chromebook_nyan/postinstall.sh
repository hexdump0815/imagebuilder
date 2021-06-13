#!/bin/bash

echo "" >> etc/pulse/default.pa
echo "# required for working pulseaudio on nyan big - audio input does not yet work well" >> etc/pulse/default.pa
echo "load-module module-alsa-sink device=hw:1" >> etc/pulse/default.pa
echo "#load-module module-alsa-source device=hw:1" >> etc/pulse/default.pa

cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d
