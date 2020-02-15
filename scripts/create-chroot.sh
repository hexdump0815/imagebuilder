#!/bin/bash

# do not ask anything
export DEBIAN_FRONTEND=noninteractive

export LANG=C

apt-get update
apt-get -yq upgrade
if [ "$1" = "ubuntu" ]; then 
  apt-get -yq install locales vim openssh-server sudo net-tools ifupdown iputils-ping kmod less rsync u-boot-tools usbutils dosfstools mesa-utils mesa-utils-extra console-data xubuntu-desktop linux-firmware libreoffice lvm2 cryptsetup-bin
elif [ "$1" = "debian" ]; then 
  apt-get -yq install locales vim openssh-server sudo net-tools ifupdown iputils-ping kmod less rsync u-boot-tools usbutils dosfstools mesa-utils mesa-utils-extra console-data task-xfce-desktop xserver-xorg-input-synaptics blueman firmware-linux-free firmware-linux firmware-linux-nonfree firmware-brcm80211 firmware-samsung firmware-libertas pulseaudio pavucontrol lvm2 cryptsetup-bin
fi

systemctl enable ssh
systemctl disable fstrim.timer
# in case you want to disable automatic updates
#systemctl disable apt-daily
#systemctl disable apt-daily-upgrade

useradd -c linux -d /home/linux -m -p '$6$sEhhlter$njAiCsaYr7lveaAQCmsABlrGbrVip/lcBUlY2M9DUHfaUh0zSLfcJ4mN0BDqH7bg/2BITbp7BK3qPf8zR.3Ad0' -s /bin/bash linux
usermod -a -G sudo linux
usermod -a -G audio linux
usermod -a -G video linux

# setup locale info for en-us
sed -i 's,# en_US ISO-8859-1,en_US ISO-8859-1,g;s,# en_US.UTF-8 UTF-8,en_US.UTF-8 UTF-8,g' /etc/locale.gen
locale-gen

# remove dmidecode (only on ubuntu) as it crashes on some arm devices on boot
apt-get -yq remove dmidecode

apt-get -yq auto-remove
apt-get clean
