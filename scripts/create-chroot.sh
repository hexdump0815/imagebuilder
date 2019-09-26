#!/bin/bash -x

# do not ask anything
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y upgrade
if [ "$1" = "ubuntu" ]; then 
  LANG=C apt-get -yq install locales vim openssh-server sudo net-tools ifupdown iputils-ping kmod less u-boot-tools usbutils dosfstools mesa-utils mesa-utils-extra console-data xubuntu-desktop linux-firmware libreoffice
elif [ "$1" = "debian" ]; then 
  LANG=C apt-get -yq install locales vim openssh-server sudo net-tools ifupdown iputils-ping kmod less u-boot-tools usbutils dosfstools mesa-utils mesa-utils-extra console-data task-xfce-desktop firmware-linux-free firmware-linux firmware-linux-nonfree pulseaudio pavucontrol
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
apt-get -y remove dmidecode

apt-get -y auto-remove
apt-get clean
