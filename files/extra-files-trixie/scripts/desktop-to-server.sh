#!/bin/bash
#
# this script will trim down the installed system towards a more
# server oriented setup with all the ui, xorg, desktop etc. packages
# removed
#
# it has to be run as root and from either a console terminal or
# ssh session

systemctl stop lightdm
systemctl disable lightdm
apt-get remove --purge ssh-askpass mesa-utils mesa-utils-extra task-xfce-desktop xserver-xorg-input-synaptics blueman pulseaudio pavucontrol slick-greeter xserver-xorg-video-fbdev onboard gnome-system-tools gnome-system-monitor glmark2 libglib2.0-bin gnome-accessibility-themes gnome-themes-extra gnome-themes-extra-data gtk2-engines-pixbuf lightdm-gtk-greeter gnome-icon-theme pinentry-gnome3 libva-x11-2 x11-apps x11-common x11-session-utils x11-utils x11-xkb-utils x11-xserver-utils xorg alsa* bluez* colord* desktop* gir1* libasound* libgphoto* libgtk* libpango* libpixman* libsamplerate* libvte* libwayland* libx11* libxau6 libxc* libxd* libxext6 libxfixes* libxft* libxi* libxkb* libxmuu1 libxpm4 libxr* xauth xdg* xinput xkb-data
apt-get auto-remove

echo "consider doing an 'fstrim -av' now to improve performance of the sd/emmc again"
