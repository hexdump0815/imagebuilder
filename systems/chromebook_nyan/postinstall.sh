#!/bin/bash

# maybe this helps to improve the suspend situation a bit ...
echo "SuspendState=freeze" >> etc/systemd/sleep.conf

cp -v etc/X11/xorg.conf.d.samples/11-modesetting-no-glamor.conf etc/X11/xorg.conf.d
# the above line disables gpu support in xorg as with it enabled firefox is crashing
# to enable the gpu support please comment out the line above and uncomment the two
# lines below
#cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
#cp -v etc/X11/xorg.conf.d.samples/13-nouveau-nyan.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/31-monitor.conf etc/X11/xorg.conf.d

# bookworm and trixie
if [ -f etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled ]; then
  cp -v etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
# jammy and noble
elif [ -f etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled ]; then
  cp -v etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml-enabled etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
fi
