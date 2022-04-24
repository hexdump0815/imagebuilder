#!/bin/bash

#systemctl enable apt-daily
#systemctl enable apt-daily-upgrade
systemctl enable apt-daily-upgrade.timer
systemctl enable unattended-upgrades.service
sed -i 's,Update-Package-Lists "0",Update-Package-Lists "1",g' /etc/apt/apt.conf.d/10periodic
sed -i 's,Update-Package-Lists "0",Update-Package-Lists "1",g;s,Unattended-Upgrade "0",Unattended-Upgrade "1",g' /etc/apt/apt.conf.d/20auto-upgrades
