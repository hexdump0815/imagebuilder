#!/bin/bash

# this is no longer required due to the new and improved ucm files
#echo "" >> etc/pulse/default.pa
#echo "# required for working pulseaudio on peach - audio input does not yet work well" >> etc/pulse/default.pa
#echo "load-module module-alsa-sink device=sysdefault" >> etc/pulse/default.pa
#echo "#load-module module-alsa-source device=sysdefault" >> etc/pulse/default.pa

cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d

cp -v etc/X11/xorg.conf.d.samples/31-monitor-no-dpms.conf etc/X11/xorg.conf.d
# this is not set by default, as there were some drm unblank kernel errors
## bullseye
#if [ -f etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled ]; then
#  cp -v etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
## focal and jammy
#elif [ -f etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled ]; then
#  cp -v etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
#fi
