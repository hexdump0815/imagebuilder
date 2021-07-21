#!/bin/bash

echo "" >> etc/pulse/default.pa
echo "# required for working pulseaudio on nyan big - audio input does not yet work well" >> etc/pulse/default.pa
echo "load-module module-alsa-sink device=hw:1" >> etc/pulse/default.pa
echo "#load-module module-alsa-source device=hw:1" >> etc/pulse/default.pa

# the v5.4 kernel does not work well together with the nouveau gpu driver, so disable it for now
cp -v etc/X11/xorg.conf.d.samples/11-no-glamor.conf etc/X11/xorg.conf.d
# in case the newer xorg server is used which is required for the nouveau gpu driver to work
# with the v5.10 kernel then this is required to make the chromebook keyboard work - this is
# just a hack for now and should be solved better in the future
#cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
#cp -v etc/X11/xorg.conf.d.samples/51-newer-xorg-chromebook-kbd.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d
