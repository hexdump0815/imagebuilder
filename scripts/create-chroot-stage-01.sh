#!/bin/bash

# do not ask anything
export DEBIAN_FRONTEND=noninteractive

export LANG=C

apt-get update
apt-get -yq upgrade
# slick greeter is required as the default one seems to have problems on 32bit systems
# see: https://bluesabre.org/2019/10/20/install-xubuntu-19-10-on-a-raspberry-pi-4/
# TODO: libllvm10 is here for the self built mesa, maybe it can go soon or already ...
if [ "$1" = "focal" ]; then 
  apt-get -yq install locales vim openssh-server ssh-askpass sudo net-tools ifupdown iputils-ping kmod less rsync u-boot-tools usbutils dosfstools mesa-utils mesa-utils-extra console-data xubuntu-desktop linux-firmware lvm2 cryptsetup-bin slick-greeter rsyslog btrfs-progs btrfs-compsize dialog libllvm10 cgpt liblz4-tool vboot-kernel-utils plymouth plymouth-label plymouth-theme-xubuntu-logo plymouth-theme-xubuntu-text xserver-xorg-video-fbdev xinput rfkill gnome-system-tools gnome-system-monitor
  # light-locker is broken in ubuntu focal after resume from suspend so remove it
  # the xfce internal locker works fine, so the locking functionality is still there
  apt-get -yq remove light-locker
elif [ "$1" = "bullseye" ]; then 
  apt-get -yq install locales vim openssh-server ssh-askpass sudo net-tools ifupdown iputils-ping kmod less rsync u-boot-tools usbutils dosfstools mesa-utils mesa-utils-extra console-data task-xfce-desktop xserver-xorg-input-synaptics blueman firmware-linux-free firmware-linux firmware-linux-nonfree firmware-misc-nonfree firmware-brcm80211 firmware-iwlwifi firmware-intel-sound firmware-samsung firmware-libertas firmware-realtek firmware-qcom-soc firmware-qcom-media firmware-atheros pulseaudio pavucontrol lvm2 cryptsetup-bin cryptsetup slick-greeter btrfs-progs btrfs-compsize dialog cgpt liblz4-tool vboot-kernel-utils bc plymouth plymouth-themes xserver-xorg-video-fbdev xinput rfkill curl onboard gnome-system-tools gnome-system-monitor
  tasksel install standard
# special focal config used as base for building sonaremin images
elif [ "$1" = "sonaremin" ]; then
  apt-get -yq install vim openssh-server qjackctl fluxbox xpra xvfb libgl1 rtirq-init sudo net-tools ifupdown iputils-ping isc-dhcp-client lxterminal kmod less rsync overlayroot u-boot-tools xinit xserver-xorg-input-libinput mingetty locales irqbalance usbutils mousepad alsa-utils matchbox-keyboard dosfstools a2jmidid samba avahi-daemon liblo7 libfftw3-3 unzip libcap2-bin xserver-xorg-legacy libllvm10 linux-firmware xinput rfkill parted libpulse0
fi
