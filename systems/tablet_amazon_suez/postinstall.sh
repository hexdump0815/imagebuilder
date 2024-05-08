#!/bin/bash

echo "" >> etc/pulse/default.pa
echo "# required for working pulseaudio on suez - audio input has not been tested yet" >> etc/pulse/default.pa
echo "load-module module-alsa-sink device=sysdefault" >> etc/pulse/default.pa
echo "#load-module module-alsa-source device=sysdefault" >> etc/pulse/default.pa

cp -v etc/X11/xorg.conf.d.samples/11-fbdev-rotate-right.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d

# bookworm and trixie
if [ -f etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled ]; then
  cp -v etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
# jammy and noble
elif [ -f etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled ]; then
  cp -v etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
fi

# install the kernel, initramfs, boot.img etc.
tar xhzf postinstall/boot-and-modules.tar.gz
