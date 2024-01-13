#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/31-monitor-rotate-right.conf etc/X11/xorg.conf.d
# in case the display should not be rotated, comment out the above line and also
# comment out the lines in /etc/udev/rules.d/90-android-touch-dev.rules
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d

# bookworm
if [ -f etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-off ]; then
  cp -v etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-off etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
# jammy and noble
elif [ -f etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-off ]; then
  cp -v etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-off etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
fi

# put the boot.img and initramfs-extra where the bootloader expects them
cp boot/boot.img-harpia-* boot/boot.img
cp boot/initramfs-extra-* boot/initramfs-extra

# this is required for the msm firmware loader
mkdir -p lib/firmware/msm-firmware-loader
