#!/bin/bash

systemctl enable fb-refresher

# mount /boot with noauto as due to this mount the booting sometimes hangs on this system
# /boot comes already mounted from the postmarketos initramfs used here anyway ...
sed -i 's,remount-ro 0 2,remount-ro,noauto 0 2,g' /etc/fstab

# remove and disable some things which are not needed or disturbing on this weak
# tablet with its legacy kernel to speed up the boot process
apt-get remove --purge exim4-base exim4-daemon-light exim4-config libgnutls-dane0 libunbound8
systemctl disable lvm2-monitor.service lvm2-lvmpolld.socket
systemctl mask systemd-networkd-wait-online.service
systemctl mask NetworkManager-wait-online.service
systemctl mask serial-getty@ttyMT0.service
systemctl mask blueman-mechanism.service
systemctl mask bluetooth.service
