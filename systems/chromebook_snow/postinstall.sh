#!/bin/bash

echo "" >> etc/pulse/default.pa
echo "# required for working pulseaudio on snow - audio input does not yet work well" >> etc/pulse/default.pa
echo "load-module module-alsa-sink device=sysdefault" >> etc/pulse/default.pa
echo "#load-module module-alsa-source device=sysdefault" >> etc/pulse/default.pa

# enable ucm v1 backwards compatibility for the snow ucm files
sed -i 's,Define.V1\ "",Define.V1 yes,g' usr/share/alsa/ucm2/ucm.conf

cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d
