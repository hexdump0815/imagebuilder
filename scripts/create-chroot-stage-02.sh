#!/bin/bash

# do not ask anything
export DEBIAN_FRONTEND=noninteractive

export LANG=C

systemctl enable ssh
systemctl disable fstrim.timer
# # in case you want to disable automatic updates, just uncomment the next three lines
# #systemctl disable apt-daily
# #systemctl disable apt-daily-upgrade
# #systemctl disable unattended-upgrades.service
# in case you want to enable automatic updates, just comment out the next three lines
systemctl disable apt-daily
systemctl disable apt-daily-upgrade
systemctl disable unattended-upgrades.service

useradd -c ${2} -d /home/${2} -m -p '$6$sEhhlter$njAiCsaYr7lveaAQCmsABlrGbrVip/lcBUlY2M9DUHfaUh0zSLfcJ4mN0BDqH7bg/2BITbp7BK3qPf8zR.3Ad0' -s /bin/bash ${2}
usermod -a -G sudo ${2}
usermod -a -G audio ${2}
usermod -a -G video ${2}
usermod -a -G render ${2}

# setup locale info for en-us
sed -i 's,# en_US ISO-8859-1,en_US ISO-8859-1,g;s,# en_US.UTF-8 UTF-8,en_US.UTF-8 UTF-8,g' /etc/locale.gen
locale-gen

# remove snapd and dmidecode (only on ubuntu) as it crashes on some arm devices on boot
apt-get -yq remove snapd dmidecode

apt-get -yq auto-remove
apt-get clean

# hack to detect m8x via /boot/uEnv.ini to disable lightdm for it
# as it does not yet have a working hdmi output and lighdm would fail
if [ -f /boot/uEnv.ini ]; then
  systemctl disable lightdm
fi
