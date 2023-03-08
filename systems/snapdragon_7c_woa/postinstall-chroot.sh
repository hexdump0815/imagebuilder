#!/bin/bash

# not sure if this is really required
mkdir -p /lib/firmware/rmtfs
dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fs1
dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fs2
dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fsg
dd if=/dev/zero bs=1M count=2 of=/lib/firmware/rmtfs/modem_fsc

# install the qcom tools qrtr-ns and rmtfs
apt-get -y install protection-domain-mapper qrtr-tools rmtfs tqftpserv

# disable the pd-mapper for now as it maybe resets the usb on
# startup, which is not good for a usb rootfs ... not sure though
systemctl disable pd-mapper
