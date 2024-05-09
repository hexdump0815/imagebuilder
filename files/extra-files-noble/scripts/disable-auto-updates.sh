#!/bin/bash

#systemctl disable apt-daily
#systemctl disable apt-daily-upgrade
systemctl disable apt-daily-upgrade.timer
systemctl disable unattended-upgrades.service
sed -i 's,Update-Package-Lists "1",Update-Package-Lists "0",g' /etc/apt/apt.conf.d/10periodic
sed -i 's,Update-Package-Lists "1",Update-Package-Lists "0",g;s,Unattended-Upgrade "1",Unattended-Upgrade "0",g' /etc/apt/apt.conf.d/20auto-upgrades
