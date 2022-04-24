#!/bin/bash

# do not ask anything
export DEBIAN_FRONTEND=noninteractive

export LANG=C

systemctl enable ssh
systemctl disable fstrim.timer
if [ "${1}" != "bullseye" ]; then
  systemctl disable fwupd.service
  systemctl disable fwupd-refresh.service
fi

# do not use the default firefox snap package (too much bloat) but instead
# install firefox-esr (nicely in sync with what debian bullseye is using)
# from the mozilla teams ppa for it (with this there is also no pkg name
# conflict with the snap firefox version
# see: https://ubuntuhandbook.org/index.php/2022/03/install-firefox-esr-ubuntu/
# if the regular (non-esr) firefox is preferred, have a look at:
# https://fostips.com/ubuntu-21-10-two-firefox-remove-snap/
if [ "${1}" = "jammy" ]; then
  add-apt-repository -y ppa:mozillateam/ppa
  apt-get -yq install firefox-esr
fi

# this is required to make docker work on bullseye with the current kernels
# see https://wiki.debian.org/iptables
if [ "${1}" = "bullseye" ] || [ "${1}" = "jammy" ]; then
  update-alternatives --set iptables /usr/sbin/iptables-legacy
  update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
  update-alternatives --set arptables /usr/sbin/arptables-legacy
  update-alternatives --set ebtables /usr/sbin/ebtables-legacy
fi

# in case you want to enable automatic updates, just comment out the next lines
# TODO: not sure if the first two are still required
systemctl disable apt-daily
systemctl disable apt-daily-upgrade
systemctl disable apt-daily-upgrade.timer
if [ "${1}" != "bullseye" ]; then
  systemctl disable unattended-upgrades.service
  sed -i 's,Update-Package-Lists "1",Update-Package-Lists "0",g' /etc/apt/apt.conf.d/10periodic
  sed -i 's,Update-Package-Lists "1",Update-Package-Lists "0",g;s,Unattended-Upgrade "1",Unattended-Upgrade "0",g' /etc/apt/apt.conf.d/20auto-upgrades
fi

useradd -c ${2} -d /home/${2} -m -p '$6$sEhhlter$njAiCsaYr7lveaAQCmsABlrGbrVip/lcBUlY2M9DUHfaUh0zSLfcJ4mN0BDqH7bg/2BITbp7BK3qPf8zR.3Ad0' -s /bin/bash ${2}
usermod -a -G sudo ${2}
usermod -a -G audio ${2}
usermod -a -G video ${2}
usermod -a -G render ${2}

# setup locale info for en-us
sed -i 's,# en_US ISO-8859-1,en_US ISO-8859-1,g;s,# en_US.UTF-8 UTF-8,en_US.UTF-8 UTF-8,g' /etc/locale.gen
locale-gen

# remove snapd and dmidecode (only on ubuntu) as it crashes on some arm devices on boot
if [ "${1}" != "bullseye" ]; then
  apt-get -yq remove snapd dmidecode
fi

apt-get -yq auto-remove
apt-get clean

# hack to detect m8x via /boot/uEnv.ini to disable lightdm for it
# as it does not yet have a working hdmi output and lighdm would fail
if [ -f /boot/uEnv.ini ]; then
  systemctl disable lightdm
fi
