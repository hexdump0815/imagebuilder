#!/bin/bash

# remove and disable some things which are not needed or disturbing on this weak
# tablet with its legacy kernel to speed up the boot process
apt-get -yq remove --purge exim4-base exim4-daemon-light exim4-config libgnutls-dane0 libunbound8
systemctl disable lvm2-monitor.service lvm2-lvmpolld.socket
systemctl mask systemd-networkd-wait-online.service
systemctl mask NetworkManager-wait-online.service
systemctl mask serial-getty@ttyMT0.service
systemctl mask blueman-mechanism.service
systemctl mask bluetooth.service
