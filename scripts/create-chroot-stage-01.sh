#!/bin/bash

# do not ask anything
export DEBIAN_FRONTEND=noninteractive

export LANG=C

apt-get update
apt-get -yq upgrade
# slick greeter is required as the default one seems to have problems on 32bit systems
# see: https://bluesabre.org/2019/10/20/install-xubuntu-19-10-on-a-raspberry-pi-4/
if [ "$1" = "focal" ]; then 
  apt-get -yq install locales vim openssh-server sudo net-tools ifupdown iputils-ping kmod less rsync u-boot-tools usbutils dosfstools mesa-utils mesa-utils-extra console-data xubuntu-desktop linux-firmware lvm2 cryptsetup-bin slick-greeter rsyslog btrfs-progs btrfs-compsize
elif [ "$1" = "buster" ]; then 
  apt-get -yq install locales vim openssh-server sudo net-tools ifupdown iputils-ping kmod less rsync u-boot-tools usbutils dosfstools mesa-utils mesa-utils-extra console-data task-xfce-desktop xserver-xorg-input-synaptics blueman firmware-linux-free firmware-linux firmware-linux-nonfree firmware-brcm80211 firmware-samsung firmware-libertas pulseaudio pavucontrol lvm2 cryptsetup-bin slick-greeter btrfs-progs btrfs-compsize
fi
