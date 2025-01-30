#!/bin/bash

# add some dummy firmware files to make firmware loading work in some setups
mkdir -p /lib/firmware/rmtfs
dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fs1
dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fs2
dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fsg
dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fsc

# install the qcom tools qrtr-ns and rmtfs
apt-get -y install protection-domain-mapper qrtr-tools rmtfs tqftpserv

# adjust the cmdline of rmtfs to read its files from /lib/firmware/rmtfs
sed -i 's,ExecStart=/usr/bin/rmtfs -r -P -s,ExecStart=/usr/bin/rmtfs -r -s -v -o /lib/firmware/rmtfs,g' /lib/systemd/system/rmtfs.service

# avoid updates of the rmtfs package so that the above change does not get overwritten
apt-mark hold rmtfs

# disable the pd-mapper for now, it can be enabled once the firmware is in place
systemctl disable pd-mapper
