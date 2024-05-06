#!/bin/sh

export LANG=C

for rc in boot/bootmisc boot/hostname boot/modules boot/sysctl boot/swap boot/urandom boot/networking \
  sysinit/devfs sysinit/hwdrivers sysinit/mdev sysinit/modules shutdown/mount-ro shutdown/killprocs \
  default/dbus default/chronyd default/ntpd default/local default/sshd ; do
    ln -s /etc/init.d/"${rc##*/}" /etc/runlevels/"$rc"
done

adduser -g ${2} -h /home/${2} -s /bin/bash -D ${2}
echo -e "changeme\nchangeme" | passwd ${2}
adduser ${2} audio
adduser ${2} video
addgroup sudo
adduser ${2} sudo
sed -i 's,^# %sudo,%sudo,g' /etc/sudoers
sed -i 's,^root::,root:!:,g' /etc/shadow
